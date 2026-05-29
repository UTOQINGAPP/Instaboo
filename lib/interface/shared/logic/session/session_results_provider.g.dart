// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_results_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the queue snapshot from the last installation session.
/// Set by InstallingPage before navigating to ResultsPage.
/// Contiene el snapshot de la cola de la última sesión de instalación.
/// Lo establece InstallingPage antes de navegar a ResultsPage.

@ProviderFor(SessionResults)
final sessionResultsProvider = SessionResultsProvider._();

/// Holds the queue snapshot from the last installation session.
/// Set by InstallingPage before navigating to ResultsPage.
/// Contiene el snapshot de la cola de la última sesión de instalación.
/// Lo establece InstallingPage antes de navegar a ResultsPage.
final class SessionResultsProvider
    extends $NotifierProvider<SessionResults, List<QueueItemDataRule>> {
  /// Holds the queue snapshot from the last installation session.
  /// Set by InstallingPage before navigating to ResultsPage.
  /// Contiene el snapshot de la cola de la última sesión de instalación.
  /// Lo establece InstallingPage antes de navegar a ResultsPage.
  SessionResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionResultsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionResultsHash();

  @$internal
  @override
  SessionResults create() => SessionResults();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<QueueItemDataRule> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<QueueItemDataRule>>(value),
    );
  }
}

String _$sessionResultsHash() => r'1fe1ae28c3b1904dbfd9cd4d488884b9bb3600e1';

/// Holds the queue snapshot from the last installation session.
/// Set by InstallingPage before navigating to ResultsPage.
/// Contiene el snapshot de la cola de la última sesión de instalación.
/// Lo establece InstallingPage antes de navegar a ResultsPage.

abstract class _$SessionResults extends $Notifier<List<QueueItemDataRule>> {
  List<QueueItemDataRule> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<List<QueueItemDataRule>, List<QueueItemDataRule>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<QueueItemDataRule>, List<QueueItemDataRule>>,
              List<QueueItemDataRule>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
