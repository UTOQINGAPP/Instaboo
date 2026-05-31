/// Typed status of an item in the installation queue.
/// Replaces raw DB strings so the compiler enforces exhaustiveness.
///
/// Estado tipado de un item en la cola de instalación.
/// Reemplaza strings crudos de la BD para que el compilador exija exhaustividad.
enum InstallationStatusEnumRule {
  pending,    // Recién creado, esperando turno
  queued,     // En la cola, esperando su posición
  installing, // Ejecutándose ahora
  paused,     // Pausado por el usuario
  cancelled,  // Cancelado antes de completar
  completed,  // Instalado exitosamente
  failed;     // Falló durante la instalación

  // ── Semantic queries ────────────────────────────────────────────────────────

  /// True when the item has reached a final, immutable state.
  /// Verdadero cuando el item llegó a un estado final inmutable.
  bool get isTerminal =>
      this == cancelled || this == paused ||
      this == completed || this == failed;

  /// True when the item is still progressing or waiting to progress.
  /// Verdadero cuando el item sigue en progreso o esperando progresar.
  bool get isInProgress =>
      this == pending || this == queued || this == installing;

  // ── Parsing ─────────────────────────────────────────────────────────────────

  /// Creates from the raw string stored in the database.
  /// Unknown strings map to [pending] as a safe default.
  /// Construye desde el string crudo de la BD. Strings desconocidos → pending.
  static InstallationStatusEnumRule fromRaw(String raw) => switch (raw) {
        'pending'    => pending,
        'queued'     => queued,
        'installing' => installing,
        'paused'     => paused,
        'cancelled'  => cancelled,
        'completed'  => completed,
        'failed'     => failed,
        _            => pending,
      };
}
