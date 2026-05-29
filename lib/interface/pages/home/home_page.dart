import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/configs/configs.dart';
import 'package:instaboo/interface/app/router/library/library_router.dart';
import 'package:instaboo/interface/app/router/pages/pages_router.dart';
import 'package:instaboo/interface/pages/home/dialogs/dialogs_home.dart';
import 'package:instaboo/interface/shared/shared_interface.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //ref.read(logicHomeLibraryProvider);
      ref.read(softwareLogicSharedProvider);
      ref.read(categoriesLogicSharedProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Instaboo',
                  style: textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Instala multiples aplicaciones con facilidad',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Comienza instalando software en lote, gestionando paquetes o explorando tu biblioteca',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 70),
                _buttonsView(context),
                SizedBox(height: 70),
                _featuresView(textTheme),
                SizedBox(height: 20),
              ],
            ),
          ),
          _footerView(context, textTheme: textTheme),
        ],
      ),
    );
  }

  Row _featuresView(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.install_desktop,
                color: Colors.black,
                size: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Instalación',
              style: textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Instala multiples aplicaciones\n simultaneamente',
              style: textTheme.bodySmall?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        SizedBox(width: 60),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.library_books,
                color: Colors.black,
                size: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Biblioteca',
              style: textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Organiza y gestiona tu biblioteca de\n software',
              style: textTheme.bodySmall?.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }

  Row _buttonsView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomElevatedButtonComponentShared(
          onPressed: () {
            InstallerRoute().go(context);
          },
          child: Text('Comenzar Instalación'),
        ),
        SizedBox(width: 10),
        CustomElevatedButtonComponentShared(
          onPressed: () {
            HomePageLibraryRoute().go(context);
          },
          child: Text('Ir a la Biblioteca'),
        ),
      ],
    );
  }

  Wrap _footerView(BuildContext context, {required TextTheme textTheme}) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        CustomLinkTextComponentShared(
          text: 'Acerca de',
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: 'Instaboo',
              applicationVersion: '1.0.0',
              applicationIcon: Image.asset(
                AssetsConfig.logo,
                width: 100,
                height: 100,
              ),
              applicationLegalese:
                  '© 2026 Instaboo. Todos los derechos reservados.',
              children: [
                Text(
                  'Instaboo es una aplicación de escritorio diseñada para instalar múltiples programas de\nforma rápida y organizada, permitiendo seleccionar software desde una\nbiblioteca y realizar instalaciones individuales o por paquetes con pocos clics.',
                ),
              ],
            );
          },
        ),

        CustomLinkTextComponentShared(
          text: 'Términos y condiciones',
          onTap: () {
            showGeneralDialog(
              context: context,
              pageBuilder:
                  (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) => const TermsAndConditionsDialogHome(),
              barrierDismissible: true,
              barrierLabel: 'Cerrar',
              barrierColor: Colors.black.withValues(alpha: 0.5),
              transitionDuration: const Duration(milliseconds: 300),
            );
          },
        ),
        CustomLinkTextComponentShared(
          text: 'Política de privacidad',
          onTap: () {
            showGeneralDialog(
              context: context,
              pageBuilder:
                  (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) => const PrivacyPoliciesDialogHome(),
              barrierDismissible: true,
              barrierLabel: 'Cerrar',
              barrierColor: Colors.black.withValues(alpha: 0.5),
              transitionDuration: const Duration(milliseconds: 300),
            );
          },
        ),
        CustomLinkTextComponentShared(
          text: 'Aviso sobre software de terceros',
          onTap: () {
            showGeneralDialog(
              context: context,
              pageBuilder:
                  (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) => const ThirdPartySoftwareNoticeDialogHome(),
              barrierDismissible: true,
              barrierLabel: 'Cerrar',
              barrierColor: Colors.black.withValues(alpha: 0.5),
              transitionDuration: const Duration(milliseconds: 300),
            );
          },
        ),
        CustomLinkTextComponentShared(
          text: 'Licencia de software',
          onTap: () {
            showGeneralDialog(
              context: context,
              pageBuilder:
                  (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) => const LicensesDialogHome(),
              barrierDismissible: true,
              barrierLabel: 'Cerrar',
              barrierColor: Colors.black.withValues(alpha: 0.5),
              transitionDuration: const Duration(milliseconds: 300),
            );
          },
        ),
        CustomLinkTextComponentShared(
          text: 'Descargo de responsabilidad',
          onTap: () {
            showGeneralDialog(
              context: context,
              pageBuilder:
                  (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) => const DisclaimerDialogHome(),
              barrierDismissible: true,
              barrierLabel: 'Cerrar',
              barrierColor: Colors.black.withValues(alpha: 0.5),
              transitionDuration: const Duration(milliseconds: 300),
            );
          },
        ),
        CustomLinkTextComponentShared(
          text: 'Información de software de código abierto',
          onTap: () {
            showGeneralDialog(
              context: context,
              pageBuilder:
                  (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) => const OpenSourceSoftwareInformationDialogHome(),
              barrierDismissible: true,
              barrierLabel: 'Cerrar',
              barrierColor: Colors.black.withValues(alpha: 0.5),
              transitionDuration: const Duration(milliseconds: 300),
            );
          },
        ),

        
        SizedBox(height: 20),
        Text(
          '© 2026 Instaboo. Todos los derechos reservados.',
          style: textTheme.bodySmall?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
