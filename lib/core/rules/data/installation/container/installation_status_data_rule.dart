/// Installation status for queue tracking.
/// Estado de instalación en la cola.
enum InstallationStatusEnumRule {
  pending, // Recién creado, esperando turno
  queued, // En la cola, esperando su posición
  installing, // Ejecutándose ahora
  paused, // Pausado por el usuario
  cancelled, // Cancelado antes de completar
}
