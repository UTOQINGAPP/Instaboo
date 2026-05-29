import 'package:instaboo/core/rules/data/data_rules.dart';
import 'package:instaboo/core/rules/responses/responses_rules.dart';
import 'package:instaboo/core/rules/services/services_rules.dart';

/// Installation consumer implementation. Delegates to [InstallationServiceRule].
/// Implementación del consumer de instalaciones. Delega a [InstallationServiceRule].
class InstallationConsumerRule {
  
  /// The service used to perform the operations.
  /// El servicio usado para realizar las operaciones.
  final InstallationServiceRule _service;

  /// Constructor.
  /// Constructor.
  InstallationConsumerRule({required InstallationServiceRule service})
    : _service = service;

  /// Queues a software for installation.
  /// Encola un software para instalación.
  Future<ResponseRule<QueueItemDataRule>> queueSoftware(
    int softwareId,
    {int? packId}
  ) {
    return _service.queueSoftware(softwareId, packId: packId);
  }

  /// Creates a record in installation_queue with status=pending
  /// Crea un registro en installation_queue con status=pending
  Future<ResponseRule<QueueItemDataRule>> queuePack(int packId) {
    return _service.queuePack(packId);
  }
  
  /// Moves pending → queued and assigns queue_position
  /// Mueve pending → queued y asigna queue_position
  Future<ResponseRule<Unit>> enqueuePending() {
    return _service.enqueuePending();
  }
  
  /// Returns the queue of installation items.
  /// Devuelve la cola de items de instalación.
  Future<ResponseRule<List<QueueItemDataRule>>> getQueue({String? status}) {
    return _service.getQueue(status: status);
  }
  
  /// Cancels an installation item.
  /// Cancela un item de instalación.
  Future<ResponseRule<Unit>> cancelQueueItem(int queueItemId) {
    return _service.cancelQueueItem(queueItemId);
  }
  
  /// Starts the next installation item in the queue.
  /// Inicia el siguiente item de la cola.
  Future<ResponseRule<Unit>> startInstallation() {
    return _service.startInstallation();
  }

  /// Marks the next queued item as 'installing' only if fewer than
  /// [maxConcurrent] items are currently installing.
  /// Returns the id of the newly marked item, or null when the queue
  /// is empty or already at capacity.
  ///
  /// Marca el siguiente item en cola como 'installing' sólo si hay
  /// menos de [maxConcurrent] items instalando. Devuelve el id del
  /// item marcado, o null si la cola está vacía o en capacidad.
  Future<ResponseRule<int?>> startNextInstallation(int maxConcurrent) {
    return _service.startNextInstallation(maxConcurrent);
  }

  
  /// Updates the progress of an installation item.
  /// Actualiza el progreso de un item de instalación.
  Future<ResponseRule<Unit>> updateProgress(int queueItemId, int progress) {
    return _service.updateProgress(queueItemId, progress);
  }
  
  /// Completes an installation item.
  /// Completa un item de instalación.
  Future<ResponseRule<Unit>> completeInstallation(int queueItemId) {
    return _service.completeInstallation(queueItemId);
  }

  /// Fails an installation item.
  /// Fallo un item de instalación.
  Future<ResponseRule<Unit>> failInstallation(
    int queueItemId,
    String errorMessage
  ) {
    return _service.failInstallation(queueItemId, errorMessage);
  }

  /// Pauses the current queue.
  /// Pausa la cola actual.
  Future<ResponseRule<Unit>> pauseQueue() {
    return _service.pauseQueue();
  }

  /// Returns the history of installation items.
  /// Devuelve el historial de items de instalación. 
  Future<ResponseRule<List<HistoryDataRule>>> getHistory({
    int? softwareId,
    String? status,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return _service.getHistory(softwareId: softwareId, status: status, fromDate: fromDate, toDate: toDate);
  }
  
  /// Returns the detail of a history item.
  /// Devuelve el detalle de un item de historial.
  Future<ResponseRule<HistoryDataRule>> getHistoryDetail(int historyId) {
    return _service.getHistoryDetail(historyId);
  }
  
  /// Returns the number of installed items.
  /// Devuelve el número de items instalados.
  Future<ResponseRule<int>> getInstalledCount() {
    return _service.getInstalledCount();
  }
  
  /// Returns the number of failed items.
  /// Devuelve el número de items fallidos.
  Future<ResponseRule<int>> getFailedCount({DateTime? sinceDate}) {
    return _service.getFailedCount(sinceDate: sinceDate);
  }
  
  /// Returns the statistics of installation items.
  /// Devuelve las estadísticas de items de instalación.
  Future<ResponseRule<InstallationStatsDataRule>> getStats() {
    return _service.getStats();
  }
  
}