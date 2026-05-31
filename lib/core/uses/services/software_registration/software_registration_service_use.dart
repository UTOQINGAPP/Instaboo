import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/rules_core.dart';

/// Orchestrates software creation with optional icon and installer assets.
/// Orquesta la creacion de software con icono e instalador opcionales.
///
/// Receives [SoftwareServiceRule], [InstallersServiceRule],
/// [InstallerFrameworksServiceRule] and [SettingsServiceRule] via constructor
/// so the injection layer decides the concrete implementation (R14, DIP).
class SoftwareRegistrationServiceUse implements SoftwareRegistrationServiceRule {
  final SoftwareServiceRule _softwareService;
  final InstallersServiceRule _installersService;
  final SettingsServiceRule _settingsService;
  final InstallerFrameworksServiceRule _frameworksService;

  SoftwareRegistrationServiceUse({
    required SoftwareServiceRule softwareService,
    required InstallersServiceRule installersService,
    required SettingsServiceRule settingsService,
    required InstallerFrameworksServiceRule frameworksService,
  })  : _softwareService = softwareService,
        _installersService = installersService,
        _settingsService = settingsService,
        _frameworksService = frameworksService;

  @override
  Future<ResponseRule<SoftwareDataRule>> createWithAssets({
    required String name,
    required String slug,
    String? version,
    String? description,
    int? categoryId,
    bool isAutoInstallable = true,
    bool requiresInternet = false,
    int? installerFrameworkId,
    String? extraSilentArgs,
    String? iconSourcePath,
    String? installerSourcePath,
    String? silentArgs,
  }) async {
    // Step 0 (optional): auto-detect installer framework from binary
    // Paso 0 (opcional): auto-detectar framework desde el binario
    int? resolvedFrameworkId = installerFrameworkId;
    if (resolvedFrameworkId == null) {
      final instPath = installerSourcePath?.trim();
      if (instPath != null && instPath.isNotEmpty) {
        final detectedName = await InstallerDetectorInfra.detect(instPath);
        if (detectedName != null) {
          final frameworkRes =
              await _frameworksService.getByName(detectedName);
          await frameworkRes.resolve(
            onSuccess: (fw, _) async { resolvedFrameworkId = fw.id; },
            onFailure: (_, _) async {},
          );
        }
      }
    }

    // Step 1: create the software record
    final createRes = await _softwareService.create(
      name,
      slug,
      version: version,
      description: description,
      categoryId: categoryId,
      isAutoInstallable: isAutoInstallable,
      requiresInternet: requiresInternet,
      installerFrameworkId: resolvedFrameworkId,
      extraSilentArgs: extraSilentArgs?.trim().isNotEmpty == true
          ? extraSilentArgs!.trim()
          : null,
    );

    SoftwareDataRule? created;
    String? createError;
    await createRes.resolve(
      onSuccess: (data, _) async { created = data; },
      onFailure: (msg, _) async { createError = msg; },
    );
    if (created == null) {
      return FailureResponseRule(
        message: createError ?? 'Failed to create software.',
      );
    }

    final int softwareId = created!.id;

    // Step 2 (optional): import icon
    final String? iconPath = iconSourcePath?.trim();
    if (iconPath != null && iconPath.isNotEmpty) {
      final iconRes = await _softwareService.importIconFromPath(
        softwareId,
        iconPath,
      );
      String? iconError;
      await iconRes.resolve(
        onSuccess: (_, _) async {},
        onFailure: (msg, _) async { iconError = msg; },
      );
      if (iconError != null) {
        return FailureResponseRule(
          message: iconError ?? 'Failed to import icon.',
        );
      }
    }

    // Step 3 (optional): import installer and link to software
    final String? instPath = installerSourcePath?.trim();
    if (instPath != null && instPath.isNotEmpty) {
      // Resolve effective silent args:
      //   1. per-software silentArgs param (legacy field, kept for compatibility)
      //   2. framework args  +  extraSilentArgs
      //   3. global default_silent_args setting
      String? silentTrim = silentArgs?.trim();

      if (silentTrim == null || silentTrim.isEmpty) {
        // Try framework args
        if (resolvedFrameworkId != null) {
          final fwRes = await _frameworksService.getById(resolvedFrameworkId!);
          await fwRes.resolve(
            onSuccess: (fw, _) async {
              final fwArgs = fw.silentArgs.trim();
              final extra = (extraSilentArgs ?? '').trim();
              final combined = [fwArgs, extra]
                  .where((s) => s.isNotEmpty)
                  .join(' ');
              if (combined.isNotEmpty) silentTrim = combined;
            },
            onFailure: (_, _) async {},
          );
        }
      }

      // Still empty - fall back to global setting
      if (silentTrim == null || silentTrim!.isEmpty) {
        final globalRes =
            await _settingsService.getString('default_silent_args');
        await globalRes.resolve(
          onSuccess: (value, _) async {
            if (value.trim().isNotEmpty) silentTrim = value.trim();
          },
          onFailure: (_, _) async {},
        );
      }

      final instRes = await _installersService.importSingleFileFromPath(
        instPath,
        silentArgs:
            (silentTrim == null || silentTrim!.isEmpty) ? null : silentTrim,
      );
      InstallerDataRule? installer;
      String? instError;
      await instRes.resolve(
        onSuccess: (data, _) async { installer = data; },
        onFailure: (msg, _) async { instError = msg; },
      );
      if (installer == null) {
        return FailureResponseRule(
          message: instError ?? 'Failed to import installer.',
        );
      }

      final linkRes = await _softwareService.setInstaller(
        softwareId,
        installer!.id,
      );
      String? linkError;
      await linkRes.resolve(
        onSuccess: (_, _) async {},
        onFailure: (msg, _) async { linkError = msg; },
      );
      if (linkError != null) {
        return FailureResponseRule(
          message: linkError ?? 'Failed to link installer.',
        );
      }
    }

    // Return the final software record with all linked assets
    return _softwareService.getById(softwareId);
  }
}
