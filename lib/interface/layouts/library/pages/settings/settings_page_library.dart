import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

// ─── Providers ────────────────────────────────────────────────────────────────

final _settingsProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final consumer = ref.read(settingsConsumerInjectionProvider);
  final response = await consumer.getAll();
  return response.resolve(
    onSuccess: (data, _) => data,
    onFailure: (msg, _) => throw Exception(msg),
  );
});

final _frameworksProvider =
    FutureProvider.autoDispose<List<InstallerFrameworkDataRule>>((ref) async {
  final consumer = ref.read(installerFrameworksConsumerInjectionProvider);
  final response = await consumer.getAll();
  return response.resolve(
    onSuccess: (data, _) => data,
    onFailure: (msg, _) => throw Exception(msg),
  );
});

// Keys excluidas de la sección General.
const _hiddenKeys = {'default_silent_args', 'run_as_admin'};

// Keys de tipo entero que el usuario puede editar.
const _editableIntKeys = {'parallel_installs', 'install_timeout_minutes'};

// Rango (min, max, step) del selector para cada setting entero editable.
const _intRanges = <String, ({int min, int max, int step})>{
  'parallel_installs': (min: 1, max: 10, step: 1),
  'install_timeout_minutes': (min: 0, max: 180, step: 1),
};

// Labels en español para cada setting.
const _settingLabels = <String, String>{
  'auto_verify_on_startup': 'Verificar al iniciar',
  'install_timeout_minutes': 'Timeout de instalación (min)',
  'language': 'Idioma',
  'max_log_days': 'Días máximos de logs',
  'notifications_enabled': 'Notificaciones',
  'parallel_installs': 'Instalaciones en paralelo',
  'theme': 'Tema',
};

// Descripciones en español para cada setting.
const _settingDescriptions = <String, String>{
  'auto_verify_on_startup': 'Verifica la integridad de los instaladores al abrir la app',
  'install_timeout_minutes': 'Minutos antes de cancelar un instalador colgado (0 lo desactiva)',
  'language': 'Idioma de la interfaz',
  'max_log_days': 'Cantidad de días que se conservan los registros de actividad',
  'notifications_enabled': 'Muestra notificaciones del sistema durante las instalaciones',
  'parallel_installs': 'Cantidad de instalaciones que pueden ejecutarse al mismo tiempo',
  'theme': 'Apariencia visual de la aplicación',
};

// ─── Page ─────────────────────────────────────────────────────────────────────

class SettingsPageLibrary extends ConsumerWidget {
  const SettingsPageLibrary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(_settingsProvider);
    final frameworksAsync = ref.watch(_frameworksProvider);
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Page header ─────────────────────────────────────────────────
            ListTile(
              title: Text(
                'Configuracion',
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Ajusta el comportamiento general de Instaboo.',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: CustomElevatedButtonComponentShared.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Colors.white.withValues(alpha: .5),
                  ),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  ref.invalidate(_settingsProvider);
                  ref.invalidate(_frameworksProvider);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Recargar'),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  // ── SECCION: General ─────────────────────────────────────
                  _SectionHeader(label: 'General'),
                  const SizedBox(height: 8),
                  settingsAsync.when(
                    data: (settings) {
                      final generalKeys = settings.keys
                          .where((k) => !_hiddenKeys.contains(k))
                          .toList()
                        ..sort();

                      if (generalKeys.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'No hay configuraciones generales registradas.',
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }

                      return Column(
                        children: generalKeys.map((key) {
                          final value = settings[key];
                          return _SettingTile(
                            settingKey: key,
                            value: value,
                            onBoolChanged: value is bool
                                ? (newValue) async {
                                    final consumer = ref.read(
                                      settingsConsumerInjectionProvider,
                                    );
                                    await consumer.setBool(key, newValue);
                                    ref.invalidate(_settingsProvider);
                                  }
                                : null,
                            onIntChanged: _editableIntKeys.contains(key)
                                ? (newValue) async {
                                    final consumer = ref.read(
                                      settingsConsumerInjectionProvider,
                                    );
                                    await consumer.setInt(key, newValue);
                                    ref.invalidate(_settingsProvider);
                                  }
                                : null,
                          );
                        }).toList(),
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (err, _) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Error al cargar configuracion: $err',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── SECCION: Argumentos silenciosos ──────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: _SectionHeader(
                            label: 'Argumentos silenciosos'),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            _showAddFrameworkDialog(context, ref),
                        icon: const Icon(Icons.add,
                            color: Colors.white70, size: 18),
                        label: const Text(
                          'Agregar tipo',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Args aplicados al ejecutar instaladores en silencioso. '
                    'Cada framework tiene sus propios args; el fallback global '
                    'se usa cuando el software no tiene framework asignado.',
                    style: textTheme.bodySmall?.copyWith(color: Colors.white54),
                  ),
                  const SizedBox(height: 12),

                  // ── Fallback global (primera tarjeta de la lista) ─────────
                  settingsAsync.when(
                    data: (settings) {
                      final globalArgs =
                          settings['default_silent_args']?.toString() ?? '';
                      return _FallbackGlobalCard(
                        initialValue: globalArgs,
                        onChanged: (newValue) async {
                          final consumer = ref.read(
                            settingsConsumerInjectionProvider,
                          );
                          await consumer.setString(
                            'default_silent_args',
                            newValue.trim(),
                          );
                        },
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, _) => const SizedBox.shrink(),
                  ),

                  const SizedBox(height: 4),

                  frameworksAsync.when(
                    data: (frameworks) {
                      if (frameworks.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(
                            child: Text(
                              'No hay frameworks registrados.',
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: frameworks
                            .map(
                              (fw) => _FrameworkCard(
                                framework: fw,
                                onSaved: (newArgs) async {
                                  final consumer = ref.read(
                                    installerFrameworksConsumerInjectionProvider,
                                  );
                                  await consumer.update(fw.id,
                                      silentArgs: newArgs);
                                  ref.invalidate(_frameworksProvider);
                                },
                                onDelete: fw.isBuiltIn
                                    ? null
                                    : () async {
                                        final consumer = ref.read(
                                          installerFrameworksConsumerInjectionProvider,
                                        );
                                        await consumer.delete(fw.id);
                                        ref.invalidate(_frameworksProvider);
                                      },
                              ),
                            )
                            .toList(),
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (err, _) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Error al cargar frameworks: $err',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddFrameworkDialog(
      BuildContext context, WidgetRef ref) async {
    final nameCtrl = TextEditingController();
    String args = '';
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Agregar tipo de framework'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre del framework',
                hintText: 'Ej: WiX Toolset',
              ),
            ),
            const SizedBox(height: 16),
            SilentArgsChipInputShared(
              label: 'Argumentos silenciosos',
              onChanged: (v) => args = v,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final name = nameCtrl.text.trim();
              if (name.isEmpty) return;
              final consumer =
                  ref.read(installerFrameworksConsumerInjectionProvider);
              await consumer.create(name: name, silentArgs: args);
              ref.invalidate(_frameworksProvider);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}

// ─── Section headers ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
    );
  }
}

// ─── Fallback global card ─────────────────────────────────────────────────────

class _FallbackGlobalCard extends StatefulWidget {
  final String initialValue;
  final Future<void> Function(String) onChanged;

  const _FallbackGlobalCard({
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<_FallbackGlobalCard> createState() => _FallbackGlobalCardState();
}

class _FallbackGlobalCardState extends State<_FallbackGlobalCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: Colors.white.withValues(alpha: 0.05),
      margin: const EdgeInsets.symmetric(vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Text(
          'Fallback global',
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Se aplica cuando el software no tiene un framework asignado',
          style: textTheme.bodySmall?.copyWith(color: Colors.white54),
        ),
        trailing: const Icon(Icons.expand_more, color: Colors.white54),
        children: [
          SilentArgsChipInputShared(
            initialValue: widget.initialValue,
            label: 'Argumentos por defecto',
            hint: 'Ej: /S  y presiona Enter',
            onChanged: (v) {
              widget.onChanged(v);
            },
          ),
        ],
      ),
    );
  }
}

// ─── Setting tile ─────────────────────────────────────────────────────────────

class _SettingTile extends StatelessWidget {
  final String settingKey;
  final dynamic value;
  final ValueChanged<bool>? onBoolChanged;
  final ValueChanged<int>? onIntChanged;

  const _SettingTile({
    required this.settingKey,
    required this.value,
    this.onBoolChanged,
    this.onIntChanged,
  });

  String _label(String key) =>
      _settingLabels[key] ??
      key
          .replaceAll('.', ' ')
          .replaceAll('_', ' ')
          .split(' ')
          .map((w) =>
              w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
          .join(' ');

  String _description(String key) => _settingDescriptions[key] ?? key;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final bool isEditableInt = _editableIntKeys.contains(settingKey);

    final Widget trailing;
    if (value is bool) {
      trailing = Switch(value: value as bool, onChanged: onBoolChanged);
    } else if (isEditableInt) {
      final range =
          _intRanges[settingKey] ?? (min: 1, max: 10, step: 1);
      final current = (value as num?)?.toInt() ?? range.min;
      trailing = _IntStepper(
        value: current,
        min: range.min,
        max: range.max,
        step: range.step,
        onChanged: onIntChanged,
      );
    } else {
      trailing = Text(
        value?.toString() ?? '-',
        style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
      );
    }

    return Card(
      color: Colors.white.withValues(alpha: 0.05),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(
          _label(settingKey),
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          _description(settingKey),
          style: textTheme.bodySmall?.copyWith(color: Colors.white54),
        ),
        trailing: trailing,
      ),
    );
  }
}

// ─── Int stepper ──────────────────────────────────────────────────────────────

class _IntStepper extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final int step;
  final ValueChanged<int>? onChanged;

  const _IntStepper({
    required this.value,
    required this.min,
    required this.max,
    this.step = 1,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.remove, size: 18, color: Colors.white70),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: value > min
              ? () => onChanged?.call((value - step).clamp(min, max))
              : null,
        ),
        SizedBox(
          width: 34,
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add, size: 18, color: Colors.white70),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: value < max
              ? () => onChanged?.call((value + step).clamp(min, max))
              : null,
        ),
      ],
    );
  }
}

// ─── Framework card ───────────────────────────────────────────────────────────

class _FrameworkCard extends StatefulWidget {
  final InstallerFrameworkDataRule framework;
  final Future<void> Function(String newArgs) onSaved;
  final VoidCallback? onDelete;

  const _FrameworkCard({
    required this.framework,
    required this.onSaved,
    this.onDelete,
  });

  @override
  State<_FrameworkCard> createState() => _FrameworkCardState();
}

class _FrameworkCardState extends State<_FrameworkCard> {
  late String _args;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _args = widget.framework.silentArgs;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Title row: name + "integrado" badge
    final Widget titleWidget = Row(
      children: [
        Text(
          widget.framework.name,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (widget.framework.isBuiltIn) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'integrado',
              style: textTheme.labelSmall?.copyWith(color: Colors.white54),
            ),
          ),
        ],
      ],
    );

    return Card(
      color: Colors.white.withValues(alpha: 0.05),
      margin: const EdgeInsets.symmetric(vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: titleWidget,
        subtitle: widget.framework.description != null
            ? Text(
                widget.framework.description!,
                style: textTheme.bodySmall?.copyWith(color: Colors.white54),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                tooltip: 'Eliminar',
                onPressed: widget.onDelete,
              ),
            const Icon(Icons.expand_more, color: Colors.white54),
          ],
        ),
        children: [
          // ── Args chip input ────────────────────────────────────────────
          SilentArgsChipInputShared(
            key: ValueKey(widget.framework.id),
            initialValue: widget.framework.silentArgs,
            label: 'Argumentos silenciosos',
            hint: 'Ej: /S  y presiona Enter',
            onChanged: (v) => _args = v,
          ),

          const SizedBox(height: 12),

          // ── Save button ────────────────────────────────────────────────
          Align(
            alignment: Alignment.centerRight,
            child: _saving
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : FilledButton(
                    onPressed: () async {
                      setState(() => _saving = true);
                      await widget.onSaved(_args);
                      if (mounted) setState(() => _saving = false);
                    },
                    child: const Text('Guardar'),
                  ),
          ),
        ],
      ),
    );
  }
}
