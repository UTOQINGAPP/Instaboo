import 'dart:convert';
import 'dart:io';

import 'package:instaboo/core/rules/data/data_rules.dart';

/// Reads the Windows uninstall registry to discover installed programs.
/// Uses PowerShell to query the three standard registry paths and returns
/// a normalised list. Results are cached for the lifetime of the process.
///
/// Lee el registro de desinstalación de Windows para detectar programas
/// instalados. Usa PowerShell para consultar las tres rutas estándar y
/// devuelve una lista normalizada. Los resultados se cachean por proceso.
class WindowsRegistryInfra {
  WindowsRegistryInfra._();

  static List<InstalledSoftwareInfoRule>? _cache;

  // ── PowerShell script ──────────────────────────────────────────────────────

  static const String _psScript = r'''
$paths = @(
  'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
  'HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
  'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
)
$apps = $paths | ForEach-Object {
  Get-ItemProperty $_ -ErrorAction SilentlyContinue
} | Where-Object { $_.DisplayName } |
  Select-Object DisplayName, DisplayVersion, Publisher |
  Sort-Object DisplayName -Unique
$apps | ConvertTo-Json -Compress
''';

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Returns all installed programs found in the Windows registry.
  /// Caches after the first call; pass [forceRefresh] to invalidate.
  ///
  /// Devuelve todos los programas instalados encontrados en el registro.
  /// Cachea tras la primera llamada; pasa [forceRefresh] para invalidar.
  static Future<List<InstalledSoftwareInfoRule>> getAll({
    bool forceRefresh = false,
  }) async {
    if (_cache != null && !forceRefresh) return _cache!;
    _cache = await _query();
    return _cache!;
  }

  /// Returns the installed entry whose display name best matches [softwareName],
  /// or null if not found. Matching is case-insensitive; tries exact match first,
  /// then "contains" as fallback.
  ///
  /// Devuelve la entrada instalada cuyo nombre coincide mejor con [softwareName],
  /// o null si no se encuentra. Comparación sin distinción de mayúsculas.
  static Future<InstalledSoftwareInfoRule?> findMatch(
      String softwareName) async {
    final all = await getAll();
    final query = softwareName.toLowerCase().trim();

    // 1. Exact match
    final exact = all
        .where((e) => e.displayName.toLowerCase() == query)
        .firstOrNull;
    if (exact != null) return exact;

    // 2. Registry name contains query
    final contains = all
        .where((e) => e.displayName.toLowerCase().contains(query))
        .firstOrNull;
    if (contains != null) return contains;

    // 3. Query contains registry name (short registry entry vs long name)
    return all
        .where((e) => query.contains(e.displayName.toLowerCase()))
        .firstOrNull;
  }

  /// Invalidates the cache so the next call re-reads from the registry.
  static void invalidateCache() => _cache = null;

  // ── Private ────────────────────────────────────────────────────────────────

  static Future<List<InstalledSoftwareInfoRule>> _query() async {
    try {
      final result = await Process.run(
        'powershell.exe',
        ['-NoProfile', '-NonInteractive', '-Command', _psScript],
        runInShell: false,
        stdoutEncoding: utf8,
        stderrEncoding: utf8,
      );

      if (result.exitCode != 0) return [];
      final raw = (result.stdout as String).trim();
      if (raw.isEmpty || raw == 'null') return [];

      final dynamic decoded = jsonDecode(raw);

      // PowerShell returns an object (not array) when only 1 entry matches.
      // PowerShell devuelve un objeto (no array) cuando solo hay 1 resultado.
      final List<dynamic> list =
          decoded is List ? decoded : [decoded];

      return list
          .whereType<Map<String, dynamic>>()
          .map(_fromJson)
          .whereType<InstalledSoftwareInfoRule>()
          .toList();
    } catch (_) {
      return [];
    }
  }

  static InstalledSoftwareInfoRule? _fromJson(Map<String, dynamic> json) {
    final name = json['DisplayName'];
    if (name == null || name.toString().trim().isEmpty) return null;
    return InstalledSoftwareInfoRule(
      displayName: name.toString().trim(),
      displayVersion: json['DisplayVersion']?.toString().trim(),
      publisher: json['Publisher']?.toString().trim(),
    );
  }
}
