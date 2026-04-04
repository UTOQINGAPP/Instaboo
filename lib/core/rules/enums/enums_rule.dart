// Domain enum types for data entities.
// Shared between rules and infra layers.

/// Installation type: auto or assisted.
/// Tipo de instalación: automática o asistida.
enum InstallationTypeEnumRule { auto, assisted }

/// Installation status for tracking progress.
/// Estado de instalación para seguimiento del progreso.
enum InstallationStatusEnumRule {
  pending,
  queued,
  installing,
  completed,
  failed,
  cancelled,
}

/// Final status for installation history records.
/// Estado final para registros del historial de instalaciones.
enum HistoryStatusEnumRule { success, failed, cancelled }

/// Type of setting value stored in system_settings.
/// Tipo de valor de configuración almacenado en system_settings.
enum SettingTypeEnumRule { string, integer, boolean, json }

/// Log level for application logs.
/// Nivel de log para registros de la aplicación.
enum LogLevelEnumRule { info, warning, error, debug }

/// Source type for an installation (software or pack).
/// Tipo de origen de una instalación (software o pack).
enum InstallationSourceTypeEnumRule { software, pack }

/// Type of installer source (file, url, command, etc.).
/// Tipo de origen del instalador (archivo, url, comando, etc.).
enum InstallerSourceTypeEnumRule {
  file,
  url,
  command,
  winget,
  chocolatey,
  custom,
}
