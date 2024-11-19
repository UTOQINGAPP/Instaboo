import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/ui/shared/shared_ui.dart';

// PackagesPageHome is a consumer stateful widget that displays a list of packages 
// filtered by a specific category ID. 
// It uses Riverpod for state management to track available packages and user-selected packages.
// The page provides functionality to select, deselect, or delete packages and dynamically updates the UI 
// based on user interactions. Package icons, details, and selection states are displayed, 
// with notifications shown for errors during deletion.


class PackagesPageHome extends ConsumerStatefulWidget {
  static const String link = '/home/packages';
  static const String name = 'packages';
  final int idCategory;
  const PackagesPageHome({
    super.key,
    required this.idCategory,
  });

  @override
  ConsumerState<PackagesPageHome> createState() => _PackagesPageHomeState();
}

class _PackagesPageHomeState extends ConsumerState<PackagesPageHome> {
  late List<PackageData> packagesList;

  @override
  void initState() {
    packagesList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeLogicShared = ref.watch(themeLogicSharedProvider);
    final theme = FluentTheme.of(context);

    packagesList = ref
        .watch(packageListLogicSharedProvider)
        .where((package) => (package.category.value!.id == widget.idCategory))
        .toList();
    final selectedPackagesList = ref.watch(selectedPackageLogicSharedProvider);
    return ListView.builder(
      key: ValueKey(selectedPackagesList.length),
      itemCount: packagesList.length,
      itemBuilder: (BuildContext context, int index) {
        final (File?, String?) iconPackage =
            IoHelper.readIcon(idPackage: packagesList[index].id.toString());
        //final selectedState=selectedPackagesList.where((id)=>id==packagesList[index].id);

        final bool selectedState =
            selectedPackagesList.contains(packagesList[index].id);

        return PackageComponentShared(
          key: ValueKey(packagesList[index].id),
          image: ImageComponentShared(
              imageSource: iconPackage.$1 == null ? appLogo : iconPackage.$1!),
          name: packagesList[index].name,
          description: packagesList[index].description,
          version: packagesList[index].version,
          platforms: packagesList[index].platforms.toList(),
          category: packagesList[index].category.value!.name,
          requiresInternet: packagesList[index].requiresInternet ? 'Si' : 'No',
          titleColor: themeLogicShared.color.defaultBrushFor(
            theme.brightness,
          ),
          selected: selectedState,
          onSelected: (value) {
            //print(value);
            if (value!) {
              ref
                  .read(selectedPackageLogicSharedProvider.notifier)
                  .add(packagesList[index].id);
            } else {
              ref
                  .read(selectedPackageLogicSharedProvider.notifier)
                  .remove(packagesList[index].id);
            }
          },
          onDelete: () async {
            ref
                .read(selectedPackageLogicSharedProvider.notifier)
                .remove(packagesList[index].id);
            final resultRemovePackage = await ref
                .read(packageListLogicSharedProvider.notifier)
                .remove(packagesList[index].id);
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
    );
  }
}
