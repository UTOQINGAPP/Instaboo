import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/ui/pages/install/logic/progress_logic_install.dart';
import 'package:instaboo/ui/shared/shared_ui.dart';
import 'package:window_manager/window_manager.dart';

// InstallPage is a consumer stateful widget responsible for managing the package installation process.
// It uses Riverpod for state management and displays real-time progress of the installation tasks.
// The page initializes by setting up progress tracking, updating the UI as packages are installed, 
// and generates a detailed report upon completion. It also ensures proper window management and 
// provides user feedback through dialogs and progress indicators.


class InstallPage extends ConsumerStatefulWidget {
  static const String link = '/install';
  static const String name = 'install';
  final InstallPageTransporter transporter;
  const InstallPage({
    super.key,
    required this.transporter,
  });

  @override
  ConsumerState<InstallPage> createState() => _InstallPageState();
}

class _InstallPageState extends ConsumerState<InstallPage> with WindowListener {

  bool isInstall=false;
  bool isGenerateReport=false;
  @override
  void initState() {
    windowManager.addListener(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final List<PackageData> data = widget.transporter.data;
      ref
          .read(progressLogicInstallProvider.notifier)
          .updateMessage(data[0].name);
      ref
          .read(progressLogicInstallProvider.notifier)
          .updateProgress((1 / data.length));

      if (data.isNotEmpty) {
        for (var package in data) {
          final (File?, String?) icon =
              IoHelper.readIcon(idPackage: package.id.toString());
          if (icon.$1 != null) {}
          ref.read(progressLogicInstallProvider.notifier).addValue(
              ValueStateProgressLogicInstall(
                  icon: icon.$1 != null ? icon.$1! : appLogo,
                  message: 'En espera',
                  status: StatusValueStateProgressLogicInstall.onHold,
                  progress: 0,
                  package: package));
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isInstall=true;
      setState(() {
        
      });
      final ReportInfoHelper  installResult= await ref.read(progressLogicInstallProvider.notifier).install(
          system: widget.transporter.system, method: widget.transporter.method);
         isInstall=false;
      setState(() {
        
      });
      isGenerateReport=true;
      setState(() {
        
      });
          await generateReportHelper(installResult);
        isGenerateReport=false;
      setState(() {
        
      });
      
      
          
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(context.mounted && !isInstall && !isGenerateReport){
        confirmDialogShared(context, model: ConfirmDialogModelShared(title: 'Instaboo', content: Text('La instalación a terminado, cierra la ventana o haga click en confimar.\n\nCerrar Instaboo puede tardar, espere por favor.'),),onConfirm: () async{
           await windowManager.destroy();
        },);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);

    super.dispose();
  }
   @override
  void onWindowClose() async {
     windowManager.destroy();
  }
  @override
  Widget build(BuildContext context) {
    final themeLogicShared = ref.watch(themeLogicSharedProvider);
    final theme = FluentTheme.of(context);
    return NavigationView(
      appBar: NavigationAppBar(
        title: () {
          Text title = Text('Instalando Paquetes');

          return DragToMoveArea(
              child: SizedBox(width: double.infinity, child: title));
        }(),
        automaticallyImplyLeading: false,
        actions: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: !isInstall && isGenerateReport,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Finalizando procesos...'),
                    ProgressRing(),
                  ],
                )),
                 Visibility(
                  visible: !isInstall && !isGenerateReport,
                  child:   const WindownButtonComponentShared(),),
              
            ],
          ),
        ),
      ),
      content: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ref.watch(progressLogicInstallProvider).message,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '%${ref.watch(progressLogicInstallProvider).progress.round()}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(height: 2),
            SizedBox(
              width: double.maxFinite,
              child: ProgressBar(
                value: ref.watch(progressLogicInstallProvider).progress,
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
              itemCount: ref.watch(progressLogicInstallProvider).values.length,
              itemBuilder: (BuildContext context, int index) {
                final ValueStateProgressLogicInstall value =
                    ref.watch(progressLogicInstallProvider).values[index];
                return InstallPackageComponentShared(
                  icon: ImageComponentShared(
                    imageSource: value.icon,
                    width: 50,
                    height: 50,
                  ),
                  name: value.package.name,
                  titleColor: themeLogicShared.color.defaultBrushFor(
                    theme.brightness,
                  ),
                  message: value.message,
                  progress: value.progress,
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
