import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show showAboutDialog;
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/ui/layouts/home/logic/logic_home.dart';
import 'package:instaboo/ui/pages/pages_ui.dart';
import 'package:instaboo/ui/shared/shared_ui.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:window_manager/window_manager.dart';
import 'pages/pages_home.dart';
export 'pages/pages_home.dart';

// HomeLayout is the primary layout widget for the application's main interface. 
// It integrates Fluent UI for a Windows-like experience, featuring a navigation pane, 
// dynamic theming, and search functionality. The layout manages categories and packages, 
// supports routing through GoRouter, and includes window management with Acrylic effects. 
// It also provides functionality for window interactions, such as confirmation dialogs 
// before closing the application.


class HomeLayout extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  const HomeLayout({
    super.key,
    required this.navigationShell,
  });

  //final BuildContext? shellContext;

  @override
  ConsumerState<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends ConsumerState<HomeLayout> with WindowListener {
  bool value = false;

  // int index = 0;

  final pageKey = GlobalKey(debugLabel: 'Navigation View Key');
  final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  late final List<NavigationPaneItem> footerSectionView = [
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey<int>(-2),
      icon: const Icon(FluentIcons.settings),
      title: const Text('Agregar paquete'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != EditPackagePage.link) {
          context.push(EditPackagePage.link);
        }
      },
    ),
  ];

  @override
  void initState() {
    windowManager.addListener(this);

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        final themeLogicShared = ref.read(themeLogicSharedProvider.notifier);
        final micaBackgroundColor = FluentTheme.of(context).micaBackgroundColor;
        final isDarkMode = FluentTheme.of(context).brightness.isDark;
        themeLogicShared.setEffect(
            WindowEffect.acrylic, micaBackgroundColor, isDarkMode);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      if (context.mounted) {
       acceptDialogShared(context, model: AcceptDialogModelShared(title: 'Terminos y Condiciones', content: SfPdfViewer.asset(
        termsAndConditionsInstaboo,
        scrollDirection: PdfScrollDirection.vertical, 
        enableDoubleTapZooming: true, 
      
             ),),);
      }
    });
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  int currentCategoryId = 0;
  PaneItem selectedPackageSectionItemView = PaneItem(
    key: const ValueKey<int>(0),
    icon: const Icon(FluentIcons.home),
    title: const Text('Seleccionados'),
    body: const SizedBox.shrink(),
  );

  PaneItemHeader categoriesSectionHeaderView = PaneItemHeader(
      key: const ValueKey<int>(-1), header: const Text('Categorias'));

  @override
  Widget build(BuildContext context) {
    final localizations = FluentLocalizations.of(context);

    final themeLogicShared = ref.watch(themeLogicSharedProvider);
    final theme = FluentTheme.of(context);

    return Builder(builder: (context) {
      late final List<NavigationPaneItem> sectionsPanelView = [
        selectedPackageSectionItemView,
        categoriesSectionHeaderView,
        ...ref.watch(categoryLogicSharedProvider).map((category) {
          return PaneItem(
            key: ValueKey<int>(category.id),
            icon: const Icon(FluentIcons.button_control),
            title: Text(category.name),
            body: const SizedBox.shrink(),
          );
        }),
      ].map<NavigationPaneItem>((item) {
        PaneItem buildSectionItem(PaneItem item) {
          return PaneItem(
            key: item.key,
            icon: item.icon,
            title: item.title,
            body: item.body,
            onTap: () {
              final int keyValue = (item.key as ValueKey<int>).value;
              if (keyValue == -1) {
                return;
              }

              setState(() {
                ref
                    .read(currentSelectedCategoryLogicHomeProvider.notifier)
                    .update(keyValue); // Actualiza currentCategoryId
              });

              if (keyValue == 0) {
                context.go(SelectedPageHome
                    .link); // Navega a la página de inicio seleccionada
              } else {
                context.go(PackagesPageHome.link,
                    extra:
                        keyValue); // Navega a la página correspondiente con el id actual
              }
            },
          );
        }

        if (item is PaneItem) return buildSectionItem(item);
        return item;
      }).toList();

      return NavigationView(
        key: pageKey,
        appBar: _headerView(context, localizations),
        paneBodyBuilder: (item, child) {
          final name =
              item?.key is ValueKey ? (item!.key as ValueKey).value : null;
          return FocusTraversalGroup(
            key: ValueKey('body$name'),
            child: widget.navigationShell,
          );
        },
        pane: _panelView(themeLogicShared, theme, sectionsPanelView),
        onOpenSearch: searchFocusNode.requestFocus,
      );
    });
  }

  NavigationPane _panelView(ThemeState themeLogicShared, FluentThemeData theme,
      List<NavigationPaneItem> originalItems) {
    return NavigationPane(
      selected: ref.watch(currentSelectedCategoryLogicHomeProvider),
      header: Container(
        height: 120,
        margin: const EdgeInsets.only(bottom: 10),
        //color: Colors.red,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                appLogo,
                height: 80,
                width: 80,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 5),
              ShaderMask(
                shaderCallback: (rect) {
                  final color = themeLogicShared.color.defaultBrushFor(
                    theme.brightness,
                  );
                  return LinearGradient(
                    colors: [
                      color,
                      color,
                    ],
                  ).createShader(rect);
                },
                child: const Text(
                  'Instaboo',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              )
            ],
          ),
        ),
      ),
      displayMode: themeLogicShared.displayMode,
      indicator: () {
        switch (themeLogicShared.indicator) {
          case NavigationIndicators.end:
            return const EndNavigationIndicator();
          case NavigationIndicators.sticky:
          default:
            return const StickyNavigationIndicator();
        }
      }(),
      items: originalItems,
      autoSuggestBox: Builder(builder: (context) {
        return AutoSuggestBox(
          key: searchKey,
          focusNode: searchFocusNode,
          controller: searchController,
          unfocusedColor: Colors.transparent,
          // also need to include sub items from [PaneItemExpander] items
          items: <PaneItem>[
            ...originalItems
                .whereType<PaneItemExpander>()
                .expand<PaneItem>((item) {
              return [
                item,
                ...item.items.whereType<PaneItem>(),
              ];
            }),
            ...originalItems
                .where(
                  (item) => item is PaneItem && item is! PaneItemExpander,
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
                searchController.clear();
                searchFocusNode.unfocus();
                final view = NavigationView.of(context);
                if (view.compactOverlayOpen) {
                  view.compactOverlayOpen = false;
                } else if (view.minimalPaneOpen) {
                  view.minimalPaneOpen = false;
                }
              },
            );
          }).toList(),
          trailingIcon: IgnorePointer(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(FluentIcons.search),
            ),
          ),
          placeholder: 'Search',
        );
      }),
      autoSuggestBoxReplacement: const Icon(FluentIcons.search),
      footerItems: footerSectionView,
    );
  }

  NavigationAppBar _headerView(
      BuildContext context, FluentLocalizations localizations) {
    return NavigationAppBar(
      automaticallyImplyLeading: false,
      leading: () {
        final enabled = routerConfig.canPop();

        final onPressed = enabled
            ? () {
                if (routerConfig.canPop()) {
                  context.pop();
                  setState(() {});
                }
              }
            : null;
        return NavigationPaneTheme(
          data: NavigationPaneTheme.of(context).merge(NavigationPaneThemeData(
            unselectedIconColor: WidgetStateProperty.resolveWith((states) {
              if (states.isDisabled) {
                return ButtonThemeData.buttonColor(context, states);
              }
              return ButtonThemeData.uncheckedInputColor(
                FluentTheme.of(context),
                states,
              ).basedOnLuminance();
            }),
          )),
          child: Builder(
            builder: (context) => PaneItem(
              icon: const Center(child: Icon(FluentIcons.back, size: 12.0)),
              title: Text(localizations.backButtonTooltip),
              body: const SizedBox.shrink(),
              enabled: enabled,
            ).build(
              context,
              false,
              onPressed,
              displayMode: PaneDisplayMode.compact,
            ),
          ),
        );
      }(),
      title: () {
        return DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: GestureDetector(
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: Image.asset(
                    appLogo,
                    height: 30,
                    width: 30,
                    fit: BoxFit.fill,
                  ),
                  applicationVersion: appVersion,
                  applicationLegalese: appLicense,
                );
              },
              child: const Text(appTitle),
            ),
          ),
        );
      }(),
      actions: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),
            child: ToggleSwitch(
              content: const Text('Modo Oscuro'),
              checked: FluentTheme.of(context).brightness.isDark,
              onChanged: (v) {
                if (v) {
                  ref
                      .read(themeLogicSharedProvider.notifier)
                      .updateMode(ThemeMode.dark);
                } else {
                  ref
                      .read(themeLogicSharedProvider.notifier)
                      .updateMode(ThemeMode.light);
                }
              },
            ),
          ),
        ),
        const WindownButtonComponentShared(),
      ]),
    );
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose && mounted) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirmar para cerrar'),
            content:
                const Text('¿Estás seguro que deseas cerrar esta ventana?'),
            actions: [
              FilledButton(
                child: const Text('Salir'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}


