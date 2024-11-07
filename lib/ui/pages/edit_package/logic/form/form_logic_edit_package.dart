import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'form_logic_edit_package.g.dart';

class FormLogicEditPackageState {
  final String iconPath;
  final String? name;
  final String? description;
  final String? version;
  final int? categoryId;
  final List<int>? platformsId;
  final bool internetAccess;
  final Directory? directory;
  final String? executable;

  FormLogicEditPackageState({
    this.iconPath = appLogo,
    this.name,
    this.description,
    this.version,
    this.categoryId,
    this.platformsId,
    this.internetAccess = false,
    this.directory,
    this.executable,
  });

  FormLogicEditPackageState copyWith({
    String? iconPath,
    String? name,
    String? description,
    String? version,
    int? categoryId,
    List<int>? platformsId,
    bool? internetAccess,
    Directory? directory,
    String? executable,
  }) {
    return FormLogicEditPackageState(
      iconPath: iconPath ?? this.iconPath,
      name: name ?? this.name,
      description: description ?? this.description,
      version: version ?? this.version,
      categoryId: categoryId ?? this.categoryId,
      platformsId: platformsId ?? this.platformsId,
      internetAccess: internetAccess ?? this.internetAccess,
      directory: directory ?? this.directory,
      executable: executable,
    );
  }

  bool areAllFieldsNotNull() {
    return name != null &&
        description != null &&
        version != null &&
        categoryId != null &&
        platformsId != null &&
        directory != null &&
        executable != null;
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
        'directory: $directory'
        'executable:$executable'
        ')';
  }
}

@riverpod
class FormLogicEditPackage extends _$FormLogicEditPackage {
  @override
  FormLogicEditPackageState build() {
    return FormLogicEditPackageState();
  }

  Future<void> updateIcon() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowedExtensions: ['png']);

    if (result != null) {
      File file = File(result.files.single.path!);
      state = state.copyWith(iconPath: file.path);
    } else {
      state = state.copyWith(iconPath: '');
    }
  }

  set updateName(String name) => state = state.copyWith(name: name);
  set updateDescription(String descripction) =>
      state = state.copyWith(description: descripction);
  set updateVersion(String version) => state = state.copyWith(version: version);
  set updateCategory(int id) => state = state.copyWith(categoryId: id);
  set updatePlatforms(List<int>? id) => state = state.copyWith(platformsId: id);
  set updateInternetAccess(bool online) =>
      state = state.copyWith(internetAccess: online);
  Future<void> updateDirectory() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      // User canceled the picker
      return;
    }
    state = state.copyWith(directory: Directory(selectedDirectory));
  }

  set updateExecutable(String? executable) =>
      state = state.copyWith(executable: executable);
}
