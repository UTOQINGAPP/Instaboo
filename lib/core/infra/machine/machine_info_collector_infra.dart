import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

/// Collects Windows machine information once and caches the result.
/// Uses [Platform] for instantly available data and a direct Win32 FFI call
/// (GlobalMemoryStatusEx) for total RAM — no external process, works on both
/// Windows 10 and 11 (wmic is deprecated/removed on recent Win11).
///
/// Recopila información del equipo Windows una vez y la cachea.
/// Usa [Platform] para datos inmediatos y una llamada FFI directa a Win32
/// (GlobalMemoryStatusEx) para la RAM total — sin proceso externo; funciona en
/// Windows 10 y 11 (wmic está deprecado/retirado en Win11 reciente).
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

    // Total physical RAM via a direct Win32 FFI call (bytes -> MB).
    // RAM física total vía llamada FFI directa a Win32 (bytes -> MB).
    int? totalRamMb;
    try {
      totalRamMb = _readTotalPhysicalMemoryMb();
    } catch (_) {
      // FFI unavailable — leave RAM as null.
      // FFI no disponible — RAM queda como null.
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

// ─── Win32 FFI: total physical memory ───────────────────────────────────────

/// MEMORYSTATUSEX (kernel32). 64 bytes; [dwLength] must be set before the call.
/// MEMORYSTATUSEX (kernel32). 64 bytes; [dwLength] debe fijarse antes de llamar.
final class _MemoryStatusEx extends Struct {
  @Uint32()
  external int dwLength;
  @Uint32()
  external int dwMemoryLoad;
  @Uint64()
  external int ullTotalPhys;
  @Uint64()
  external int ullAvailPhys;
  @Uint64()
  external int ullTotalPageFile;
  @Uint64()
  external int ullAvailPageFile;
  @Uint64()
  external int ullTotalVirtual;
  @Uint64()
  external int ullAvailVirtual;
  @Uint64()
  external int ullAvailExtendedVirtual;
}

typedef _GlobalMemoryStatusExNative = Int32 Function(Pointer<_MemoryStatusEx>);
typedef _GlobalMemoryStatusExDart = int Function(Pointer<_MemoryStatusEx>);

/// Returns total physical memory in MB via GlobalMemoryStatusEx, or null when
/// unavailable (non-Windows or a failed call).
/// Devuelve la RAM física total en MB vía GlobalMemoryStatusEx, o null si no
/// está disponible (no-Windows o llamada fallida).
int? _readTotalPhysicalMemoryMb() {
  if (!Platform.isWindows) return null;
  final kernel32 = DynamicLibrary.open('kernel32.dll');
  final globalMemoryStatusEx = kernel32.lookupFunction<
      _GlobalMemoryStatusExNative, _GlobalMemoryStatusExDart>(
    'GlobalMemoryStatusEx',
  );
  final buffer = calloc<_MemoryStatusEx>();
  try {
    buffer.ref.dwLength = sizeOf<_MemoryStatusEx>();
    final ok = globalMemoryStatusEx(buffer);
    if (ok == 0) return null;
    return (buffer.ref.ullTotalPhys / (1024 * 1024)).round();
  } finally {
    calloc.free(buffer);
  }
}
