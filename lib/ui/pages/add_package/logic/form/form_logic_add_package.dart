import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'form_logic_add_package.g.dart';

class FormLogicAddPackageState {
  final String iconPath;
  final String? name;
  final String? description;
  final String? version;
  final int? categoryId;
  final List<int>? platformsId;
  final bool internetAccess;

  FormLogicAddPackageState({
    this.iconPath = appLogo,
    this.name,
    this.description,
    this.version,
    this.categoryId,
    this.platformsId,
    this.internetAccess = false,
  });

  FormLogicAddPackageState copyWith({
    String? iconPath,
    String? name,
    String? description,
    String? version,
    int? categoryId,
    List<int>? platformsId,
    bool? internetAccess,
  }) {
    return FormLogicAddPackageState(
      iconPath: iconPath ?? this.iconPath,
      name: name ?? this.name,
      description: description ?? this.description,
      version: version ?? this.version,
      categoryId: categoryId ?? this.categoryId,
      platformsId: platformsId ?? this.platformsId,
      internetAccess: internetAccess ?? this.internetAccess,
    );
  }

  bool areAllFieldsNotNull() {
    return name != null &&
        description != null &&
        version != null &&
        categoryId != null &&
        platformsId != null;
  }

  @override
  String toString() {
    return 'FormLogicAddPackageState('
        'iconPath: $iconPath, '
        'name: $name, '
        'description: $description, '
        'version: $version, '
        'categoryId: $categoryId, '
        'platformsId: ${platformsId != null ? platformsId.toString() : 'null'}, '
        'internetAccess: $internetAccess'
        ')';
  }
}

@riverpod
class FormLogicAddPackage extends _$FormLogicAddPackage {
  @override
  FormLogicAddPackageState build() {
    return FormLogicAddPackageState();
  }

  Future<void> updateIcon() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowedExtensions: ['png']);

    if (result != null) {
      File file = File(result.files.single.path!);
      state = state.copyWith(iconPath: file.path);
    } else {
      state = state.copyWith(iconPath: appLogo);
    }
  }

  set updateName(String name) => state = state.copyWith(name: name);
  set updateDescription(String descripction) =>
      state = state.copyWith(description: descripction);
  set updateVersion(String version) => state = state.copyWith(version: version);
  set updateCategory(int id) => state = state.copyWith(categoryId: id);
  set updatePlatforms(List<int> id) => state = state.copyWith(platformsId: id);
  set updateInternetAccess(bool online) =>
      state = state.copyWith(internetAccess: online);

  Future<(PackageData? data, String? messageError)> get data async {
    final bool validate = state.areAllFieldsNotNull();
    if (!validate) {
      return (null, 'El formulario no esta completo');
    }
    final CategoryService categoryService = CategoryService.instance;
    final PlatformService platformService = PlatformService.instance;
    final List<PlatformData> platforms = [];
    state.platformsId!.map((id) {
      final PlatformData? result = platformService.getIdSync(id);
      if (result != null) {
        platforms.add(result);
      }
    });
    if (platforms.isEmpty) {
      return (null, 'Plataformas no encontradas');
    }
    final data = PackageData()
      ..iconPath = state.iconPath
      ..name = state.name!
      ..description = state.description!
      ..version = state.version!
      ..category.value = await categoryService.getId(state.categoryId!)
      ..platforms.addAll(platforms);
    return (data, null);
  }
}
