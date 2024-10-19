import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/ui/pages/add_package/logic/logic_add_package.dart';
import 'package:instaboo/ui/shared/logic/theme/theme_logic_shared.dart';
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

    return FluentTheme(
      data: theme,
      child: Column(
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
              // final db = await ref.read(isarDBServiceProvider).db;
              // print('data:${db.categoryDatas}');
              final themeLogicShared =
                  ref.read(themeLogicSharedProvider.notifier);
              final micaBackgroundColor =
                  FluentTheme.of(context).micaBackgroundColor;
              final isDarkMode = FluentTheme.of(context).brightness.isDark;
              themeLogicShared.setEffect(
                  ref.read(themeLogicSharedProvider).windowEffect,
                  micaBackgroundColor,
                  isDarkMode);
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
            FutureBuilder<String?>(
              future: ref.watch(iconLogicAddPackageProvider).isExistPath(),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.hasData) {
                  return Image.file(
                    File(snapshot.data!),
                    fit: BoxFit.cover,
                    height: 300,
                    width: 300,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('Imagen no encontrada'));
                    },
                  );
                }
                return Image.asset(
                  appLogo,
                  height: 300,
                  width: 300,
                );
              },
            ),
            const SizedBox(height: 10),
            Button(
              child: const Text('Cambiar icono'),
              onPressed: () async {
                await ref.read(iconLogicAddPackageProvider.notifier).change();
                //todo:agregar funcionalidad change icon
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FormPackageView extends ConsumerStatefulWidget {
  const _FormPackageView();

  @override
  ConsumerState<_FormPackageView> createState() => _FormPackageViewState();
}

class _FormPackageViewState extends ConsumerState<_FormPackageView> {
  final GlobalKey searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController selectedCategoryController =
      TextEditingController();
  final TextEditingController selectedPlatformController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    selectedCategoryController.dispose();
    searchFocusNode.dispose();
  }

  final PaneItem addCategoryParView = PaneItem(
    key: const ValueKey(addCategoryKey),
    icon: const Icon(FluentIcons.home),
    title: const Text('Agregar Categoria'),
    body: const SizedBox.shrink(),
  );
  late List<NavigationPaneItem> categoriesPartView = [
    addCategoryParView,
  ].map<NavigationPaneItem>((e) {
    PaneItem buildPaneItem(PaneItem item) {
      return PaneItem(
        key: item.key,
        icon: item.icon,
        title: item.title,
        body: item.body,
        onTap: () {
          final selected = (item.key as ValueKey).value;

          if (addCategoryKey != selected) {
            selectedCategoryController.text = selected;

            setState(() {});
          } else {}

          item.onTap?.call();
        },
      );
    }

    return buildPaneItem(e);
  }).toList();
  // List<NavigationPaneItem> generateCategoriesParView() {
  //   final Isar db = ref.read(isarDBServiceProvider).db;

  //   final categories = db.categoryDatas.where().findAllSync();
  //   // print('data:${db.categoryDatas}');
  //   return List.generate(categories.length, (index) {
  //     return PaneItem(
  //       key: ValueKey(categories[index].id),
  //       icon: const Icon(FluentIcons.button_control),
  //       title: Text(categories[index].name),
  //       body: const SizedBox.shrink(),
  //     );
  //   });
  // }

  final treeViewItems = [
    TreeViewItem(content: const Text('Windows 7')),
    TreeViewItem(content: const Text('Windows 8')),
    TreeViewItem(content: const Text('Windows 10')),
    TreeViewItem(content: const Text('Windows 11 o superior')),
  ];

  bool requiresInternet = false;

  @override
  void initState() {
    super.initState();
    //print(generateCategoriesParView().toString());
    //ref.read(isarDBServiceProvider);
    //categoriesPartView.clear();

    //categoriesPartView.addAll([addCategoryParView, ...(await generateCategoriesParView())]);
  }

  @override
  Widget build(BuildContext context) {
    //print(generateCategoriesParView());
    return Container(
      height: double.infinity,
      width: context.width(70),
      padding: const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 10),
      child: ListView(
        padding: const EdgeInsets.only(right: 20),
        children: [
          InfoLabel(
            label: 'Introduce el nombre (*):',
            child: const TextBox(
              placeholder: 'Nombre del paquete',
              expands: false,
            ),
          ),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Descripción:',
            child: const TextBox(
              placeholder: 'Introduce una descripción',
              maxLines: null,
            ),
          ),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Introduce la versión (*):',
            child: const TextBox(
              placeholder: 'Versión del paquete',
              expands: false,
            ),
          ),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Seleccióne una categoria (*):',
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    AutoSuggestBox(
                      key: searchKey,
                      clearButtonEnabled: false,
                      focusNode: searchFocusNode,
                      controller: selectedCategoryController,
                      unfocusedColor: Colors.transparent,
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
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Seleccione las plataformas compatibles (*):',
            child: Card(
              child: TreeView(
                items: [
                  TreeViewItem(
                    content: const Text('Todas las plataformas'),
                    children: treeViewItems,
                  ),
                ],
                selectionMode: TreeViewSelectionMode.multiple,
              ),
            ),
          ),
          const SizedBox(height: 10),
          InfoLabel(
            label: 'Requiere acceso a internet para la instalación:',
            child: Card(
              child: Checkbox(
                checked: requiresInternet,
                onChanged: (v) => setState(() => requiresInternet = v!),
                content: const Text('Solicitar acceso a internet'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
