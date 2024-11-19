import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/ui/pages/pages_ui.dart';
import 'package:instaboo/ui/shared/shared_ui.dart';

// SelectedPageHome is a consumer widget that displays a list of selected packages for installation.
// It uses Riverpod for state management to track selected packages and theme settings.
// The page allows users to view, manage, and remove packages, and provides options to clear the list 
// or proceed with installation, showing a confirmation dialog with safety checks before installation begins.

class SelectedPageHome extends ConsumerWidget {
  static const String link = '/home/selected';
  static const String name = 'selected';
  const SelectedPageHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeLogicShared = ref.watch(themeLogicSharedProvider);
    final theme = FluentTheme.of(context);
    final selectedPackages = ref.watch(selectedPackageLogicSharedProvider);

    return Column(
      children: [
        Expanded(
          child: selectedPackages.isEmpty
              ? Center(
                  child: Text('Selecione los paquetes a instalar'),
                )
              : ListView.builder(
                  itemCount: selectedPackages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final List<PackageData> packagesList =
                        ref.watch(packageListLogicSharedProvider);
                    final PackageData package = packagesList.firstWhere(
                      (package) => package.id == selectedPackages[index],
                    );

                    final (File?, String?) iconPackage =
                        IoHelper.readIcon(idPackage: package.id.toString());
                    //Todo: corregir busqueda de estado de paquete seleccionado.
                    bool selectedState = package.id == selectedPackages[index];

                    return PackageComponentShared(
                      key: ValueKey(packagesList[index].id),
                      image: ImageComponentShared(
                          imageSource: iconPackage.$1 == null
                              ? appLogo
                              : iconPackage.$1!),
                      name: package.name,
                      description: package.description,
                      version: package.version,
                      platforms: package.platforms.toList(),
                      category: package.category.value!.name,
                      requiresInternet: package.requiresInternet ? 'Si' : 'No',
                      titleColor: themeLogicShared.color.defaultBrushFor(
                        theme.brightness,
                      ),
                      selected: selectedState,
                      onSelected: (value) {
                        if (value!) {
                          ref
                              .read(selectedPackageLogicSharedProvider.notifier)
                              .add(package.id);
                        } else {
                          ref
                              .read(selectedPackageLogicSharedProvider.notifier)
                              .remove(package.id);
                        }
                      },
                      onDelete: () async {
                        ref
                            .read(selectedPackageLogicSharedProvider.notifier)
                            .remove(package.id);
                        final resultRemovePackage = await ref
                            .read(packageListLogicSharedProvider.notifier)
                            .remove(package.id);
                        if (resultRemovePackage != null && context.mounted) {
                          notificationsShared(
                            context,
                            model: NotificationsModelShared(
                                title: 'Error :/',
                                message: resultRemovePackage,
                                severity: InfoBarSeverity.error),
                          );
                        }
                      },
                    );
                  },
                ),
        ),
        Divider(),
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                onPressed: selectedPackages.isEmpty
                    ? null
                    : () {
                        ref
                            .read(selectedPackageLogicSharedProvider.notifier)
                            .clear();
                      },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FluentIcons.clear_selection),
                    SizedBox(width: 2),
                    Text('Limpiar lista'),
                  ],
                ),
              ),
              SizedBox(width: 5),
              FilledButton(
                onPressed: selectedPackages.isEmpty
                    ? null
                    : () async {
                        final List<PackageData> packagesList =
                            ref.watch(packageListLogicSharedProvider);
                        final List<int> selectedPackagesListId =
                            ref.watch(selectedPackageLogicSharedProvider);
                        final List<PackageData> packagesListInstall = [];
                        for (var id in selectedPackagesListId) {
                          final PackageData package = packagesList.firstWhere(
                            (package) => package.id == id,
                          );
                          packagesListInstall.add(package);
                        }

                        confirmDialogShared(
                          context,
                          model: ConfirmDialogModelShared(
                            title: 'Confirmar lista de paquetes',
                            content: SizedBox(
                              height: 57,
                              child: ListView(
                                children: [
                                  ItemListComponentShared(
                                      label:
                                          ' Ejecuto Instaboo como administrador?'),
                                  ItemListComponentShared(
                                      label:
                                          'Desactivo el antivirus del sistema y adicionales?'),
                                  ItemListComponentShared(
                                      label:
                                          ' Esta seguro de los paquetes a instalar?'),
                                ],
                              ),
                            ),
                          ),
                          onConfirm: () async {
                            context.go(
                              InstallPage.link,
                              extra: InstallPageTransporter(
                                await SystemHelper.getWindowsSystemInfo(),
                                await MethodCommandHelper.check(),
                                data: packagesListInstall,
                              ),
                            );
                          },
                        );
                      },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(FluentIcons.installation),
                    SizedBox(width: 2),
                    Text('Instalar'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
