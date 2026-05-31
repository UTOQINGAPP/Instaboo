import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';
import 'package:intl/intl.dart';

// ─── Filter state ─────────────────────────────────────────────────────────────

/// Holds the active filter selections for the history page.
/// Contiene las selecciones de filtro activas para la página de historial.
final class HistoryFilterState {
  final String? status; // null = all | 'success' | 'failed' | 'cancelled'
  final DateTimeRange? dateRange;
  final String searchText;
  final int? categoryId;
  final int? packId;
  final String? installerType;

  /// Hostname filter — null means all machines.
  /// Filtro de hostname — null significa todos los equipos.
  final String? hostname;

  const HistoryFilterState({
    this.status,
    this.dateRange,
    this.searchText = '',
    this.categoryId,
    this.packId,
    this.installerType,
    this.hostname,
  });

  bool get isActive =>
      status != null ||
      dateRange != null ||
      searchText.isNotEmpty ||
      categoryId != null ||
      packId != null ||
      installerType != null ||
      hostname != null;

  HistoryFilterState copyWith({
    Object? status = _sentinel,
    Object? dateRange = _sentinel,
    String? searchText,
    Object? categoryId = _sentinel,
    Object? packId = _sentinel,
    Object? installerType = _sentinel,
    Object? hostname = _sentinel,
  }) =>
      HistoryFilterState(
        status: status == _sentinel ? this.status : status as String?,
        dateRange:
            dateRange == _sentinel ? this.dateRange : dateRange as DateTimeRange?,
        searchText: searchText ?? this.searchText,
        categoryId:
            categoryId == _sentinel ? this.categoryId : categoryId as int?,
        packId: packId == _sentinel ? this.packId : packId as int?,
        installerType: installerType == _sentinel
            ? this.installerType
            : installerType as String?,
        hostname:
            hostname == _sentinel ? this.hostname : hostname as String?,
      );

  static const _sentinel = Object();
}

// ─── Contextual stats ─────────────────────────────────────────────────────────

final class ContextualStats {
  final int total;
  final int success;
  final int failed;
  final int cancelled;
  final double successRate;
  final Duration? avgDuration;

  const ContextualStats({
    required this.total,
    required this.success,
    required this.failed,
    required this.cancelled,
    required this.successRate,
    this.avgDuration,
  });

  factory ContextualStats.fromList(List<HistoryDataRule> items) {
    if (items.isEmpty) {
      return const ContextualStats(
        total: 0,
        success: 0,
        failed: 0,
        cancelled: 0,
        successRate: 0,
      );
    }
    final s = items.where((i) => i.status == 'success').length;
    final f = items.where((i) => i.status == 'failed').length;
    final c = items.where((i) => i.status == 'cancelled').length;
    final denominator = s + f;
    final rate = denominator == 0 ? 0.0 : (s / denominator) * 100;
    final durations = items.map((i) => i.duration.inSeconds).toList();
    final avg = durations.isEmpty
        ? null
        : Duration(seconds: (durations.reduce((a, b) => a + b) / durations.length).round());
    return ContextualStats(
      total: items.length,
      success: s,
      failed: f,
      cancelled: c,
      successRate: rate,
      avgDuration: avg,
    );
  }
}

// ─── View state ───────────────────────────────────────────────────────────────

final class HistoryViewState {
  final List<HistoryDataRule> allHistory;
  final List<HistoryDataRule> filtered;
  final Map<String, List<HistoryDataRule>> groupedByDate;
  final ContextualStats stats;
  final HistoryFilterState filter;

  // Reference data for filters.
  final List<CategoryDataRule> categories;
  final Map<int, String> packNames; // packId → name
  final Map<int, int?> softwareCategoryMap; // softwareId → categoryId
  final List<String> availableInstallerTypes;

  /// Unique hostnames found across the full history (sorted).
  /// Hostnames únicos encontrados en todo el historial (ordenados).
  final List<String> availableHostnames;

  const HistoryViewState({
    required this.allHistory,
    required this.filtered,
    required this.groupedByDate,
    required this.stats,
    required this.filter,
    required this.categories,
    required this.packNames,
    required this.softwareCategoryMap,
    required this.availableInstallerTypes,
    required this.availableHostnames,
  });

  HistoryViewState withFilter(HistoryFilterState newFilter) {
    var list = allHistory;

    if (newFilter.status != null) {
      list = list.where((h) => h.status == newFilter.status).toList();
    }

    if (newFilter.dateRange != null) {
      final start = DateTime(
        newFilter.dateRange!.start.year,
        newFilter.dateRange!.start.month,
        newFilter.dateRange!.start.day,
      );
      final end = DateTime(
        newFilter.dateRange!.end.year,
        newFilter.dateRange!.end.month,
        newFilter.dateRange!.end.day,
        23, 59, 59,
      );
      list = list
          .where(
            (h) =>
                !h.completedAt.toLocal().isBefore(start) &&
                !h.completedAt.toLocal().isAfter(end),
          )
          .toList();
    }

    if (newFilter.searchText.isNotEmpty) {
      final q = newFilter.searchText.toLowerCase();
      list = list
          .where((h) => h.softwareName.toLowerCase().contains(q))
          .toList();
    }

    if (newFilter.categoryId != null) {
      list = list
          .where(
            (h) =>
                h.softwareId != null &&
                softwareCategoryMap[h.softwareId] == newFilter.categoryId,
          )
          .toList();
    }

    if (newFilter.packId != null) {
      list = list.where((h) => h.packId == newFilter.packId).toList();
    }

    if (newFilter.installerType != null) {
      list = list
          .where((h) => h.installerType == newFilter.installerType)
          .toList();
    }

    if (newFilter.hostname != null) {
      list = list
          .where((h) => h.hostname == newFilter.hostname)
          .toList();
    }

    return HistoryViewState(
      allHistory: allHistory,
      filtered: list,
      groupedByDate: _groupByDate(list),
      stats: ContextualStats.fromList(list),
      filter: newFilter,
      categories: categories,
      packNames: packNames,
      softwareCategoryMap: softwareCategoryMap,
      availableInstallerTypes: availableInstallerTypes,
      availableHostnames: availableHostnames,
    );
  }

  static Map<String, List<HistoryDataRule>> _groupByDate(
    List<HistoryDataRule> items,
  ) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final groups = <String, List<HistoryDataRule>>{};

    for (final item in items) {
      final local = item.completedAt.toLocal();
      final localDate = DateTime(local.year, local.month, local.day);
      final diff = todayDate.difference(localDate).inDays;

      final String label;
      if (diff == 0) {
        label = 'Hoy';
      } else if (diff == 1) {
        label = 'Ayer';
      } else {
        label = DateFormat('dd/MM/yyyy').format(localDate);
      }

      groups.putIfAbsent(label, () => []).add(item);
    }

    return groups;
  }
}

// ─── Notifier ─────────────────────────────────────────────────────────────────

class HistoryPageNotifier extends AsyncNotifier<HistoryViewState> {
  @override
  Future<HistoryViewState> build() async {
    final installConsumer = ref.read(installationConsumerInjectionProvider);
    final catConsumer = ref.read(categoriesConsumerInjectionProvider);
    final swConsumer = ref.read(softwareConsumerInjectionProvider);
    final packConsumer = ref.read(packsConsumerInjectionProvider);

    // Start all four in parallel before awaiting any.
    // Inicia los cuatro en paralelo antes de esperar alguno.
    final histFuture = installConsumer.getHistory();
    final catFuture = catConsumer.getAll();
    final swFuture = swConsumer.getAll();
    final packFuture = packConsumer.getAll();

    final histResp = await histFuture;
    final catResp = await catFuture;
    final swResp = await swFuture;
    final packResp = await packFuture;

    final history = histResp.resolve(
      onSuccess: (data, _) => data,
      onFailure: (_, _) => <HistoryDataRule>[],
    );

    final categories = catResp.resolve(
      onSuccess: (data, _) =>
          data.where((c) => c.name != 'No category').toList(),
      onFailure: (_, _) => <CategoryDataRule>[],
    );

    final software = swResp.resolve(
      onSuccess: (data, _) => data,
      onFailure: (_, _) => <SoftwareDataRule>[],
    );

    final packs = packResp.resolve(
      onSuccess: (data, _) => data,
      onFailure: (_, _) => <PackDataRule>[],
    );

    // Build softwareId → categoryId lookup.
    final swCatMap = <int, int?>{
      for (final sw in software) sw.id: sw.categoryId,
    };

    // Build packId → name lookup (only packs that appear in history).
    final historyPackIds = history.map((h) => h.packId).whereType<int>().toSet();
    final packNames = <int, String>{
      for (final p in packs)
        if (historyPackIds.contains(p.id)) p.id: p.name,
    };

    // Extract unique installer types present in history.
    final installerTypes = history
        .map((h) => h.installerType)
        .whereType<String>()
        .toSet()
        .toList()
      ..sort();

    // Extract unique hostnames present in history.
    final hostnames = history
        .map((h) => h.hostname)
        .whereType<String>()
        .toSet()
        .toList()
      ..sort();

    const initialFilter = HistoryFilterState();

    return HistoryViewState(
      allHistory: history,
      filtered: history,
      groupedByDate: HistoryViewState._groupByDate(history),
      stats: ContextualStats.fromList(history),
      filter: initialFilter,
      categories: categories,
      packNames: packNames,
      softwareCategoryMap: swCatMap,
      availableInstallerTypes: installerTypes,
      availableHostnames: hostnames,
    );
  }

  void applyFilter(HistoryFilterState filter) {
    if (!state.hasValue) return;
    state = AsyncData(state.value!.withFilter(filter));
  }

  void refresh() => ref.invalidateSelf();
}

final historyPageNotifierProvider =
    AsyncNotifierProvider.autoDispose<HistoryPageNotifier, HistoryViewState>(
  HistoryPageNotifier.new,
);

// ─── Page ───────────────────────────────────────────────────────────────────────

class HistoryPageLibrary extends ConsumerWidget {
  const HistoryPageLibrary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(historyPageNotifierProvider);

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ───────────────────────────────────────────────────────
            _Header(
              onRefresh: () =>
                  ref.read(historyPageNotifierProvider.notifier).refresh(),
            ),
            const SizedBox(height: 16),

            asyncState.when(
              loading: () => const Expanded(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, _) => Expanded(
                child: _ErrorView(
                  error: err.toString(),
                  onRetry: () =>
                      ref.read(historyPageNotifierProvider.notifier).refresh(),
                ),
              ),
              data: (viewState) => _HistoryContent(viewState: viewState),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final VoidCallback onRefresh;
  const _Header({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Historial de instalaciones',
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Registro acumulado de todas las instalaciones realizadas.',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onRefresh,
          icon: const Icon(Icons.refresh, color: Colors.white70),
          tooltip: 'Actualizar',
        ),
      ],
    );
  }
}

// ─── Error view ───────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const _ErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent, size: 40),
          const SizedBox(height: 12),
          Text(
            'Error al cargar historial:\n$error',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}

// ─── Main content ─────────────────────────────────────────────────────────────

class _HistoryContent extends ConsumerWidget {
  final HistoryViewState viewState;
  const _HistoryContent({required this.viewState});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasHostnames = viewState.availableHostnames.isNotEmpty;

    void applyFilter(HistoryFilterState f) =>
        ref.read(historyPageNotifierProvider.notifier).applyFilter(f);

    // ── Right-panel content (filter + list) ──────────────────────────────────
    Widget rightPanel = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FilterBar(
          filter: viewState.filter,
          categories: viewState.categories,
          packNames: viewState.packNames,
          installerTypes: viewState.availableInstallerTypes,
          hostnames: viewState.availableHostnames,
          onChanged: applyFilter,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            if (viewState.filter.isActive)
              Expanded(
                child: _ResultBadge(
                  count: viewState.filtered.length,
                  total: viewState.allHistory.length,
                ),
              )
            else
              const Spacer(),
            if (viewState.filtered.isNotEmpty)
              TextButton.icon(
                onPressed: () => _exportCsv(context, viewState.filtered),
                icon: const Icon(Icons.download_outlined,
                    size: 16, color: Colors.white70),
                label: const Text(
                  'Exportar CSV',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: viewState.filtered.isEmpty
              ? _EmptyState(isFiltered: viewState.filter.isActive)
              : _GroupedHistoryList(
                  groupedByDate: viewState.groupedByDate,
                  packNames: viewState.packNames,
                ),
        ),
      ],
    );

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Stats row (always full width) ──────────────────────────────────
          _StatsRow(stats: viewState.stats),
          const SizedBox(height: 16),

          // ── Two-panel layout ───────────────────────────────────────────────
          Expanded(
            child: hasHostnames
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: hostname panel
                      _HostnamePanel(
                        hostnames: viewState.availableHostnames,
                        selected: viewState.filter.hostname,
                        onSelected: (h) =>
                            applyFilter(viewState.filter.copyWith(hostname: h)),
                      ),
                      const VerticalDivider(
                          width: 1, color: Colors.white12),
                      const SizedBox(width: 16),
                      // Right: filters + list
                      Expanded(child: rightPanel),
                    ],
                  )
                : rightPanel,
          ),
        ],
      ),
    );
  }
}

// ─── CSV export ───────────────────────────────────────────────────────────────

/// Generates a CSV file from [items] and saves it to the user's Documents
/// folder. Shows a SnackBar with the path on success or an error message.
///
/// Genera un CSV desde [items] y lo guarda en Documentos.
/// Muestra un SnackBar con la ruta en éxito o un mensaje de error.
Future<void> _exportCsv(
    BuildContext context, List<HistoryDataRule> items) async {
  final fmt = DateFormat('yyyy-MM-dd HH:mm:ss');
  final ts = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

  // Build CSV content first (synchronous, no await needed).
  String esc(String? s) {
    if (s == null || s.isEmpty) return '';
    return '"${s.replaceAll('"', '""')}"';
  }

  final header = 'Software,Estado,Iniciado,Completado,Duración (s),Error,Equipo\n';
  final rows = items.map((h) => [
        esc(h.softwareName),
        esc(h.status),
        esc(fmt.format(h.startedAt.toLocal())),
        esc(fmt.format(h.completedAt.toLocal())),
        h.duration.inSeconds.toString(),
        esc(h.errorDetails),
        esc(h.hostname),
      ].join(',')).join('\n');
  final content = header + rows;

  // Ask the user where to save via the native save dialog.
  // Pide al usuario dónde guardar usando el diálogo de guardado nativo.
  final savePath = await FilePicker.platform.saveFile(
    dialogTitle: 'Guardar historial como CSV',
    fileName: 'instaboo_historial_$ts.csv',
    type: FileType.custom,
    allowedExtensions: ['csv'],
  );

  if (savePath == null) return; // user cancelled

  try {
    // Write UTF-8 with BOM so Excel opens accents correctly on Windows.
    // Escribe UTF-8 con BOM para que Excel abra acentos correctamente.
    final bom = '﻿';
    await File(savePath).writeAsString(bom + content, encoding: utf8);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('CSV guardado en: $savePath'),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar: $e'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

// ─── Hostname panel ───────────────────────────────────────────────────────────

/// Left-side panel that lists all hostnames found in history.
/// Clicking a hostname filters the list; clicking again (or "Todos") clears it.
///
/// Panel izquierdo que lista los hostnames encontrados en el historial.
class _HostnamePanel extends StatelessWidget {
  final List<String> hostnames;
  final String? selected;
  final ValueChanged<String?> onSelected;

  const _HostnamePanel({
    required this.hostnames,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Widget item({
      required String label,
      required bool isSelected,
      required VoidCallback onTap,
      IconData icon = Icons.computer,
    }) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(color: Colors.white24)
                : null,
          ),
          child: Row(
            children: [
              Icon(icon,
                  size: 16,
                  color: isSelected ? Colors.white : Colors.white54),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: textTheme.bodySmall?.copyWith(
                    color: isSelected ? Colors.white : Colors.white70,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: 188,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Text(
              'Equipos',
              style: textTheme.labelSmall?.copyWith(
                color: Colors.white38,
                letterSpacing: 0.8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // "Todos" entry
          item(
            label: 'Todos',
            isSelected: selected == null,
            icon: Icons.devices,
            onTap: () => onSelected(null),
          ),
          const SizedBox(height: 4),
          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 4),
          // One entry per hostname
          Expanded(
            child: ListView.separated(
              itemCount: hostnames.length,
              separatorBuilder: (context, i) => const SizedBox(height: 2),
              itemBuilder: (_, i) {
                final h = hostnames[i];
                return item(
                  label: h,
                  isSelected: selected == h,
                  onTap: () => onSelected(selected == h ? null : h),
                );
              },
            ),
          ),
        ],
        ),
      ),
    );
  }
}

// ─── Stats row ────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final ContextualStats stats;
  const _StatsRow({required this.stats});

  @override
  Widget build(BuildContext context) {
    String? avgStr;
    final avg = stats.avgDuration;
    if (avg != null) {
      avgStr = avg.inSeconds < 60
          ? '${avg.inSeconds}s'
          : '${avg.inMinutes}m ${avg.inSeconds % 60}s';
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _StatCard(
          icon: Icons.list_alt,
          iconColor: Colors.white70,
          label: 'Total',
          value: stats.total.toString(),
        ),
        _StatCard(
          icon: Icons.check_circle_outline,
          iconColor: Colors.greenAccent,
          label: 'Completados',
          value: stats.success.toString(),
        ),
        _StatCard(
          icon: Icons.error_outline,
          iconColor: Colors.redAccent,
          label: 'Fallidos',
          value: stats.failed.toString(),
        ),
        _StatCard(
          icon: Icons.cancel_outlined,
          iconColor: Colors.orangeAccent,
          label: 'Cancelados',
          value: stats.cancelled.toString(),
        ),
        _StatCard(
          icon: Icons.percent,
          iconColor: Colors.blueAccent,
          label: 'Tasa de éxito',
          value: '${stats.successRate.toStringAsFixed(1)}%',
        ),
        if (avgStr != null)
          _StatCard(
            icon: Icons.timer_outlined,
            iconColor: Colors.purpleAccent,
            label: 'Duración media',
            value: avgStr,
          ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      color: Colors.white.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 26),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  label,
                  style: textTheme.bodySmall?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Filter bar ───────────────────────────────────────────────────────────────

class _FilterBar extends StatefulWidget {
  final HistoryFilterState filter;
  final List<CategoryDataRule> categories;
  final Map<int, String> packNames;
  final List<String> installerTypes;
  final List<String> hostnames;
  final ValueChanged<HistoryFilterState> onChanged;

  const _FilterBar({
    required this.filter,
    required this.categories,
    required this.packNames,
    required this.installerTypes,
    required this.hostnames,
    required this.onChanged,
  });

  @override
  State<_FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<_FilterBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController =
        TextEditingController(text: widget.filter.searchText);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _emit(HistoryFilterState f) => widget.onChanged(f);

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: widget.filter.dateRange,
      locale: const Locale('es'),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      _emit(widget.filter.copyWith(dateRange: picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    final f = widget.filter;
    final textTheme = Theme.of(context).textTheme;

    // Date range label
    String dateLabel = 'Fecha';
    if (f.dateRange != null) {
      final fmt = DateFormat('dd/MM/yy');
      dateLabel =
          '${fmt.format(f.dateRange!.start)} – ${fmt.format(f.dateRange!.end)}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Row 1: search + date + clear ─────────────────────────────────────
        Row(
          children: [
            // Search field
            Expanded(
              child: SizedBox(
                height: 38,
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Buscar software…',
                    hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                    prefixIcon: const Icon(Icons.search, color: Colors.white38, size: 18),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close, size: 16),
                            color: Colors.white38,
                            onPressed: () {
                              _searchController.clear();
                              _emit(f.copyWith(searchText: ''));
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.08),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (v) => _emit(f.copyWith(searchText: v)),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Date range button
            _FilterChipButton(
              label: dateLabel,
              icon: Icons.date_range,
              isActive: f.dateRange != null,
              onTap: _pickDateRange,
              onClear: f.dateRange != null
                  ? () => _emit(f.copyWith(dateRange: null))
                  : null,
            ),
            const SizedBox(width: 8),

            // Clear all button
            if (f.isActive)
              TextButton.icon(
                onPressed: () {
                  _searchController.clear();
                  _emit(const HistoryFilterState());
                },
                icon: const Icon(Icons.filter_alt_off, size: 16),
                label: const Text('Limpiar', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(foregroundColor: Colors.white54),
              ),
          ],
        ),

        const SizedBox(height: 8),

        // ── Row 2: status chips + category + pack + installerType ─────────
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Status chips
              Text(
                'Estado:',
                style: textTheme.bodySmall?.copyWith(color: Colors.white54, fontSize: 12),
              ),
              const SizedBox(width: 6),
              _StatusChip(
                label: 'Todos',
                selected: f.status == null,
                onTap: () => _emit(f.copyWith(status: null)),
              ),
              const SizedBox(width: 4),
              _StatusChip(
                label: 'Completado',
                color: Colors.greenAccent,
                selected: f.status == 'success',
                onTap: () => _emit(f.copyWith(status: 'success')),
              ),
              const SizedBox(width: 4),
              _StatusChip(
                label: 'Fallido',
                color: Colors.redAccent,
                selected: f.status == 'failed',
                onTap: () => _emit(f.copyWith(status: 'failed')),
              ),
              const SizedBox(width: 4),
              _StatusChip(
                label: 'Cancelado',
                color: Colors.orangeAccent,
                selected: f.status == 'cancelled',
                onTap: () => _emit(f.copyWith(status: 'cancelled')),
              ),

              if (widget.categories.isNotEmpty) ...[
                const SizedBox(width: 12),
                _DropdownFilter<int>(
                  hint: 'Categoría',
                  value: f.categoryId,
                  items: {
                    for (final c in widget.categories) c.id: c.name,
                  },
                  onChanged: (v) => _emit(f.copyWith(categoryId: v)),
                ),
              ],

              if (widget.packNames.isNotEmpty) ...[
                const SizedBox(width: 8),
                _DropdownFilter<int>(
                  hint: 'Pack',
                  value: f.packId,
                  items: widget.packNames,
                  onChanged: (v) => _emit(f.copyWith(packId: v)),
                ),
              ],

              if (widget.installerTypes.isNotEmpty) ...[
                const SizedBox(width: 8),
                _DropdownFilter<String>(
                  hint: 'Instalador',
                  value: f.installerType,
                  items: {for (final t in widget.installerTypes) t: t},
                  onChanged: (v) => _emit(f.copyWith(installerType: v)),
                ),
              ],

              // Hostname filter moved to left-panel sidebar (see _HostnamePanel).
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Filter helpers ───────────────────────────────────────────────────────────

class _FilterChipButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  const _FilterChipButton({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.blueAccent.withValues(alpha: 0.25)
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? Colors.blueAccent : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: isActive ? Colors.blueAccent : Colors.white54,
                size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.blueAccent : Colors.white54,
                fontSize: 12,
              ),
            ),
            if (onClear != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onClear,
                child: const Icon(Icons.close, size: 14, color: Colors.blueAccent),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color? color;
  final bool selected;
  final VoidCallback onTap;

  const _StatusChip({
    required this.label,
    this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? Colors.white70;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: selected
              ? activeColor.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? activeColor : Colors.white24,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? activeColor : Colors.white54,
            fontSize: 12,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _DropdownFilter<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final Map<T, String> items;
  final ValueChanged<T?> onChanged;

  const _DropdownFilter({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = value != null;
    final label = isActive ? items[value] ?? hint : hint;

    return PopupMenuButton<T?>(
      onSelected: onChanged,
      color: const Color(0xFF1E1E2E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      offset: const Offset(0, 36),
      itemBuilder: (_) => [
        PopupMenuItem<T?>(
          value: null,
          child: Text(
            'Todos',
            style: TextStyle(
              color: value == null ? Colors.white : Colors.white54,
              fontSize: 12,
            ),
          ),
        ),
        ...items.entries.map(
          (e) => PopupMenuItem<T?>(
            value: e.key,
            child: Text(
              e.value,
              style: TextStyle(
                color: value == e.key ? Colors.blueAccent : Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.blueAccent.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? Colors.blueAccent : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.blueAccent : Colors.white54,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              size: 16,
              color: isActive ? Colors.blueAccent : Colors.white38,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Result badge ─────────────────────────────────────────────────────────────

class _ResultBadge extends StatelessWidget {
  final int count;
  final int total;
  const _ResultBadge({required this.count, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.4)),
      ),
      child: Text(
        '$count ${count == 1 ? 'resultado' : 'resultados'} de $total',
        style: const TextStyle(color: Colors.blueAccent, fontSize: 12),
      ),
    );
  }
}

// ─── Empty state ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final bool isFiltered;
  const _EmptyState({required this.isFiltered});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isFiltered ? Icons.search_off : Icons.inbox_outlined,
            color: Colors.white24,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            isFiltered
                ? 'Ningún resultado coincide con los filtros activos.'
                : 'No hay instalaciones registradas aún.',
            style: const TextStyle(color: Colors.white54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─── Grouped history list ─────────────────────────────────────────────────────

class _GroupedHistoryList extends StatelessWidget {
  final Map<String, List<HistoryDataRule>> groupedByDate;
  final Map<int, String> packNames;

  const _GroupedHistoryList({
    required this.groupedByDate,
    required this.packNames,
  });

  @override
  Widget build(BuildContext context) {
    // Build a flat list: [dateHeader, item, item, dateHeader, item, ...]
    final sections = <_ListEntry>[];
    for (final entry in groupedByDate.entries) {
      sections.add(_DateHeaderEntry(entry.key));
      for (final item in entry.value) {
        sections.add(_HistoryItemEntry(item));
      }
    }

    return ListView.builder(
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final entry = sections[index];
        if (entry is _DateHeaderEntry) {
          return _DateHeader(label: entry.label);
        }
        if (entry is _HistoryItemEntry) {
          return _HistoryItemCard(
            item: entry.item,
            packName: entry.item.packId != null
                ? packNames[entry.item.packId]
                : null,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

sealed class _ListEntry {}

final class _DateHeaderEntry extends _ListEntry {
  final String label;
  _DateHeaderEntry(this.label);
}

final class _HistoryItemEntry extends _ListEntry {
  final HistoryDataRule item;
  _HistoryItemEntry(this.item);
}

// ─── Date section header ──────────────────────────────────────────────────────

class _DateHeader extends StatelessWidget {
  final String label;
  const _DateHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(child: Divider(color: Colors.white12)),
        ],
      ),
    );
  }
}

// ─── History item card ────────────────────────────────────────────────────────

class _HistoryItemCard extends StatelessWidget {
  final HistoryDataRule item;
  final String? packName;

  const _HistoryItemCard({required this.item, this.packName});

  Color _statusColor() => switch (item.status) {
        'success' => Colors.greenAccent,
        'failed' => Colors.redAccent,
        'cancelled' => Colors.orangeAccent,
        _ => Colors.white54,
      };

  IconData _statusIcon() => switch (item.status) {
        'success' => Icons.check_circle,
        'failed' => Icons.cancel,
        'cancelled' => Icons.remove_circle,
        _ => Icons.help_outline,
      };

  String _statusLabel() => switch (item.status) {
        'success' => 'Completado',
        'failed' => 'Fallido',
        'cancelled' => 'Cancelado',
        _ => item.status,
      };

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = _statusColor();

    final durationSec = item.duration.inSeconds;
    final durationStr = durationSec < 60
        ? '${durationSec}s'
        : '${item.duration.inMinutes}m ${durationSec % 60}s';
    final timeStr =
        DateFormat('HH:mm').format(item.completedAt.toLocal());

    return Card(
      color: Colors.white.withValues(alpha: 0.06),
      margin: const EdgeInsets.only(bottom: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Status icon
            Icon(_statusIcon(), color: color, size: 26),
            const SizedBox(width: 12),

            // Name + metadata
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.softwareName,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Wrap(
                    spacing: 8,
                    children: [
                      if (item.softwareVersion != null)
                        _MetaChip('v${item.softwareVersion}', Colors.white38),
                      if (item.installerType != null)
                        _MetaChip(item.installerType!, Colors.white24),
                      if (packName != null)
                        _MetaChip('📦 $packName', Colors.blueAccent.withValues(alpha: 0.6)),
                      if (item.hostname != null)
                        _MetaChip('🖥 ${item.hostname!}', Colors.tealAccent.withValues(alpha: 0.7)),
                    ],
                  ),
                  if (item.errorDetails != null &&
                      item.errorDetails!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        item.errorDetails!,
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.redAccent.withValues(alpha: 0.8),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Status + time + duration
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _statusLabel(),
                  style: textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  timeStr,
                  style: textTheme.bodySmall?.copyWith(color: Colors.white54),
                ),
                Text(
                  durationStr,
                  style: textTheme.bodySmall?.copyWith(color: Colors.white38),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final String label;
  final Color color;
  const _MetaChip(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11,
      ),
    );
  }
}
