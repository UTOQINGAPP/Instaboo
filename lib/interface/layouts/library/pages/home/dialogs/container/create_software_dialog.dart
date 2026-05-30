import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/interface/layouts/library/pages/home/logic/logic_home_library.dart';
import 'package:instaboo/interface/layouts/library/pages/home/models/models_library.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

// ─── Providers ───────────────────────────────────────────────────────────────

final _dialogFrameworksProvider =
    FutureProvider.autoDispose<List<InstallerFrameworkDataRule>>((ref) async {
  final consumer = ref.read(installerFrameworksConsumerInjectionProvider);
  final response = await consumer.getAll();
  return response.resolve(
    onSuccess: (data, _) => data,
    onFailure: (msg, _) => throw Exception(msg),
  );
});

final _dialogAllSoftwareProvider =
    FutureProvider.autoDispose<List<SoftwareDataRule>>((ref) async {
  final consumer = ref.read(softwareConsumerInjectionProvider);
  final response = await consumer.getAll(activeOnly: true);
  return response.resolve(
    onSuccess: (data, _) => data,
    onFailure: (msg, _) => throw Exception(msg),
  );
});

/// Dialog for creating or editing a software entry in the library.
class AddSoftwareDialogLibrary extends ConsumerStatefulWidget {
  final SoftwareModelLibrary? software;
  const AddSoftwareDialogLibrary({super.key, this.software});

  @override
  ConsumerState<AddSoftwareDialogLibrary> createState() =>
      _AddSoftwareDialogLibraryState();
}

class _AddSoftwareDialogLibraryState
    extends ConsumerState<AddSoftwareDialogLibrary> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _slugController;
  late final TextEditingController _versionController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _logoController;
  late final TextEditingController _sizeMbController;
  late final TextEditingController _installerSourceController;

  String _silentArgs = '';
  int? _selectedFrameworkId;
  String _extraSilentArgs = '';
  /// Cached silentArgs of the currently selected framework (NF-02).
  String _frameworkSilentArgs = '';
  String? _detectedFrameworkName;
  int? _selectedCategoryId;
  bool _isActive = true;
  bool _isAutoInstallable = true;
  bool _requiresInternet = false;

  // ── Dependencies state (edit mode only) ──────────────────────────────────
  List<SoftwareDataRule> _dependencies = [];
  bool _isLoadingDeps = false;
  int? _selectedDepToAdd;

  bool get _isEditMode => widget.software != null;

  @override
  void initState() {
    super.initState();
    final s = widget.software;
    _nameController = TextEditingController(text: s?.name ?? '');
    _slugController = TextEditingController(text: s?.slug ?? '');
    _versionController = TextEditingController(text: s?.version ?? '');
    _descriptionController = TextEditingController(text: s?.description ?? '');
    _logoController = TextEditingController(text: s?.logo ?? '');
    _sizeMbController = TextEditingController(
      text: s?.sizeMb != null ? s!.sizeMb.toString() : '',
    );
    _installerSourceController = TextEditingController(
      text: s?.installerSource ?? '',
    );
    _silentArgs = s?.silentArgs ?? '';
    if (s != null) {
      _selectedCategoryId = s.category?.id;
      _isActive = s.isActive;
      _isAutoInstallable = s.isAutoInstallable;
      _requiresInternet = s.requiresInternet;
      _selectedFrameworkId = s.installerFrameworkId;
      _extraSilentArgs = s.extraSilentArgs ?? '';
      // Load existing dependencies and framework args after first frame.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadDependencies();
        _loadFrameworkArgs();
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _slugController.dispose();
    _versionController.dispose();
    _descriptionController.dispose();
    _logoController.dispose();
    _sizeMbController.dispose();
    _installerSourceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: colorScheme.surface,
          elevation: 8,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 560,
              maxHeight: MediaQuery.sizeOf(context).height * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildHeader(context, textTheme),
                const Divider(height: 1),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _buildNameField(textTheme),
                          if (!_isEditMode)
                            ..._buildCreateOnlyFields(textTheme),
                          if (_isEditMode) ..._buildEditOnlyFields(textTheme),
                          const SizedBox(height: 24),
                          _buildActions(context),
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

  Widget _buildHeader(BuildContext context, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 8, 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              _isEditMode ? 'Editar software' : 'Agregar software',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            tooltip: 'Cerrar',
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCreateOnlyFields(TextTheme textTheme) {
    final categoriesAsync = ref.watch(categoriesLogicSharedProvider);
    final categoriesList = categoriesAsync.when(
      data: (state) => state.categoriesList,
      loading: () => <CategoriesModelShared>[],
      error: (_, _) => <CategoriesModelShared>[],
    );

    return <Widget>[
      const SizedBox(height: 16),
      _buildVersionField(textTheme),
      const SizedBox(height: 16),
      _buildCategoryDropdown(textTheme, categoriesList),
      const SizedBox(height: 16),
      _buildDescriptionField(textTheme),
      const SizedBox(height: 16),
      _buildLogoField(textTheme),
      const SizedBox(height: 16),
      _buildSizeMbField(textTheme),
      const SizedBox(height: 16),
      _buildInstallerSourceField(textTheme),
      const SizedBox(height: 16),
      _buildFrameworkSection(textTheme),
      const SizedBox(height: 16),
      _buildIsAutoInstallableSwitch(textTheme),
      const SizedBox(height: 8),
      _buildRequiresInternetSwitch(textTheme),
    ];
  }

  Widget _buildNameField(TextTheme textTheme) {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Nombre',
        hintText: 'Ej: Visual Studio Code',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textCapitalization: TextCapitalization.words,
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) return 'El nombre es obligatorio';
        return null;
      },
      onChanged: _isEditMode
          ? null
          : (String value) {
              if (_slugController.text.isEmpty ||
                  _slugController.text == _slugFromName(_nameController.text)) {
                _slugController.text = _slugFromName(value);
              }
            },
    );
  }

  static String _slugFromName(String name) {
    return name
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'[^a-z0-9-]'), '');
  }

  Widget _buildVersionField(TextTheme textTheme) {
    return TextFormField(
      controller: _versionController,
      decoration: InputDecoration(
        labelText: 'Version (opcional)',
        hintText: 'Ej: 1.0.0',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildCategoryDropdown(
    TextTheme textTheme,
    List<CategoriesModelShared> categoriesList,
  ) {
    return DropdownButtonFormField<int>(
      initialValue: _selectedCategoryId,
      decoration: InputDecoration(
        labelText: 'Categoria',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: categoriesList
          .map(
            (CategoriesModelShared c) =>
                DropdownMenuItem<int>(value: c.id, child: Text(c.name)),
          )
          .toList(),
      onChanged: (int? value) => setState(() => _selectedCategoryId = value),
      validator: (int? value) {
        if (!_isEditMode && value == null) return 'Selecciona una categoria';
        return null;
      },
    );
  }

  Widget _buildDescriptionField(TextTheme textTheme) {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        labelText: 'Descripcion (opcional)',
        hintText: 'Breve descripcion del software',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        alignLabelWithHint: true,
      ),
      maxLines: 3,
    );
  }

  Widget _buildLogoField(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Logo (imagen PNG, opcional)',
          style: textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: _logoController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Ninguna imagen seleccionada',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: _logoController.text.trim().isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() { _logoController.clear(); }),
                          tooltip: 'Quitar imagen',
                        ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            FilledButton.icon(
              onPressed: _pickLogoFile,
              icon: const Icon(Icons.image, size: 20),
              label: const Text('Seleccionar PNG'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _pickLogoFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['png'],
      dialogTitle: 'Seleccionar imagen PNG',
    );
    if (result == null || result.files.isEmpty) return;
    final PlatformFile file = result.files.single;
    final String path = file.path ?? file.name;
    if (path.isEmpty) return;
    setState(() => _logoController.text = path);
  }

  Widget _buildSizeMbField(TextTheme textTheme) {
    return TextFormField(
      controller: _sizeMbController,
      decoration: InputDecoration(
        labelText: 'Tamano en MB (opcional)',
        hintText: 'Ej: 150',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildInstallerSourceField(TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Archivo del instalador',
          style: textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TextFormField(
                controller: _installerSourceController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Ningun archivo seleccionado',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: _installerSourceController.text.trim().isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() { _installerSourceController.clear(); }),
                          tooltip: 'Quitar archivo',
                        ),
                ),
                validator: (String? value) => null,
              ),
            ),
            const SizedBox(width: 12),
            FilledButton.icon(
              onPressed: _pickInstallerFile,
              icon: const Icon(Icons.folder_open, size: 20),
              label: const Text('Seleccionar archivo'),
            ),
          ],
        ),
      ],
    );
  }

  /// Populates [_frameworkSilentArgs] from the already-selected framework
  /// (used in edit mode to restore the preview on first build).
  void _loadFrameworkArgs() {
    if (_selectedFrameworkId == null) return;
    final frameworksAsync = ref.read(_dialogFrameworksProvider);
    frameworksAsync.whenData((frameworks) {
      final match =
          frameworks.where((f) => f.id == _selectedFrameworkId).firstOrNull;
      if (match != null && mounted) {
        setState(() => _frameworkSilentArgs = match.silentArgs);
      }
    });
  }

  Future<void> _pickInstallerFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: <String>['exe', 'msi'],
      dialogTitle: 'Seleccionar instalador',
    );
    if (result == null || result.files.isEmpty) return;
    final PlatformFile file = result.files.single;
    final String path = file.path ?? file.name;
    if (path.isEmpty) return;

    setState(() {
      _installerSourceController.text = path;
      _detectedFrameworkName = null;
    });

    // Auto-detect framework from binary signature.
    final detectedName = await InstallerDetectorInfra.detect(path);
    if (detectedName != null && mounted) {
      final frameworksAsync = ref.read(_dialogFrameworksProvider);
      frameworksAsync.whenData((frameworks) {
        final match = frameworks
            .where((f) => f.name.toLowerCase() == detectedName.toLowerCase())
            .firstOrNull;
        if (match != null && mounted) {
          setState(() {
            _selectedFrameworkId = match.id;
            _detectedFrameworkName = match.name;
            _frameworkSilentArgs = match.silentArgs;
          });
        }
      });
    }
  }

  Widget _buildFrameworkSection(TextTheme textTheme) {
    final frameworksAsync = ref.watch(_dialogFrameworksProvider);

    return frameworksAsync.when(
      data: (frameworks) {
        final selected = frameworks
            .where((f) => f.id == _selectedFrameworkId)
            .firstOrNull;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<int?>(
              initialValue: _selectedFrameworkId,
              decoration: InputDecoration(
                labelText: 'Framework del instalador',
                hintText: 'Detectado automaticamente o selecciona manualmente',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                helperText: _detectedFrameworkName != null
                    ? 'Detectado: $_detectedFrameworkName'
                    : null,
                helperStyle: const TextStyle(color: Colors.green),
              ),
              items: [
                const DropdownMenuItem<int?>(
                  value: null,
                  child: Text('Sin framework asignado'),
                ),
                ...frameworks.map(
                  (f) => DropdownMenuItem<int?>(value: f.id, child: Text(f.name)),
                ),
              ],
              onChanged: (value) {
                final fw = frameworks
                    .where((f) => f.id == value)
                    .firstOrNull;
                setState(() {
                  _selectedFrameworkId = value;
                  _frameworkSilentArgs = fw?.silentArgs ?? '';
                });
              },
            ),

            // ── Auto-args banner (NF-02) ────────────────────────────────────
            if (selected != null && selected.silentArgs.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.auto_fix_high,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Args del framework aplicados automáticamente:',
                            style: textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            selected.silentArgs,
                            style: textTheme.bodySmall?.copyWith(
                              fontFamily: 'monospace',
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16),
            StatefulBuilder(
              builder: (context, setInner) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SilentArgsChipInputShared(
                    key: ValueKey(_selectedFrameworkId),
                    initialValue: _extraSilentArgs,
                    label: _frameworkSilentArgs.isNotEmpty
                        ? 'Args adicionales (se añaden a los del framework)'
                        : 'Argumentos silenciosos',
                    hint: 'Ej: /LOG  y presiona Enter',
                    onChanged: (value) {
                      _extraSilentArgs = value;
                      setInner(() {});
                    },
                  ),
                  // Preview of final args (NF-02)
                  if (_frameworkSilentArgs.isNotEmpty ||
                      _extraSilentArgs.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.play_circle_outline,
                            size: 14,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Vista previa: ${[
                              _frameworkSilentArgs,
                              _extraSilentArgs,
                            ].where((s) => s.trim().isNotEmpty).join(' ')}',
                            style: textTheme.bodySmall?.copyWith(
                              fontFamily: 'monospace',
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  List<Widget> _buildEditOnlyFields(TextTheme textTheme) {
    return <Widget>[
      const SizedBox(height: 16),
      _buildVersionField(textTheme),
      const SizedBox(height: 16),
      _buildDescriptionField(textTheme),
      const SizedBox(height: 16),
      _buildLogoField(textTheme),
      const SizedBox(height: 16),
      _buildFrameworkSection(textTheme),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 8),
      _buildDependenciesSection(textTheme),
      const SizedBox(height: 16),
      const Divider(),
      const SizedBox(height: 8),
      _buildIsAutoInstallableSwitch(textTheme),
      const SizedBox(height: 8),
      _buildRequiresInternetSwitch(textTheme),
      const SizedBox(height: 8),
      _buildIsActiveSwitch(textTheme),
    ];
  }

  // ── Dependency helpers ────────────────────────────────────────────────────

  Future<void> _loadDependencies() async {
    if (!mounted) return;
    setState(() => _isLoadingDeps = true);
    final consumer = ref.read(dependenciesConsumerInjectionProvider);
    final result = await consumer.getDependencies(widget.software!.id);
    if (!mounted) return;
    result.resolve(
      onSuccess: (data, _) => setState(() {
        _dependencies = data;
        _isLoadingDeps = false;
      }),
      onFailure: (_, _) => setState(() => _isLoadingDeps = false),
    );
  }

  Future<void> _addDependency() async {
    final depId = _selectedDepToAdd;
    if (depId == null) return;
    final consumer = ref.read(dependenciesConsumerInjectionProvider);
    final result = await consumer.addDependency(widget.software!.id, depId);
    if (!mounted) return;
    result.resolve(
      onSuccess: (_, _) {
        setState(() => _selectedDepToAdd = null);
        _loadDependencies();
      },
      onFailure: (_, _) {},
    );
  }

  Future<void> _removeDependency(int depSoftwareId) async {
    final consumer = ref.read(dependenciesConsumerInjectionProvider);
    final result = await consumer.removeDependency(
      widget.software!.id,
      depSoftwareId,
    );
    if (!mounted) return;
    result.resolve(
      onSuccess: (_, _) => setState(
        () => _dependencies.removeWhere((d) => d.id == depSoftwareId),
      ),
      onFailure: (_, _) {},
    );
  }

  Widget _buildDependenciesSection(TextTheme textTheme) {
    final allSoftwareAsync = ref.watch(_dialogAllSoftwareProvider);
    final depIds = _dependencies.map((d) => d.id).toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dependencias', style: textTheme.bodyLarge),
        const SizedBox(height: 4),
        Text(
          'Software que debe instalarse antes que este.',
          style: textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 10),

        // ── Chips de dependencias actuales ─────────────────────────────────
        if (_isLoadingDeps)
          const SizedBox(
            height: 28,
            width: 28,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        else if (_dependencies.isEmpty)
          Text(
            'Sin dependencias.',
            style: textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: _dependencies
                .map(
                  (dep) => Chip(
                    label: Text(dep.name),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () => _removeDependency(dep.id),
                  ),
                )
                .toList(),
          ),

        const SizedBox(height: 12),

        // ── Agregar nueva dependencia ──────────────────────────────────────
        allSoftwareAsync.when(
          data: (allSoftware) {
            final available = allSoftware
                .where(
                  (s) => s.id != widget.software!.id && !depIds.contains(s.id),
                )
                .toList();

            return Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: _selectedDepToAdd,
                    decoration: InputDecoration(
                      labelText: 'Agregar dependencia',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                    items: available
                        .map(
                          (s) => DropdownMenuItem<int>(
                            value: s.id,
                            child: Text(s.name),
                          ),
                        )
                        .toList(),
                    onChanged: available.isEmpty
                        ? null
                        : (v) => setState(() => _selectedDepToAdd = v),
                    hint: available.isEmpty
                        ? const Text('No hay software disponible')
                        : const Text('Seleccionar software…'),
                  ),
                ),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: _selectedDepToAdd == null ? null : _addDependency,
                  child: const Text('Agregar'),
                ),
              ],
            );
          },
          loading: () => const SizedBox(
            height: 28,
            width: 28,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          error: (_, _) => const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildIsAutoInstallableSwitch(TextTheme textTheme) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Instalación silenciosa', style: textTheme.bodyLarge),
              Text(
                'El instalador se ejecuta sin intervención del usuario',
                style: textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: _isAutoInstallable,
          onChanged: (bool value) => setState(() => _isAutoInstallable = value),
        ),
      ],
    );
  }

  Widget _buildRequiresInternetSwitch(TextTheme textTheme) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Requiere internet', style: textTheme.bodyLarge),
              Text(
                'La instalacion necesita conexion a internet',
                style: textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: _requiresInternet,
          onChanged: (bool value) => setState(() => _requiresInternet = value),
        ),
      ],
    );
  }

  Widget _buildIsActiveSwitch(TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: <Widget>[
          Text('Activo', style: textTheme.bodyLarge),
          const SizedBox(width: 16),
          Switch(
            value: _isActive,
            onChanged: (bool value) => setState(() => _isActive = value),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final state = ref.watch(logicHomeLibraryProvider).value;
    final bool isLoading = state?.isLoading ?? false;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        const SizedBox(width: 12),
        FilledButton(
          onPressed: isLoading ? null : _submit,
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(_isEditMode ? 'Guardar' : 'Crear'),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final logic = ref.read(logicHomeLibraryProvider.notifier);

    final bool ok;
    if (_isEditMode) {
      final s = widget.software!;
      ok = await logic.updateSoftware(
        softwareId: s.id,
        name: _nameController.text.trim(),
        version: _versionController.text.trim().isEmpty
            ? null
            : _versionController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        logo: _logoController.text.trim().isEmpty
            ? null
            : _logoController.text.trim(),
        isActive: _isActive,
        isAutoInstallable: _isAutoInstallable,
        requiresInternet: _requiresInternet,
        installerFrameworkId: _selectedFrameworkId,
        extraSilentArgs:
            _extraSilentArgs.trim().isEmpty ? null : _extraSilentArgs.trim(),
      );
    } else {
      final categoryId = _selectedCategoryId;
      if (categoryId == null) return;

      ok = await logic.createSoftware(
        name: _nameController.text.trim(),
        slug: _slugController.text.trim(),
        version: _versionController.text.trim().isEmpty
            ? null
            : _versionController.text.trim(),
        categoryId: categoryId,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        iconSourcePath: _logoController.text.trim().isEmpty
            ? null
            : _logoController.text.trim(),
        installerSourcePath: _installerSourceController.text.trim().isEmpty
            ? null
            : _installerSourceController.text.trim(),
        silentArgs: _silentArgs.trim().isEmpty ? null : _silentArgs.trim(),
        isAutoInstallable: _isAutoInstallable,
        requiresInternet: _requiresInternet,
        installerFrameworkId: _selectedFrameworkId,
        extraSilentArgs:
            _extraSilentArgs.trim().isEmpty ? null : _extraSilentArgs.trim(),
      );
    }

    if (!mounted) return;
    if (ok) Navigator.of(context).pop();
  }
}
