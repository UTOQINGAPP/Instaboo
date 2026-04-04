import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:instaboo/core/rules/rules_core.dart';
import 'package:instaboo/core/uses/uses_core.dart';

part 'injections_shared.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Services (core/uses/services/container)
// ─────────────────────────────────────────────────────────────────────────────

/// Installation service injection. Exposes [InstallationServiceRule].
/// Inyección del servicio de instalaciones. Expone [InstallationServiceRule].
@Riverpod(keepAlive: true)
InstallationServiceRule _installationServiceInjection(Ref ref) {
  return InstallationServiceUse();
}

/// Pack service injection. Exposes [PackServiceRule].
/// Inyección del servicio de packs. Expone [PackServiceRule].
@Riverpod(keepAlive: true)
PackServiceRule _packServiceInjection(Ref ref) {
  return PackServiceUse();
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

/// Tracking service injection. Exposes [TrackingServiceRule].
/// Inyección del servicio de seguimiento. Expone [TrackingServiceRule].
@Riverpod(keepAlive: true)
TrackingServiceRule _trackingServiceInjection(Ref ref) {
  return TrackingServiceUse();
}

/// Categories service injection. Exposes [CategoriesServiceRule].
/// Inyección del servicio de categorías. Expone [CategoriesServiceRule].
@Riverpod(keepAlive: true)
CategoriesServiceRule _categoriesServiceInjection(Ref ref) {
  return CategoriesServiceUse();
}

// ─────────────────────────────────────────────────────────────────────────────
// Consumers (core/uses/consumers/container)
// ─────────────────────────────────────────────────────────────────────────────

/// Installation consumer injection. Exposes [InstallationConsumerRule].
/// Inyección del consumidor de instalaciones. Expone [InstallationConsumerRule].
@Riverpod(keepAlive: true)
InstallationConsumerRule installationConsumerInjection(Ref ref) {
  return InstallationConsumerRule(
    service: ref.watch(_installationServiceInjectionProvider),
  );
}

/// Pack consumer injection. Exposes [PackConsumerRule].
/// Inyección del consumidor de packs. Expone [PackConsumerRule].
@Riverpod(keepAlive: true)
PackConsumerRule packConsumerInjection(Ref ref) {
  return PackConsumerRule(service: ref.watch(_packServiceInjectionProvider));
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

/// Tracking consumer injection. Exposes [TrackingConsumerRule].
/// Inyección del consumidor de seguimiento. Expone [TrackingConsumerRule].
@Riverpod(keepAlive: true)
TrackingConsumerRule trackingConsumerInjection(Ref ref) {
  return TrackingConsumerRule(
    service: ref.watch(_trackingServiceInjectionProvider),
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
