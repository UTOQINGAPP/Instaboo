import 'package:flutter/material.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/interface/interface.dart';
import 'package:local_notifier/local_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await localNotifier.setup(appName: 'Instaboo');
  await Window.setEffect(
    effect: WindowEffect.acrylic,
    color: const Color(0xCC222222),
  );

  // Start every launch with an empty installation queue. The queue is transient
  // session data; the permanent record lives in the history table.
  // Cada arranque empieza con la cola de instalación vacía. La cola es data de
  // sesión transitoria; el registro permanente vive en la tabla de historial.
  final container = ProviderContainer();
  await container.read(installationConsumerInjectionProvider).clearQueue();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const AppInterface(),
    ),
  );
}
