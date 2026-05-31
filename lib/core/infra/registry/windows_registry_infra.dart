import 'dart:convert';
import 'dart:io';

/// Reads the Windows uninstall registry to discover installed programs.
/// Uses PowerShell to query the three standard registry paths.
/// Returns raw [Map<String, dynamic>] entries — transformation is the
/// responsibility of [RegistryOriginUse] and [RegistryAdapterUse] in uses/.
///
/// Lee el registro de desinstalación de Windows para detectar programas
/// instalados. Devuelve entradas crudas [Map<String, dynamic>] — la
/// transformación es responsabilidad de RegistryOriginUse y RegistryAdapterUse.
class WindowsRegistryInfra {
  WindowsRegistryInfra._();

  static List<Map<String, dynamic>>? _cache;

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

  /// Returns raw registry entries as [Map<String, dynamic>].
  /// Caches after the first call; pass [forceRefresh] to invalidate.
  ///
  /// Devuelve las entradas crudas del registro como Map.
  /// Cachea tras la primera llamada; usa [forceRefresh] para invalidar.
  static Future<List<Map<String, dynamic>>> getAll({
    bool forceRefresh = false,
  }) async {
    if (_cache != null && !forceRefresh) return _cache!;
    _cache = await _query();
    return _cache!;
  }

  /// Invalidates the cache so the next call re-reads from the registry.
  /// Invalida la caché para que la siguiente llamada vuelva a leer del registro.
  static void invalidateCache() => _cache = null;

  // ── Private ────────────────────────────────────────────────────────────────

  static Future<List<Map<String, dynamic>>> _query() async {
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
      final List<dynamic> list = decoded is List ? decoded : [decoded];

      return list
          .whereType<Map<String, dynamic>>()
          .where((m) {
            final name = m['DisplayName'];
            return name != null && name.toString().trim().isNotEmpty;
          })
          .toList();
    } catch (_) {
      return [];
    }
  }
}
