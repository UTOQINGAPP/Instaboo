import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/interface/layouts/library/components/components_library.dart';
import 'package:instaboo/interface/layouts/library/pages/home/dialogs/dialogs_home_library.dart';
import 'package:instaboo/interface/layouts/library/pages/home/logic/logic_home_library.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

class HomePageLibrary extends ConsumerStatefulWidget {
  const HomePageLibrary({super.key});

  @override
  ConsumerState<HomePageLibrary> createState() => _HomePageLibraryState();
}

class _HomePageLibraryState extends ConsumerState<HomePageLibrary> {
  final CustomFilterItemComponentShared allCategoriesItem =
      CustomFilterItemComponentShared(
        id: -1,
        value: 'all',
        label: 'Todas las categorías',
      );

  /// Currently selected filter item for the software list.
  /// Ítem de filtro actualmente seleccionado para la lista de software.
  CustomFilterItemComponentShared? _selectedFilterItem;

  /// Search text controller — must live outside build() to avoid losing state on rebuilds.
  /// Controlador de texto de búsqueda — debe vivir fuera de build() para no perder el estado en cada rebuild.
  late final TextEditingController _searchController;

  /// Timer used to debounce search requests so we don't query on every keystroke.
  /// Timer usado para hacer debounce de las búsquedas y no consultar en cada tecla.
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _selectedFilterItem = allCategoriesItem;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final logic = ref.watch(logicHomeLibraryProvider);

    // Show error snackbar when deleteSoftware fails (UX-06).
    ref.listen<AsyncValue<HomeLibraryState>>(logicHomeLibraryProvider,
        (_, next) {
      final msg = next.value?.errorMessage;
      if (msg != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        //Sdecoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Biblioteca Software',
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Administra todas tus aplicaciones de software registradas.',
                style: textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: CustomElevatedButtonComponentShared.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Colors.white.withValues(alpha: .5),
                  ),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    pageBuilder:
                        (
                          BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                        ) => const AddSoftwareDialogLibrary(),
                    barrierDismissible: true,
                    barrierLabel: 'Cerrar',
                    barrierColor: Colors.black.withValues(alpha: 0.5),
                    transitionDuration: Duration(milliseconds: 300),
                  );
                },
                icon: Icon(Icons.add),
                label: Text('Agregar Software'),
              ),
            ),

            SizedBox(height: 20),

            CustomSearchAndFilterBarComponentShared(
              searchController: _searchController,
              selectedFilterItem: _selectedFilterItem,
              filterItems: ref
                  .watch(categoriesLogicSharedProvider)
                  .when(
                    data: (CategoriesStateShared state) {
                      final List<CustomFilterItemComponentShared>
                      categoryItems = state.categoriesList
                          .map(
                            (CategoriesModelShared category) =>
                                CustomFilterItemComponentShared(
                                  id: category.id,
                                  value: category.id.toString(),
                                  label: category.name,
                                ),
                          )
                          .toList();

                      return <CustomFilterItemComponentShared>[
                        allCategoriesItem,
                        ...categoryItems,
                      ];
                    },
                    loading: () => <CustomFilterItemComponentShared>[],
                    error: (_, _) => <CustomFilterItemComponentShared>[],
                  ),
              onSearchChanged: (String value) {
                _debounceTimer?.cancel();
                _debounceTimer = Timer(const Duration(milliseconds: 400), () {
                  ref
                      .read(logicHomeLibraryProvider.notifier)
                      .searchSoftware(value);
                });
              },
              onFilterItemSelected:
                  (CustomFilterItemComponentShared? selectedItem) {
                    setState(() {
                      _selectedFilterItem = selectedItem;
                    });
                    // id == -1 significa "Todas las categorías" → limpiar filtro
                    final int? categoryId =
                        (selectedItem == null || selectedItem.id == -1)
                            ? null
                            : selectedItem.id;
                    ref
                        .read(logicHomeLibraryProvider.notifier)
                        .filterByCategory(categoryId);
                  },
            ),
            SizedBox(height: 20),
            Expanded(
              child: logic.when(
                data: (state) {
                  final softwareList = state.softwareList;
                  if (softwareList.isEmpty) {
                    return Center(child: Text('No hay software registrado'));
                  }

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final software = softwareList[index];
                      return ItemSoftwareComponentLibrary(
                        logoPath: software.logo ?? AssetsConfig.logo,
                        name: software.name,
                        description: software.description ?? '',
                        categories: [software.category?.name ?? ''],
                        onEdit: () {
                          showGeneralDialog(
                            context: context,
                            pageBuilder:
                                (
                                  BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                ) => AddSoftwareDialogLibrary(
                                  software: software,
                                ),
                            barrierDismissible: true,
                            barrierLabel: 'Cerrar',
                            barrierColor: Colors.black.withValues(alpha: 0.5),
                            transitionDuration: const Duration(
                              milliseconds: 300,
                            ),
                          );
                        },
                        onDelete: () async {
                          final bool? confirmed = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext ctx) => AlertDialog(
                              title: const Text('Eliminar software'),
                              content: Text(
                                '¿Eliminar "${software.name}"?\n\n'
                                'Se eliminarán también los archivos del '
                                'instalador en disco. '
                                'Esta acción no se puede deshacer.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(ctx).pop(false),
                                  child: const Text('Cancelar'),
                                ),
                                FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                  ),
                                  onPressed: () =>
                                      Navigator.of(ctx).pop(true),
                                  child: const Text('Eliminar'),
                                ),
                              ],
                            ),
                          );
                          if (confirmed == true) {
                            await ref
                                .read(logicHomeLibraryProvider.notifier)
                                .deleteSoftware(software.id);
                          }
                        },
                      );
                    },
                    itemCount: softwareList.length,
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
