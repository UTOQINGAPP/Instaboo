import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/core.dart';
import 'package:instaboo/interface/shared/injections/injections_shared.dart';

/// Loads the full list of Windows-installed programs from the registry
/// via [softwareConsumerInjection] (R13 — interface/ only accesses core/
/// through consumers).
///
/// The matching algorithm lives in [InstalledSoftwareInfoRule.findBestMatch] —
/// interface/ must not re-implement it here.
///
/// Carga la lista de programas instalados a través del consumer de software.
/// El algoritmo de matching vive en InstalledSoftwareInfoRule.findBestMatch —
/// interface/ no debe reimplementarlo aquí.
final installedSoftwareProvider =
    FutureProvider<List<InstalledSoftwareInfoRule>>((ref) async {
  final consumer = ref.read(softwareConsumerInjectionProvider);
  final response = await consumer.getInstalledFromRegistry();
  return response.resolve(
    onSuccess: (data, _) => data,
    onFailure: (_, _) => const [],
  );
});

/// Derives a lookup map keyed by normalised display-name (lower-case) so the
/// UI can do O(1) exact lookups before falling back to a linear scan.
///
/// Mapa de búsqueda derivado de [installedSoftwareProvider], indexado por
/// nombre en minúsculas para búsquedas O(1) en la UI.
final installedSoftwareMapProvider =
    FutureProvider<Map<String, InstalledSoftwareInfoRule>>((ref) async {
  final list = await ref.watch(installedSoftwareProvider.future);
  return {for (final e in list) e.displayName.toLowerCase(): e};
});
