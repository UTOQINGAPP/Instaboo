import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/core/infra/infra_core.dart';
import 'package:instaboo/core/rules/data/data_rules.dart';

/// Loads the full list of Windows-installed programs from the registry.
/// keepAlive so it persists across navigation and can be invalidated after
/// a batch installation completes.
///
/// Carga la lista de programas instalados. keepAlive para persistir entre
/// navegaciones y poder invalidarse al terminar una instalación.
final installedSoftwareProvider =
    FutureProvider<List<InstalledSoftwareInfoRule>>((ref) async {
  return WindowsRegistryInfra.getAll();
});

/// Convenience provider that builds a lookup map: lowercased display name → info.
/// Makes O(1) lookups from the library and installer pages.
///
/// Provider auxiliar: mapa lowercase → info para búsquedas O(1).
final installedSoftwareMapProvider =
    FutureProvider<Map<String, InstalledSoftwareInfoRule>>((ref) async {
  final list = await ref.watch(installedSoftwareProvider.future);
  return {for (final e in list) e.displayName.toLowerCase(): e};
});

/// Normalises a name for fuzzy matching:
/// - lowercase
/// - strip trailing version numbers and parenthetical suffixes like "(64-bit x86)"
/// - collapse whitespace
/// Normaliza un nombre para matching difuso.
String _norm(String s) => s
    .toLowerCase()
    .replaceAll(RegExp(r'\s*\(.*?\)'), '') // remove (parenthetical)
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

/// Compact form: remove ALL whitespace for comparisons like "notepad++" vs "notepad ++".
/// Forma compacta: elimina todos los espacios.
String _compact(String s) =>
    s.toLowerCase().replaceAll(RegExp(r'\s+'), '');

/// Returns the best-matching installed entry for [softwareName], or null.
/// Uses the cached map — does NOT re-query the registry.
InstalledSoftwareInfoRule? findInstalled(
  Map<String, InstalledSoftwareInfoRule> map,
  String softwareName,
) {
  if (softwareName.trim().isEmpty) return null;

  final query     = softwareName.toLowerCase().trim();
  final queryNorm = _norm(softwareName);
  final queryCpct = _compact(softwareName);

  for (final entry in map.entries) {
    final key      = entry.key;              // already lowercase
    final keyNorm  = _norm(key);
    final keyCpct  = _compact(key);

    // 1. Exact (original lowercase)
    if (key == query) return entry.value;

    // 2. Exact after normalisation (strips parentheticals & extra spaces)
    if (keyNorm == queryNorm) return entry.value;

    // 3. Compact match (handles "notepad ++" vs "notepad++")
    if (keyCpct == queryCpct) return entry.value;

    // 4. Compact contains (registry entry starts with query, e.g. "notepad++ 8.6")
    if (keyCpct.contains(queryCpct) || queryCpct.contains(keyCpct)) {
      return entry.value;
    }
  }

  return null;
}
