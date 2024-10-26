import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/ui/pages/add_package/logic/form/form_logic_add_package.dart';
import 'package:instaboo/ui/shared/shared_ui.dart';
import 'package:window_manager/window_manager.dart';

class AddPackagePage extends ConsumerStatefulWidget {
  static const String link = '/package/add';
  static const String name = 'package-add';
  const AddPackagePage({super.key});

  @override
  ConsumerState<AddPackagePage> createState() => _AddPackagePageState();
}

class _AddPackagePageState extends ConsumerState<AddPackagePage>
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

  @override
  Widget build(BuildContext context) {
    // final themeLogicShared = ref.watch(themeLogicSharedProvider);
    final theme = FluentTheme.of(context);

    return NavigationView(
      appBar: NavigationAppBar(
        title: () {
          const title = Text('NavigationView');

          return const DragToMoveArea(child: title);
        }(),
        leading: IconButton(
          icon: const Icon(FluentIcons.back),
          onPressed: () => context.pop(),
        ),
      ),
      content: Column(
        children: [
          _barTitleView(),
          const Expanded(
            child: Row(
              children: [
                _IconPackageView(),
                _FormPackageView(),
              ],
            ),
          ),
          _barOptionsView(context),
        ],
      ),
    );
  }

  DragToMoveArea _barTitleView() {
    return const DragToMoveArea(
      child: SizedBox(
        width: double.infinity,
        height: 30,
        child: Center(
          child: Text('Agregar Paquete'),
        ),
      ),
    );
  }

  Padding _barOptionsView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Button(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(Colors.red.withOpacity(.8)),
            ),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              context.pop();
            },
          ),
          const Spacer(),
          FilledButton(
            child: const Text('Agregar'),
            onPressed: () async {
              print(ref.read(formLogicAddPackageProvider).toString());
            },
          ),
        ],
      ),
    );
  }
}

class _IconPackageView extends ConsumerWidget {
  const _IconPackageView();

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
            ref.watch(formLogicAddPackageProvider).iconPath.contains('assets')
                ? Image.asset(
                    ref.watch(formLogicAddPackageProvider).iconPath,
                    height: 300,
                    width: 300,
                  )
                : Image.file(
                    File(ref.watch(formLogicAddPackageProvider).iconPath),
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
                    .read(formLogicAddPackageProvider.notifier)
                    .updateIcon();
                //todo:agregar funcionalidad change icon
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FormPackageView extends HookConsumerWidget {
  const _FormPackageView();

  Future<String> _addNewCategoryLogic(BuildContext context,
      {required WidgetRef ref, required String category}) async {
    try {
      if (category.isEmpty) {
        throw Exception('Ingrese una categoria');
      }
      final String? result = await ref
          .read(categoryLogicSharedProvider.notifier)
          .add(CategoryData()..name = category);
      if (result == null) {
        throw Exception(result);
      }
      return result;
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(context, e.toString());
      }
      return '';
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
        //throw Exception(errorSearchCategory);
      }

      ref.read(formLogicAddPackageProvider.notifier).updateCategory =
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
    ValueNotifier<bool> selectedAllPlatforms = useState(false);
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
                ref.read(formLogicAddPackageProvider.notifier).updateName =
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
                    .read(formLogicAddPackageProvider.notifier)
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
                ref.read(formLogicAddPackageProvider.notifier).updateVersion =
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
                                    .text =
                                await (_addNewCategoryLogic(context,
                                    ref: ref,
                                    category: selectedCategoryController.text)),
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
                            ref
                                .read(formLogicAddPackageProvider.notifier)
                                .updatePlatforms = listCategories.value;
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
                    ref.watch(formLogicAddPackageProvider).internetAccess),
                checked: ref.watch(formLogicAddPackageProvider).internetAccess,
                onChanged: (value) => ref
                    .read(formLogicAddPackageProvider.notifier)
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
