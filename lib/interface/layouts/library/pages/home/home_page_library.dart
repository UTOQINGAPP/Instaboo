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

  @override
  void initState() {
    super.initState();
    _selectedFilterItem = allCategoriesItem;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final logic = ref.watch(logicHomeLibraryProvider);
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
                        ) => Container(child: AddSoftwareDialogLibrary()),
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
              searchController: TextEditingController(),
              selectedFilterItem: _selectedFilterItem,
              filterItems: ref
                  .watch(logicCategoriesSharedProvider)
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
                // TODO: connect search text with logic/filtering when available.
              },
              onFilterItemSelected:
                  (CustomFilterItemComponentShared? selectedItem) {
                    setState(() {
                      _selectedFilterItem = selectedItem;
                    });
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
                      final categories = ref.read(
                        logicCategoriesSharedProvider.notifier,
                      );

                      print(software.name);
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
                        onDelete: () {},
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
