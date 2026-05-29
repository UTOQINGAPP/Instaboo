import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/interface/layouts/library/pages/packages/logic/logic_packages_library.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

// ─── Provider ────────────────────────────────────────────────────────────────

/// Loads the full list of active software for the checkboxes.
/// Carga la lista completa de software activo para los checkboxes.
final _allActiveSoftwareProvider =
    FutureProvider.autoDispose<List<SoftwareDataRule>>((ref) async {
  final consumer = ref.read(softwareConsumerInjectionProvider);
  final response = await consumer.getAll(activeOnly: true);
  return response.resolve(
    onSuccess: (data, _) => data,
    onFailure: (msg, _) => throw Exception(msg),
  );
});

// ─── Dialog ──────────────────────────────────────────────────────────────────

/// Dialog for creating or editing a pack.
/// When [pack] is null the dialog is in create mode; otherwise in edit mode.
///
/// Diálogo para crear o editar un paquete.
/// Cuando [pack] es null está en modo creación; si no, en modo edición.
class AddPackDialogLibrary extends ConsumerStatefulWidget {
  /// Optional pack to edit. Null for create mode.
  /// Paquete opcional a editar. Null para modo creación.
  final PackDataRule? pack;

  const AddPackDialogLibrary({super.key, this.pack});

  @override
  ConsumerState<AddPackDialogLibrary> createState() =>
      _AddPackDialogLibraryState();
}

class _AddPackDialogLibraryState extends ConsumerState<AddPackDialogLibrary> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _iconController;

  /// IDs currently selected in the checkboxes.
  /// IDs actualmente seleccionados en los checkboxes.
  final Set<int> _selectedSoftwareIds = {};

  /// IDs that were already in the pack when the dialog opened (edit mode only).
  /// Used to compute the diff on save.
  /// IDs que ya estaban en el pack al abrir (solo modo edición).
  final Set<int> _originalSoftwareIds = {};

  /// True while loading the pack's existing software items.
  /// Verdadero mientras cargamos el software existente del pack.
  bool _isLoadingExisting = false;

  bool get _isEditMode => widget.pack != null;

  @override
  void initState() {
    super.initState();
    final p = widget.pack;
    _nameController = TextEditingController(text: p?.name ?? '');
    _descriptionController =
        TextEditingController(text: p?.description ?? '');
    _iconController = TextEditingController(text: p?.icon ?? '');

    if (_isEditMode) {
      _loadExistingSoftware();
    }
  }

  /// Loads the software already associated with the pack (edit mode only).
  /// Carga el software ya asociado al pack (solo modo edición).
  Future<void> _loadExistingSoftware() async {
    setState(() => _isLoadingExisting = true);
    final consumer = ref.read(packsConsumerInjectionProvider);
    final response = await consumer.getSoftwareInPack(widget.pack!.id);
    final ids = response.resolve(
      onSuccess: (data, _) => data.map((sw) => sw.id).toSet(),
      onFailure: (_, _) => <int>{},
    );
    if (mounted) {
      setState(() {
        _selectedSoftwareIds
          ..clear()
          ..addAll(ids);
        _originalSoftwareIds
          ..clear()
          ..addAll(ids);
        _isLoadingExisting = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final bool isLoading =
        ref.watch(packagesLogicLibraryProvider).value?.isLoading ?? false;
    final softwareAsync = ref.watch(_allActiveSoftwareProvider);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: colorScheme.surface,
          elevation: 8,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 480,
              maxHeight: MediaQuery.sizeOf(context).height * 0.85,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Header ──────────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 8, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _isEditMode ? 'Editar paquete' : 'Nuevo paquete',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        tooltip: 'Cerrar',
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                // ── Form ─────────────────────────────────────────────────────
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Name
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              hintText: 'Ej: Herramientas de desarrollo',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            textCapitalization: TextCapitalization.sentences,
                            validator: (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'El nombre es obligatorio'
                                    : null,
                          ),
                          const SizedBox(height: 16),

                          // Description
                          TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              labelText: 'Descripción (opcional)',
                              hintText: 'Breve descripción del paquete',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignLabelWithHint: true,
                            ),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),

                          // Icon (emoji)
                          TextFormField(
                            controller: _iconController,
                            decoration: InputDecoration(
                              labelText: 'Icono (emoji, opcional)',
                              hintText: 'Ej: 🛠️',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // ── Software section ───────────────────────────────
                          Row(
                            children: [
                              Text(
                                'Software incluido',
                                style: textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (_selectedSoftwareIds.isNotEmpty) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${_selectedSoftwareIds.length}',
                                    style: textTheme.labelSmall?.copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Selecciona el software que formará parte de este paquete.',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Software list
                          _buildSoftwareList(softwareAsync, colorScheme, textTheme),

                          const SizedBox(height: 24),

                          // Actions
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: isLoading
                                    ? null
                                    : () => Navigator.of(context).pop(),
                                child: const Text('Cancelar'),
                              ),
                              const SizedBox(width: 12),
                              FilledButton(
                                onPressed: isLoading ? null : _submit,
                                child: isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        _isEditMode ? 'Guardar' : 'Crear',
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Software list widget ─────────────────────────────────────────────────────

  Widget _buildSoftwareList(
    AsyncValue<List<SoftwareDataRule>> softwareAsync,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    if (_isLoadingExisting) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        ),
      );
    }

    return softwareAsync.when(
      data: (softwareList) {
        if (softwareList.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'No hay software activo en la biblioteca.\nAgrega software primero desde la sección Biblioteca.',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(12),
          ),
          constraints: const BoxConstraints(maxHeight: 220),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: softwareList.length,
              separatorBuilder: (_, _) => Divider(
                height: 1,
                color: colorScheme.outlineVariant,
              ),
              itemBuilder: (context, index) {
                final sw = softwareList[index];
                final isSelected = _selectedSoftwareIds.contains(sw.id);
                return CheckboxListTile(
                  dense: true,
                  value: isSelected,
                  onChanged: (val) => setState(() {
                    if (val == true) {
                      _selectedSoftwareIds.add(sw.id);
                    } else {
                      _selectedSoftwareIds.remove(sw.id);
                    }
                  }),
                  title: Text(sw.name, style: textTheme.bodyMedium),
                  subtitle: sw.description != null && sw.description!.isNotEmpty
                      ? Text(
                          sw.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        )
                      : null,
                  controlAffinity: ListTileControlAffinity.leading,
                );
              },
            ),
          ),
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
          'Error al cargar software: $err',
          style: textTheme.bodySmall?.copyWith(color: colorScheme.error),
        ),
      ),
    );
  }

  // ── Submit ──────────────────────────────────────────────────────────────────

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final logic = ref.read(packagesLogicLibraryProvider.notifier);
    final packsConsumer = ref.read(packsConsumerInjectionProvider);

    final name = _nameController.text.trim();
    final description = _descriptionController.text.trim().isEmpty
        ? null
        : _descriptionController.text.trim();
    final icon = _iconController.text.trim().isEmpty
        ? null
        : _iconController.text.trim();

    if (_isEditMode) {
      // 1. Update pack metadata.
      // 1. Actualiza los metadatos del pack.
      final ok = await logic.updatePack(
        id: widget.pack!.id,
        name: name,
        description: description,
        icon: icon,
      );
      if (!ok || !mounted) return;

      // 2. Apply diff: add new items, remove de-selected items.
      // 2. Aplica el diff: agrega nuevos items, elimina los desmarcados.
      final packId = widget.pack!.id;
      final toAdd = _selectedSoftwareIds.difference(_originalSoftwareIds);
      final toRemove = _originalSoftwareIds.difference(_selectedSoftwareIds);

      var sortOrder = _originalSoftwareIds.length;
      for (final softwareId in toAdd) {
        await packsConsumer.addSoftware(packId, softwareId, sortOrder);
        sortOrder++;
      }
      for (final softwareId in toRemove) {
        await packsConsumer.removeSoftware(packId, softwareId);
      }
    } else {
      // 1. Create the pack.
      // 1. Crea el pack.
      final packResponse = await packsConsumer.create(
        name,
        description: description,
        icon: icon,
      );
      final newPack = packResponse.resolve(
        onSuccess: (data, _) => data,
        onFailure: (_, _) => null,
      );
      if (newPack == null || !mounted) return;

      // 2. Add all selected software items.
      // 2. Agrega todos los items de software seleccionados.
      var sortOrder = 0;
      for (final softwareId in _selectedSoftwareIds) {
        await packsConsumer.addSoftware(newPack.id, softwareId, sortOrder);
        sortOrder++;
      }

      // 3. Reload the packs list.
      // 3. Recarga la lista de packs.
      await logic.load();
    }

    if (!mounted) return;
    Navigator.of(context).pop();
  }
}
