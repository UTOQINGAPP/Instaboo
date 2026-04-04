import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/interface/layouts/library/pages/home/logic/logic_home_library.dart';
import 'package:instaboo/interface/layouts/library/pages/home/models/models_library.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

/// Dialog for creating or editing a software entry in the library.
/// Diálogo para crear o editar un registro de software en la biblioteca.
///
/// When [software] is null, the dialog is in create mode; otherwise in edit mode.
/// Cuando [software] es null, el diálogo está en modo creación; si no, en modo edición.
class AddSoftwareDialogLibrary extends ConsumerStatefulWidget {
  /// Optional software to edit. Null for create mode.
  /// Software opcional a editar. Null para modo creación.
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
  late final TextEditingController _silentArgsController;

  int? _selectedCategoryId;
  InstallationTypeEnumRule _installationType = InstallationTypeEnumRule.auto;
  InstallerSourceTypeEnumRule _installerSourceType =
      InstallerSourceTypeEnumRule.file;
  bool _isActive = true;

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
    _silentArgsController = TextEditingController(text: s?.silentArgs ?? '');
    if (s != null) {
      _selectedCategoryId = s.category?.id;
      _installationType = s.installationType;
      _installerSourceType = s.installerSourceType;
      _isActive = s.isActive;
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
    _silentArgsController.dispose();
    super.dispose();
  }

  /// Builds the dialog shell (Material, rounded, with close).
  /// Construye la carcasa del diálogo (Material, redondeado, con cierre).
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
    );
  }

  List<Widget> _buildCreateOnlyFields(TextTheme textTheme) {
    final categoriesAsync = ref.watch(logicCategoriesSharedProvider);
    final categoriesList = categoriesAsync.when(
      data: (state) => state.categoriesList,
      loading: () => <CategoriesModelShared>[],
      error: (_, _) => <CategoriesModelShared>[],
    );

    return <Widget>[
      const SizedBox(height: 16),
      _buildSlugField(textTheme),
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
      _buildInstallationTypeDropdown(textTheme),
      const SizedBox(height: 16),
      _buildInstallerSourceField(textTheme),
      const SizedBox(height: 16),
      _buildSilentArgsField(textTheme),
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
        if (value == null || value.trim().isEmpty) {
          return 'El nombre es obligatorio';
        }
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

  Widget _buildSlugField(TextTheme textTheme) {
    return TextFormField(
      controller: _slugController,
      decoration: InputDecoration(
        labelText: 'Slug (identificador único)',
        hintText: 'Ej: visual-studio-code',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (String? value) {
        if (!_isEditMode && (value == null || value.trim().isEmpty)) {
          return 'El slug es obligatorio';
        }
        return null;
      },
    );
  }

  Widget _buildVersionField(TextTheme textTheme) {
    return TextFormField(
      controller: _versionController,
      decoration: InputDecoration(
        labelText: 'Versión (opcional)',
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
        labelText: 'Categoría',
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
        if (!_isEditMode && value == null) {
          return 'Selecciona una categoría';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField(TextTheme textTheme) {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        labelText: 'Descripción (opcional)',
        hintText: 'Breve descripción del software',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        alignLabelWithHint: true,
      ),
      maxLines: 3,
    );
  }

  /// Builds the logo field: read-only path + file picker for PNG image.
  /// Construye el campo de logo: ruta de solo lectura + selector de archivo PNG.
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: _logoController.text.trim().isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() {
                            _logoController.clear();
                          }),
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

  /// Opens file_picker to select a PNG image for the logo.
  /// Abre el selector de archivos para elegir una imagen PNG como logo.
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
        labelText: 'Tamaño en MB (opcional)',
        hintText: 'Ej: 150',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildInstallationTypeDropdown(TextTheme textTheme) {
    return DropdownButtonFormField<InstallationTypeEnumRule>(
      initialValue: _installationType,
      decoration: InputDecoration(
        labelText: 'Tipo de instalación',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: InstallationTypeEnumRule.values
          .map(
            (InstallationTypeEnumRule e) =>
                DropdownMenuItem<InstallationTypeEnumRule>(
                  value: e,
                  child: Text(e.name == 'auto' ? 'Automática' : 'Asistida'),
                ),
          )
          .toList(),
      onChanged: (InstallationTypeEnumRule? value) {
        if (value != null) setState(() => _installationType = value);
      },
    );
  }

  /// Builds the installer source field: read-only path + file picker button.
  /// For now only file-based installation is supported (file_picker).
  ///
  /// Construye el campo de origen del instalador: ruta de solo lectura + botón selector.
  /// Por ahora solo se soporta instalación por archivo (file_picker).
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
                  hintText: 'Ningún archivo seleccionado',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  suffixIcon: _installerSourceController.text.trim().isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () => setState(() {
                            _installerSourceController.clear();
                          }),
                          tooltip: 'Quitar archivo',
                        ),
                ),
                validator: (String? value) {
                  if (!_isEditMode && (value == null || value.trim().isEmpty)) {
                    return 'Selecciona el archivo del instalador';
                  }
                  return null;
                },
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

  /// Opens file_picker to select an installer file (.exe, .msi).
  /// Asigna la ruta seleccionada al campo de origen del instalador.
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
    setState(() => _installerSourceController.text = path);
  }

  Widget _buildSilentArgsField(TextTheme textTheme) {
    return TextFormField(
      controller: _silentArgsController,
      decoration: InputDecoration(
        labelText: 'Argumentos silenciosos (opcional)',
        hintText: 'Ej: /S /quiet',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
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
      _buildIsActiveSwitch(textTheme),
    ];
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

    if (_isEditMode) {
      final s = widget.software!;
      await logic.updateSoftware(
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
      );
    } else {
      final categoryId = _selectedCategoryId;
      if (categoryId == null) return;

      final String sizeMbStr = _sizeMbController.text.trim();
      final int? sizeMb = sizeMbStr.isEmpty ? null : int.tryParse(sizeMbStr);

      await logic.createSoftware(
        name: _nameController.text.trim(),
        slug: _slugController.text.trim(),
        version: _versionController.text.trim().isEmpty
            ? null
            : _versionController.text.trim(),
        categoryId: categoryId,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        logo: _logoController.text.trim().isEmpty
            ? null
            : _logoController.text.trim(),
        sizeMb: sizeMb,
        installationType: _installationType,
        installerSourceType: _installerSourceType,
        installerSource: _installerSourceController.text.trim(),
        silentArgs: _silentArgsController.text.trim().isEmpty
            ? null
            : _silentArgsController.text.trim(),
      );
    }

    if (!context.mounted) return;
    Navigator.of(context).pop();
  }
}
