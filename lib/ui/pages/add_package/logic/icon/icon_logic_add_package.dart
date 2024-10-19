import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:file_picker/file_picker.dart';
part 'icon_logic_add_package.g.dart';

class IconState {
  final String path;
  final bool isOpenChange;

  IconState({
    required this.path,
    required this.isOpenChange,
  });

  IconState copyWith({
    String? path,
    bool? isOpenChange,
  }) {
    return IconState(
      path: path ?? this.path,
      isOpenChange: isOpenChange ?? this.isOpenChange,
    );
  }

  Future<String?> isExistPath() async {
    final file = File(path);
    if (!(await file.exists())) return null;
    return path;
  }
}

@riverpod
class IconLogicAddPackage extends _$IconLogicAddPackage {
  @override
  IconState build() {
    return IconState(path: '', isOpenChange: false);
  }

  Future<void> change() async {
    state = state.copyWith(isOpenChange: true);
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowedExtensions: ['png']);

    if (result != null) {
      File file = File(result.files.single.path!);
      state = state.copyWith(path: file.path, isOpenChange: false);
    } else {
      state = state.copyWith(path: '', isOpenChange: false);
    }
  }
}
