import 'package:instaboo/core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_results_provider.g.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Session results snapshot
// ─────────────────────────────────────────────────────────────────────────────

/// Holds the queue snapshot from the last installation session.
/// Set by InstallingPage before navigating to ResultsPage.
/// Contiene el snapshot de la cola de la última sesión de instalación.
/// Lo establece InstallingPage antes de navegar a ResultsPage.
@Riverpod(keepAlive: true)
class SessionResults extends _$SessionResults {
  @override
  List<QueueItemDataRule> build() => const [];

  /// Replaces the in-memory snapshot with [items] from the current session.
  /// Reemplaza el snapshot en memoria con [items] de la sesión actual.
  void setSnapshot(List<QueueItemDataRule> items) {
    state = items;
  }
}
