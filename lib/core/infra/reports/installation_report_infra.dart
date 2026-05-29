import 'dart:io';

import 'package:instaboo/core/infra/machine/machine_info_collector_infra.dart';

/// Writes a plain-text (.log) installation report to C:\ProgramData\Instaboo\reports\.
/// Each call creates a new file named by date and time.
/// Machine data is sourced from [MachineInfoCollectorInfra] (cached).
///
/// Escribe un reporte de instalación en texto plano (.log) en C:\ProgramData\Instaboo\reports\.
/// Cada llamada crea un archivo nuevo con fecha y hora.
/// Los datos del equipo vienen de [MachineInfoCollectorInfra] (cacheados).
class InstallationReportInfra {
  InstallationReportInfra._();

  static const String _reportFolder = r'C:\ProgramData\Instaboo\reports';

  /// Writes one report file for a single installation event.
  ///
  /// [softwareName]    : display name of the installed software.
  /// [softwareVersion] : version string, or null if unknown.
  /// [installerType]   : installer framework (NSIS, MSI, etc.), or null.
  /// [status]          : 'exitoso', 'fallido' or 'cancelado'.
  /// [startedAt]       : when the installation started.
  /// [completedAt]     : when the installation finished.
  /// [errorDetails]    : error message, only relevant when status is 'fallido'.
  ///
  /// Escribe un archivo de reporte por cada evento de instalación.
  static Future<void> writeReport({
    required String softwareName,
    String? softwareVersion,
    String? installerType,
    required String status,
    required DateTime startedAt,
    required DateTime completedAt,
    String? errorDetails,
  }) async {
    try {
      // ── Datos del equipo (cacheados en MachineInfoCollectorInfra) ──────────
      final machine = await MachineInfoCollectorInfra.instance.collect();
      final computerName = machine['hostname'] as String? ?? Platform.localHostname;
      final userName     = machine['username'] as String? ?? 'Desconocido';
      final domain       = machine['domain']   as String?;
      final osVersion    = machine['osVersion'] as String? ?? Platform.operatingSystemVersion;
      final processors   = machine['processors'] as int? ?? Platform.numberOfProcessors;
      final totalRamMb   = machine['totalRamMb'] as int?;

      final duration = completedAt.difference(startedAt);

      // ── Nombre de archivo con timestamp ───────────────────────────────────
      final ts = _timestamp(completedAt);
      final fileName = 'instaboo_report_$ts.log';

      // ── Contenido del archivo ─────────────────────────────────────────────
      final buffer = StringBuffer();
      buffer.writeln('=' * 60);
      buffer.writeln('  REPORTE DE INSTALACIÓN - INSTABOO');
      buffer.writeln('=' * 60);
      buffer.writeln();

      buffer.writeln('DATOS DEL EQUIPO');
      buffer.writeln('-' * 40);
      buffer.writeln('Equipo          : $computerName');
      buffer.writeln('Usuario         : $userName');
      if (domain != null && domain.isNotEmpty) {
        buffer.writeln('Dominio         : $domain');
      }
      buffer.writeln('Sistema         : $osVersion');
      buffer.writeln('Procesadores    : $processors');
      if (totalRamMb != null) {
        final ramGb = (totalRamMb / 1024).toStringAsFixed(1);
        buffer.writeln('RAM             : $ramGb GB ($totalRamMb MB)');
      }
      buffer.writeln();

      buffer.writeln('DATOS DE LA INSTALACIÓN');
      buffer.writeln('-' * 40);
      buffer.writeln('Software        : $softwareName');
      if (softwareVersion != null && softwareVersion.isNotEmpty) {
        buffer.writeln('Versión         : $softwareVersion');
      }
      if (installerType != null && installerType.isNotEmpty) {
        buffer.writeln('Tipo instalador : $installerType');
      }
      buffer.writeln('Estado          : ${status.toUpperCase()}');
      buffer.writeln('Fecha           : ${_formatDate(completedAt)}');
      buffer.writeln('Hora inicio     : ${_formatTime(startedAt)}');
      buffer.writeln('Hora fin        : ${_formatTime(completedAt)}');
      buffer.writeln('Duración        : ${_formatDuration(duration)}');

      if (errorDetails != null && errorDetails.isNotEmpty) {
        buffer.writeln();
        buffer.writeln('DETALLE DEL ERROR');
        buffer.writeln('-' * 40);
        buffer.writeln(errorDetails);
      }

      buffer.writeln();
      buffer.writeln('=' * 60);

      // ── Escritura en disco ────────────────────────────────────────────────
      final folder = Directory(_reportFolder);
      if (!await folder.exists()) {
        await folder.create(recursive: true);
      }

      final file = File('$_reportFolder\\$fileName');
      await file.writeAsString(buffer.toString(), flush: true);
    } catch (_) {
      // El reporte es una función secundaria; nunca debe interrumpir la instalación.
      // The report is secondary; it must never interrupt the installation flow.
    }
  }

  // ── Helpers de formato ──────────────────────────────────────────────────────

  static String _timestamp(DateTime dt) =>
      '${dt.year}'
      '${dt.month.toString().padLeft(2, '0')}'
      '${dt.day.toString().padLeft(2, '0')}'
      '_'
      '${dt.hour.toString().padLeft(2, '0')}'
      '${dt.minute.toString().padLeft(2, '0')}'
      '${dt.second.toString().padLeft(2, '0')}';

  static String _formatDate(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}/'
      '${dt.month.toString().padLeft(2, '0')}/'
      '${dt.year}';

  static String _formatTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:'
      '${dt.minute.toString().padLeft(2, '0')}:'
      '${dt.second.toString().padLeft(2, '0')}';

  static String _formatDuration(Duration d) {
    if (d.inSeconds < 60) return '${d.inSeconds} segundos';
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '${m}m ${s}s';
  }
}
