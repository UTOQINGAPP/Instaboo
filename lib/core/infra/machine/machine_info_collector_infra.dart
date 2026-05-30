import 'dart:convert';
import 'dart:io';

/// Collects Windows machine information once and caches the result.
/// Uses [Platform] for instantly available data and [Process.run] for RAM
/// (via wmic), which is the only call that requires an OS subprocess.
///
/// Recopila información del equipo Windows una vez y la cachea.
/// Usa [Platform] para datos disponibles de inmediato y [Process.run]
/// para la RAM (vía wmic), que es la única llamada que requiere subproceso.
class MachineInfoCollectorInfra {
  MachineInfoCollectorInfra._();

  static final MachineInfoCollectorInfra instance =
      MachineInfoCollectorInfra._();

  /// Cached snapshot. Null until [collect] has been called.
  /// Snapshot cacheado. Null hasta que [collect] haya sido llamado.
  Map<String, dynamic>? _cache;

  /// Returns a JSON-serialisable map with the machine information.
  /// The result is cached after the first call — safe to call from
  /// [completeInstallation] and [failInstallation] without extra cost.
  ///
  /// Devuelve un mapa serializable a JSON con la información del equipo.
  /// El resultado se cachea tras la primera llamada.
  Future<Map<String, dynamic>> collect() async {
    if (_cache != null) return _cache!;

    final hostname = Platform.localHostname;
    final username = Platform.environment['USERNAME'] ??
        Platform.environment['USER'] ??
        'Desconocido';
    final domain = Platform.environment['USERDOMAIN'] ?? '';
    final osVersion = Platform.operatingSystemVersion;
    final processors = Platform.numberOfProcessors;

    // Collect total RAM via wmic (returns KB, convert to MB).
    // Recopila la RAM total vía wmic (devuelve KB, convierte a MB).
    int? totalRamMb;
    try {
      final result = await Process.run(
        'wmic',
        ['OS', 'get', 'TotalVisibleMemorySize', '/format:value'],
        runInShell: true,
      );
      final output = (result.stdout as String).trim();
      // Output format: "TotalVisibleMemorySize=16252928"
      final match = RegExp(r'TotalVisibleMemorySize=(\d+)').firstMatch(output);
      if (match != null) {
        final kb = int.tryParse(match.group(1)!);
        if (kb != null) totalRamMb = (kb / 1024).round();
      }
    } catch (_) {
      // wmic unavailable — leave RAM as null.
      // wmic no disponible — RAM queda como null.
    }

    _cache = {
      'hostname': hostname,
      'username': username,
      if (domain.isNotEmpty) 'domain': domain,
      'osVersion': osVersion,
      'processors': processors,
      'totalRamMb': ?totalRamMb,
    };

    return _cache!;
  }

  /// Serialises the cached (or freshly collected) machine info to a JSON
  /// string suitable for storage in the DB. Returns null on any error.
  ///
  /// Serializa la info del equipo a una cadena JSON para almacenar en DB.
  /// Devuelve null si ocurre cualquier error.
  Future<String?> toJson() async {
    try {
      final data = await collect();
      return jsonEncode(data);
    } catch (_) {
      return null;
    }
  }

  /// Clears the cache (useful between test sessions).
  /// Limpia el caché (útil entre sesiones de prueba).
  void reset() => _cache = null;
}
