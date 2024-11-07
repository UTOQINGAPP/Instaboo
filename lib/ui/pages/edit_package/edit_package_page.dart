import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/ui/pages/edit_package/logic/form/form_logic_edit_package.dart';
import 'package:instaboo/ui/shared/logic/packages/package_logic_shared.dart';
import 'package:instaboo/ui/shared/shared_ui.dart';
import 'package:window_manager/window_manager.dart';
import 'package:path/path.dart' as path;

class EditPackagePage extends ConsumerStatefulWidget {
  static const String link = '/package/add';
  static const String name = 'package-add';
  final String title;
  final PackageData? package;
  const EditPackagePage({
    super.key,
    required this.title,
    this.package,
  });

  @override
  ConsumerState<EditPackagePage> createState() => _AddPackagePageState();
}

class _AddPackagePageState extends ConsumerState<EditPackagePage>
    with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);

    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);

    super.dispose();
  }

  Future<(PackageData? data, String? messageError)>
      _generatePackageDBLogic() async {
    final FormLogicEditPackageState formLogicEditPackageState =
        ref.read(formLogicEditPackageProvider);
    final bool validate = formLogicEditPackageState.areAllFieldsNotNull();
    //print(state.platformsId.toString());
    if (!validate) {
      return (null, 'El formulario no esta completo');
    }
    final CategoryService categoryService = CategoryService.instance;
    final PlatformService platformService = PlatformService.instance;
    List<PlatformData> platforms = [];

    formLogicEditPackageState.platformsId?.map((id) {});
    if (formLogicEditPackageState.platformsId == null) {
      return (null, 'Plataformas no encontradas');
    }
    for (var id in formLogicEditPackageState.platformsId!) {
      final PlatformData? result = platformService.getIdSync(id);

      if (result != null) {
        platforms.add(result);
      }
    }
    if (platforms.isEmpty) {
      return (null, 'Plataformas no encontradas');
    }
    final data = PackageData()
      ..name = formLogicEditPackageState.name!
      ..description = formLogicEditPackageState.description!
      ..version = formLogicEditPackageState.version!
      ..category.value =
          await categoryService.getId(formLogicEditPackageState.categoryId!)
      ..platforms.addAll(platforms)
      ..requiresInternet = formLogicEditPackageState.internetAccess
      ..executable = formLogicEditPackageState.executable!;
    return (data, null);
  }

  Future<(Directory?, NotificationsModelShared?)> _copyFilesPackage(
      int idPackage) async {
    final FormLogicEditPackageState formLogicEditPackageState =
        ref.read(formLogicEditPackageProvider);
    final iconCopy = await IoHelper.copyIcon(
        sourcePath: formLogicEditPackageState.iconPath,
        idPackage: idPackage.toString());
    final PackageData? packageData =
        await ref.read(packageServiceLogicSharedProvider).getId(idPackage);
    if (packageData == null) {
      return (
        null,
        NotificationsModelShared(
            title: 'Error :/',
            message: 'El paquete no pudo registrarse.',
            severity: InfoBarSeverity.error)
      );
    }
    final Directory? directoryPackageSource =
        formLogicEditPackageState.directory;
    if (directoryPackageSource == null) {
      return (
        null,
        NotificationsModelShared(
            title: 'Aviso :/',
            message: 'Seleccione el directorio fuente del paquete.')
      );
    }
    if (!(await directoryPackageSource.exists())) {
      return (
        null,
        NotificationsModelShared(
            title: 'Error :/',
            message: 'No existe el directorio seleccionado.',
            severity: InfoBarSeverity.error)
      );
    }
    final directoryCopy = await IoHelper.copyPackage(
        directoryPackageSource.path, idPackage.toString());
    if (directoryCopy.$1 == null) {
      return (
        null,
        NotificationsModelShared(
            title: 'Error :/',
            message: directoryCopy.$2!,
            severity: InfoBarSeverity.error)
      );
    }
    return (Directory(directoryCopy.$1!), null);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: () {
          Text title = Text(widget.title);

          return DragToMoveArea(
              child: SizedBox(width: double.infinity, child: title));
        }(),
        leading: IconButton(
          icon: const Icon(FluentIcons.back),
          onPressed: () => context.pop(),
        ),
        actions: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            child: const Text('Agregar'),
            onPressed: () async {
              final (PackageData?, String?) resultGeneratePackage =
                  await _generatePackageDBLogic();
              if (resultGeneratePackage.$1 == null) {
                print(resultGeneratePackage.$2);
                if (context.mounted) {
                  await notificationsShared(
                    context,
                    model: NotificationsModelShared(
                        title: 'Aviso :/', message: resultGeneratePackage.$2!),
                  );
                }
                return;
              }
              final PackageData data = resultGeneratePackage.$1!;
              final int idResult =
                  await ref.read(packageServiceLogicSharedProvider).add(data);
              final PackageData? dataResult = await ref
                  .read(packageServiceLogicSharedProvider)
                  .getId(idResult);

              if (dataResult == null) {
                return;
              }
              final (Directory?, NotificationsModelShared?) resultCopyFiles =
                  await _copyFilesPackage(dataResult.id);
              if (resultCopyFiles.$1 == null && context.mounted) {
                await notificationsShared(context, model: resultCopyFiles.$2!);
                return;
              }
              final String? resultCreateHashes =
                  await HashesJsonHelper.saveHashes(
                      directoryPath: resultCopyFiles.$1!.path,
                      packageId: dataResult.id.toString());
              if (resultCreateHashes != null && context.mounted) {
                await notificationsShared(
                  context,
                  model: NotificationsModelShared(
                      title: 'Error :/',
                      message: resultCreateHashes,
                      severity: InfoBarSeverity.error),
                );
                return;
              }
              if (context.mounted) {
                context.pop();
              }

              //HashesJsonHelper.checkHashes();
            },
          ),
        ),
      ),
      content: Row(
        children: [
          _FilesPackageView(),
          _FormPackageView(),
        ],
      ),
    );
  }
}

class _FilesPackageView extends HookConsumerWidget {
  const _FilesPackageView();

  List<String> contentDirectoryLogic(WidgetRef ref) {
    final Directory? directory =
        ref.watch(formLogicEditPackageProvider).directory;
    if (directory == null) {
      return [];
    }
    if (!directory.existsSync()) {
      return [];
    }
    final List<FileSystemEntity> entities = directory.listSync();
    final files = entities
        .whereType<File>()
        .map((entity) => path.basename(entity.path))
        .toList();
    if (files.isEmpty) {
      return [];
    }
    return files;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      //color: Colors.blue,
      height: double.infinity,
      width: context.width(30),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            !(ref.watch(formLogicEditPackageProvider).iconPath.contains(''))
                ? Image.asset(
                    appLogo,
                    height: 300,
                    width: 300,
                  )
                : Image.file(
                    File(ref.watch(formLogicEditPackageProvider).iconPath),
                    fit: BoxFit.cover,
                    height: 300,
                    width: 300,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('Imagen no encontrada'));
                    },
                  ),
            const SizedBox(height: 10),
            Button(
              child: const Text('Cambiar icono'),
              onPressed: () async {
                await ref
                    .read(formLogicEditPackageProvider.notifier)
                    .updateIcon();
                //todo:agregar funcionalidad change icon
              },
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InfoLabel(
                label: 'Seleccione el directorio del paquete a agregar (*):',
                child: Row(
                  children: [
                    Expanded(
                      child: ComboBox<String>(
                        value:
                            ref.watch(formLogicEditPackageProvider).executable,
                        items: contentDirectoryLogic(ref)
                            .map<ComboBoxItem<String>>((file) {
                          return ComboBoxItem<String>(
                            value: file,
                            child: Text(file),
                          );
                        }).toList(),
                        onChanged: (value) {
                          ref
                              .read(formLogicEditPackageProvider.notifier)
                              .updateExecutable = value;
                        },
                        //                 disabled
                        // ? null
                        // : (color) {
                        //     setState(() => selectedCat = color);
                        //   }
                        placeholder:
                            const Text('Seleccione el ejecutable (*.exe)'),
                      ),
                    ),
                    SizedBox(width: 5),
                    Button(
                      child: const Text('Subir'),
                      onPressed: () async {
                        ref
                            .read(formLogicEditPackageProvider.notifier)
                            .updateDirectory();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormPackageView extends HookConsumerWidget {
  const _FormPackageView();

  Future<String?> _addNewCategoryLogic(BuildContext context,
      {required WidgetRef ref, required String category}) async {
    try {
      if (category.isEmpty) {
        throw Exception('Ingrese una categoria');
      }
      final String? result = await ref
          .read(categoryLogicSharedProvider.notifier)
          .add(CategoryData()..name = category);

      if (result != null) {
        throw Exception(result);
      }
      if (context.mounted) {
        notificationsShared(
          context,
          model: NotificationsModelShared(
              title: 'Aviso :)',
              message: 'Nueva categoria agregada correctamente.',
              severity: InfoBarSeverity.success),
        );
      }
      return result;
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(context, e.toString());
      }
      return null;
    }
  }

  void _selectedCategoryLogic(BuildContext context,
      {required ValueKey<int> key, required WidgetRef ref}) async {
    try {
      final id = (key).value;

      final CategoryData? category =
          await ref.read(categoryLogicSharedProvider.notifier).getId(id);
      if (category == null) {
        return;
      }

      ref.read(formLogicEditPackageProvider.notifier).updateCategory =
          category.id;
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(context, e.toString());
      }
    }
  }

  // Función para mostrar el AlertDialog
  // todo:mover al lugar correcto, este es temporal
  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        actions: [
          FilledButton(
            child: const Text('Cerrar'),
            onPressed: () => context.pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController selectedCategoryController =
        useTextEditingController();
    ValueNotifier<GlobalKey<State<StatefulWidget>>> searchKey =
        useState(GlobalKey(debugLabel: 'Search Bar Key'));
    var searchFocusNode = useFocusNode();
    searchFocusNode = useFocusNode();
    List<PlatformData> platforms = ref.watch(platformLogicSharedProvider);
    ValueNotifier<List<int>> listCategories = useState(<int>[]);

    return Container(
      height: double.infinity,
      width: context.width(70),
      padding: const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 10),
      child: ListView(
        padding: const EdgeInsets.only(right: 20),
        children: [
          InfoLabel(
            label: 'Introduce el nombre (*):',
            child: TextBox(
              placeholder: 'Nombre del paquete',
              expands: false,
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                }
                ref.read(formLogicEditPackageProvider.notifier).updateName =
                    value;
              },
            ),
          ),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Descripción:',
            child: TextBox(
              placeholder: 'Introduce una descripción',
              maxLines: null,
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                }
                ref
                    .read(formLogicEditPackageProvider.notifier)
                    .updateDescription = value;
              },
            ),
          ),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Introduce la versión (*):',
            child: TextBox(
              placeholder: 'Versión del paquete',
              expands: false,
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                }
                ref.read(formLogicEditPackageProvider.notifier).updateVersion =
                    value;
              },
            ),
          ),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Seleccióne una categoria (*):',
            child: Builder(
              builder: (BuildContext context) {
                final categories = ref.watch(categoryLogicSharedProvider);
                List<NavigationPaneItem> categoriesPartView =
                    List.generate(categories.length, (index) {
                  return PaneItem(
                    key: ValueKey<int>(categories[index].id),
                    icon: const Icon(FluentIcons.home),
                    title: Text((categories[index].name)),
                    body: const SizedBox.shrink(),
                  );
                }).map<NavigationPaneItem>((e) {
                  PaneItem buildPaneItem(PaneItem item) {
                    return PaneItem(
                      key: item.key,
                      icon: item.icon,
                      title: item.title,
                      body: item.body,
                      onTap: () {
                        _selectedCategoryLogic(context,
                            key: (item.key as ValueKey<int>), ref: ref);

                        item.onTap?.call();
                      },
                    );
                  }

                  return buildPaneItem(e);
                }).toList();
                //todo: si no existe la categoria indicar que debe buscar una que exista o crearla, mostrar de forma diferente si existe la categoria
                return AutoSuggestBox(
                  key: searchKey.value,
                  clearButtonEnabled: false,
                  style: TextStyle(color: Colors.red),
                  onSelected: (value) {},
                  onChanged: (text, reason) {},
                  focusNode: searchFocusNode,
                  controller: selectedCategoryController,
                  unfocusedColor: Colors.transparent,
                  noResultsFoundBuilder: (context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Button(
                            child: Text('Seleccionar y agregar categoria'),
                            onPressed: () async => selectedCategoryController
                                .text = await (_addNewCategoryLogic(context,
                                        ref: ref,
                                        category:
                                            selectedCategoryController.text)) ==
                                    null
                                ? selectedCategoryController.text
                                : '',
                          ),
                        ),
                      ],
                    );
                  },
                  // also need to include sub items from [PaneItemExpander] items
                  items: <PaneItem>[
                    ...categoriesPartView
                        .whereType<PaneItemExpander>()
                        .expand<PaneItem>((item) {
                      return [
                        item,
                        ...item.items.whereType<PaneItem>(),
                      ];
                    }),
                    ...categoriesPartView
                        .where(
                          (item) =>
                              item is PaneItem && item is! PaneItemExpander,
                        )
                        .cast<PaneItem>(),
                  ].map((item) {
                    assert(item.title is Text);
                    final text = (item.title as Text).data!;
                    return AutoSuggestBoxItem(
                      label: text,
                      value: text,
                      onSelected: () {
                        item.onTap?.call();
                        //searchController.clear();
                        searchFocusNode.unfocus();
                      },
                    );
                  }).toList(),
                  trailingIcon: IgnorePointer(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(FluentIcons.search),
                    ),
                  ),
                  placeholder: 'Buscar categoria',
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Seleccione las plataformas compatibles (*):',
            child: Card(
              child: SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: platforms.length,
                  itemBuilder: (BuildContext context, int index) {
                    return HookBuilder(
                      builder: (BuildContext context) {
                        ValueNotifier<bool> checked = useState(
                            listCategories.value.contains(platforms[index].id));
                        return Checkbox(
                          checked: checked.value,
                          content: Flexible(
                            child: ListTile(
                              title: Text(platforms[index].name),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Minimum build number: ${platforms[index].buildNumber}'),
                                  Text(
                                      'Architecture: ${platforms[index].architecture}'),
                                ],
                              ),
                            ),
                          ),
                          onChanged: (bool? value) {
                            if (value != null) {
                              if (value) {
                                listCategories.value.add(platforms[index].id);
                                checked.value = value;
                              } else {
                                listCategories.value
                                    .remove(platforms[index].id);
                                checked.value = false;
                              }
                            }
                            //print(listCategories.value.toString());
                            ref
                                    .read(formLogicEditPackageProvider.notifier)
                                    .updatePlatforms =
                                listCategories.value.isEmpty
                                    ? null
                                    : listCategories.value;
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Requiere acceso a internet para la instalación:',
            child: Card(
              child: Checkbox(
                key: ValueKey(
                    ref.watch(formLogicEditPackageProvider).internetAccess),
                checked: ref.watch(formLogicEditPackageProvider).internetAccess,
                onChanged: (value) => ref
                    .read(formLogicEditPackageProvider.notifier)
                    .updateInternetAccess = value!,
                content: const Text('Solicitar acceso a internet'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
