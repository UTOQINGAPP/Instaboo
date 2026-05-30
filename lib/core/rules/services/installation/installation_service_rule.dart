import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';

/// Contract for installation resolution and persistence.
/// Contrato para resolución y persistencia de instalaciones.
abstract class InstallationServiceRule {
  
  /// Queues a software for installation.
  /// Encola un software para instalación.
  Future<ResponseRule<QueueItemDataRule>> queueSoftware(
    int softwareId,
    {int? packId}
  );

  /// Creates a record in installation_queue with status=pending
  /// Crea un registro en installation_queue con status=pending
  Future<ResponseRule<QueueItemDataRule>> queuePack(int packId);
  
  /// Moves pending → queued and assigns queue_position
  /// Mueve pending → queued y asigna queue_position
  Future<ResponseRule<Unit>> enqueuePending();

  /// Removes every row from the installation queue. The history table is left
  /// untouched. Used to keep the queue empty at app start and after a session.
  /// Elimina todas las filas de la cola de instalación. El historial no se toca.
  /// Se usa para mantener la cola vacía al iniciar la app y al terminar.
  Future<ResponseRule<Unit>> clearQueue();
  
  /// Returns the queue of installation items.
  /// Devuelve la cola de items de instalación.
  Future<ResponseRule<List<QueueItemDataRule>>> getQueue({String? status});
  
  /// Cancels an installation item.
  /// Cancela un item de instalación.
  Future<ResponseRule<Unit>> cancelQueueItem(int queueItemId);
  
  /// Starts the next installation item in the queue.
  /// Inicia el siguiente item de la cola.
  Future<ResponseRule<Unit>> startInstallation();

  /// Marks the next queued item as 'installing' only if fewer than
  /// [maxConcurrent] items are currently installing.
  /// Returns the id of the newly marked item, or null when the queue
  /// is empty or already at capacity.
  ///
  /// Marca el siguiente item en cola como 'installing' sólo si hay
  /// menos de [maxConcurrent] items instalando actualmente.
  /// Devuelve el id del item marcado, o null si la cola está vacía
  /// o ya está en capacidad.
  Future<ResponseRule<int?>> startNextInstallation(int maxConcurrent);

  
  /// Updates the progress of an installation item.
  /// Actualiza el progreso de un item de instalación.
  Future<ResponseRule<Unit>> updateProgress(int queueItemId, int progress);
  
  /// Completes an installation item.
  /// Completa un item de instalación.
  Future<ResponseRule<Unit>> completeInstallation(int queueItemId);

  /// Fails an installation item.
  /// Fallo un item de instalación.
  Future<ResponseRule<Unit>> failInstallation(
    int queueItemId,
    String errorMessage
  );

  /// Pauses the current queue.
  /// Pausa la cola actual.
  Future<ResponseRule<Unit>> pauseQueue();

  /// Returns the history of installation items.
  /// Devuelve el historial de items de instalación. 
  Future<ResponseRule<List<HistoryDataRule>>> getHistory({
    int? softwareId,
    String? status,
    DateTime? fromDate,
    DateTime? toDate,
  });
  
  /// Returns the detail of a history item.
  /// Devuelve el detalle de un item de historial.
  Future<ResponseRule<HistoryDataRule>> getHistoryDetail(int historyId);
  
  /// Returns the number of installed items.
  /// Devuelve el número de items instalados.
  Future<ResponseRule<int>> getInstalledCount();
  
  /// Returns the number of failed items.
  /// Devuelve el número de items fallidos.
  Future<ResponseRule<int>> getFailedCount({DateTime? sinceDate});
  
  /// Returns the statistics of installation items.
  /// Devuelve las estadísticas de items de instalación.
  Future<ResponseRule<InstallationStatsDataRule>> getStats();
  
}