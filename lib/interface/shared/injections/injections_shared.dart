import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/uses_core.dart';

part 'injections_shared.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Services (core/uses/services)
// ─────────────────────────────────────────────────────────────────────────────

/// Installation service injection. Exposes [InstallationServiceRule].
/// Inyección del servicio de instalaciones. Expone [InstallationServiceRule].
@Riverpod(keepAlive: true)
InstallationServiceRule _installationServiceInjection(Ref ref) {
  return InstallationServiceUse();
}

/// Packs service injection. Exposes [PacksServiceRule].
/// Inyección del servicio de packs. Expone [PacksServiceRule].
@Riverpod(keepAlive: true)
PacksServiceRule _packsServiceInjection(Ref ref) {
  return PacksServiceUse();
}

/// Settings service injection. Exposes [SettingsServiceRule].
/// Inyección del servicio de configuración. Expone [SettingsServiceRule].
@Riverpod(keepAlive: true)
SettingsServiceRule _settingsServiceInjection(Ref ref) {
  return SettingsServiceUse();
}

/// Software service injection. Exposes [SoftwareServiceRule].
/// Inyección del servicio de software. Expone [SoftwareServiceRule].
@Riverpod(keepAlive: true)
SoftwareServiceRule _softwareServiceInjection(Ref ref) {
  return SoftwareServiceUse();
}

/// Categories service injection. Exposes [CategoriesServiceRule].
/// Inyección del servicio de categorías. Expone [CategoriesServiceRule].
@Riverpod(keepAlive: true)
CategoriesServiceRule _categoriesServiceInjection(Ref ref) {
  return CategoriesServiceUse();
}

/// Installer frameworks service injection. Exposes [InstallerFrameworksServiceRule].
/// Inyección del servicio de frameworks de instalador. Expone [InstallerFrameworksServiceRule].
@Riverpod(keepAlive: true)
InstallerFrameworksServiceRule _installerFrameworksServiceInjection(Ref ref) {
  return InstallerFrameworksServiceUse();
}

/// Logs service injection. Exposes [LogsServiceRule].
/// Inyección del servicio de logs. Expone [LogsServiceRule].
@Riverpod(keepAlive: true)
LogsServiceRule _logsServiceInjection(Ref ref) {
  return LogsServiceUse();
}

/// Dependencies service injection. Exposes [DependenciesServiceRule].
/// Inyección del servicio de dependencias. Expone [DependenciesServiceRule].
@Riverpod(keepAlive: true)
DependenciesServiceRule _dependenciesServiceInjection(Ref ref) {
  return DependenciesServiceUse();
}

/// Installers service injection. Exposes [InstallersServiceRule].
/// Inyección del servicio de instaladores. Expone [InstallersServiceRule].
@Riverpod(keepAlive: true)
InstallersServiceRule _installersServiceInjection(Ref ref) {
  return InstallersServiceUse();
}

/// Software registration service injection. Exposes [SoftwareRegistrationServiceRule].
/// Inyección del servicio de registro de software. Expone [SoftwareRegistrationServiceRule].
@Riverpod(keepAlive: true)
SoftwareRegistrationServiceRule _softwareRegistrationServiceInjection(Ref ref) {
  return SoftwareRegistrationServiceUse();
}

// ─────────────────────────────────────────────────────────────────────────────
// Consumers (core/rules/consumers)
// ─────────────────────────────────────────────────────────────────────────────

/// Installation consumer injection. Exposes [InstallationConsumerRule].
/// Inyección del consumidor de instalaciones. Expone [InstallationConsumerRule].
@Riverpod(keepAlive: true)
InstallationConsumerRule installationConsumerInjection(Ref ref) {
  return InstallationConsumerRule(
    service: ref.watch(_installationServiceInjectionProvider),
  );
}

/// Packs consumer injection. Exposes [PacksConsumerRule].
/// Inyección del consumidor de packs. Expone [PacksConsumerRule].
@Riverpod(keepAlive: true)
PacksConsumerRule packsConsumerInjection(Ref ref) {
  return PacksConsumerRule(
    service: ref.watch(_packsServiceInjectionProvider),
  );
}

/// Settings consumer injection. Exposes [SettingsConsumerRule].
/// Inyección del consumidor de configuración. Expone [SettingsConsumerRule].
@Riverpod(keepAlive: true)
SettingsConsumerRule settingsConsumerInjection(Ref ref) {
  return SettingsConsumerRule(
    service: ref.watch(_settingsServiceInjectionProvider),
  );
}

/// Software consumer injection. Exposes [SoftwareConsumerRule].
/// Inyección del consumidor de software. Expone [SoftwareConsumerRule].
@Riverpod(keepAlive: true)
SoftwareConsumerRule softwareConsumerInjection(Ref ref) {
  return SoftwareConsumerRule(
    service: ref.watch(_softwareServiceInjectionProvider),
  );
}

/// Categories consumer injection. Exposes [CategoriesConsumerRule].
/// Inyección del consumidor de categorías. Expone [CategoriesConsumerRule].
@Riverpod(keepAlive: true)
CategoriesConsumerRule categoriesConsumerInjection(Ref ref) {
  return CategoriesConsumerRule(
    service: ref.watch(_categoriesServiceInjectionProvider),
  );
}

/// Installer frameworks consumer injection. Exposes [InstallerFrameworksConsumerRule].
/// Inyección del consumidor de frameworks de instalador. Expone [InstallerFrameworksConsumerRule].
@Riverpod(keepAlive: true)
InstallerFrameworksConsumerRule installerFrameworksConsumerInjection(Ref ref) {
  return InstallerFrameworksConsumerRule(
    service: ref.watch(_installerFrameworksServiceInjectionProvider),
  );
}

/// Logs consumer injection. Exposes [LogsConsumerRule].
/// Inyección del consumidor de logs. Expone [LogsConsumerRule].
@Riverpod(keepAlive: true)
LogsConsumerRule logsConsumerInjection(Ref ref) {
  return LogsConsumerRule(
    service: ref.watch(_logsServiceInjectionProvider),
  );
}

/// Dependencies consumer injection. Exposes [DependenciesConsumerRule].
/// Inyección del consumidor de dependencias. Expone [DependenciesConsumerRule].
@Riverpod(keepAlive: true)
DependenciesConsumerRule dependenciesConsumerInjection(Ref ref) {
  return DependenciesConsumerRule(
    service: ref.watch(_dependenciesServiceInjectionProvider),
  );
}

/// Installers consumer injection. Exposes [InstallersConsumerRule].
/// Inyección del consumidor de instaladores. Expone [InstallersConsumerRule].
@Riverpod(keepAlive: true)
InstallersConsumerRule installersConsumerInjection(Ref ref) {
  return InstallersConsumerRule(
    service: ref.watch(_installersServiceInjectionProvider),
  );
}

/// Software registration consumer injection. Exposes [SoftwareRegistrationConsumerRule].
/// Inyección del consumidor de registro de software. Expone [SoftwareRegistrationConsumerRule].
@Riverpod(keepAlive: true)
SoftwareRegistrationConsumerRule softwareRegistrationConsumerInjection(Ref ref) {
  return SoftwareRegistrationConsumerRule(
    service: ref.watch(_softwareRegistrationServiceInjectionProvider),
  );
}
