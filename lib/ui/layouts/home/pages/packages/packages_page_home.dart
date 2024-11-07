import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/ui/shared/shared_ui.dart';

// @collection
// class PackageData {
//   Id id = Isar.autoIncrement;

//   String? iconPath;
//   late String name;
//   late String description;
//   late String version;
//   final platforms = IsarLinks<PlatformData>();
//   late bool requiresInternet;
// }

class PackagesPageHome extends ConsumerWidget {
  static const String link = '/home/packages';
  static const String name = 'packages';
  final int idCategory;
  const PackagesPageHome({
    super.key,
    required this.idCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeLogicShared = ref.watch(themeLogicSharedProvider);
    final theme = FluentTheme.of(context);
    final platforms = ref.watch(platformLogicSharedProvider);
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return PackageComponentShared(
          image: ImageComponentShared(imageSource: appLogo),
          name: 'Name Package',
          description:
              'Amet sint aliquip adipisicing aliquip ipsum enim esse. Quis aute dolore laborum aute esse elit. Irure commodo reprehenderit elit occaecat velit. Sint magna cillum duis ea ea adipisicing sunt labore. Laboris irure elit mollit incididunt eiusmod. Eiusmod do cillum veniam Lorem dolor qui tempor magna.',
          version: '3.0.56',
          platforms: platforms,
          requiresInternet: 'Si',
          titleColor: themeLogicShared.color.defaultBrushFor(
            theme.brightness,
          ),
          onSelected: (value) {},
        );
        // return ListTile(
        //   leading: Image.asset(
        //     appLogo,
        //     height: 140,
        //     width: 140,
        //   ),
        //   title: ShaderMask(
        //     shaderCallback: (rect) {
        //       final color = themeLogicShared.color.defaultBrushFor(
        //         theme.brightness,
        //       );
        //       return LinearGradient(
        //         colors: [
        //           color,
        //           color,
        //         ],
        //       ).createShader(rect);
        //     },
        //     child: Text(
        //       'Name Package',
        //       style:
        //           TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        //   subtitle: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Text(
        //             'Version:',
        //             style: TextStyle(fontWeight: FontWeight.bold),
        //           ),
        //           SizedBox(width: 5),
        //           Text(
        //             '0.4.3',
        //             style: TextStyle(fontWeight: FontWeight.w100),
        //           ),
        //         ],
        //       ),
        //       Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //           Text(
        //             'Requiere internet:',
        //             style: TextStyle(fontWeight: FontWeight.bold),
        //           ),
        //           SizedBox(width: 5),
        //           Text(
        //             'Si',
        //             style: TextStyle(fontWeight: FontWeight.w100),
        //           ),
        //         ],
        //       ),
        //       Column(
        //         mainAxisSize: MainAxisSize.min,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Plataformas Compatibles:',
        //             style: TextStyle(fontWeight: FontWeight.bold),
        //           ),
        //           SizedBox(height: 5),
        //           Wrap(
        //             spacing: 5,
        //             runSpacing: 5,
        //             children: List.generate(
        //               platforms.length,
        //               (index) {
        //                 return Material(
        //                   color: Colors.transparent,
        //                   child: Card(
        //                     child: Row(
        //                       mainAxisSize: MainAxisSize.min,
        //                       children: [
        //                         Icon(FluentIcons.system),
        //                         SizedBox(width: 4),
        //                         Text(platforms[index].name),
        //                       ],
        //                     ),
        //                     padding: EdgeInsets.symmetric(horizontal: 4),
        //                   ),
        //                 );
        //               },
        //             ),
        //           ),
        //           SizedBox(height: 5),
        //         ],
        //       ),
        //       Column(
        //         mainAxisSize: MainAxisSize.min,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Descripcion:',
        //             style: TextStyle(fontWeight: FontWeight.bold),
        //           ),
        //           Text(
        //             'Consectetur id fugiat nostrud ullamco consequat ex labore id incididunt qui sint ea laboris. Aliquip mollit dolor commodo est deserunt enim ut. Nostrud et minim enim pariatur est eu sit enim amet. Est aliqua commodo do et proident minim labore mollit eu eiusmod velit consectetur commodo voluptate. Magna esse minim qui dolor mollit qui velit cillum qui aute in. Ad eu adipisicing cillum mollit reprehenderit ullamco irure et ipsum veniam cupidatat nisi culpa deserunt. Velit nisi ullamco eiusmod veniam minim ullamco aliqua do reprehenderit ad qui magna.',
        //             style: TextStyle(fontWeight: FontWeight.w300),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        //   trailing: Checkbox(
        //     checked: false,
        //     content: Text('Selecionar'),
        //     onChanged: (bool? value) {},
        //   ),
        // );
      },
    );
  }
}
