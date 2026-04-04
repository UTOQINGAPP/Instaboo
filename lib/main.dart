import 'package:flutter/material.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instaboo/interface/interface.dart';
 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await Window.setEffect(
  effect: WindowEffect.acrylic,
  color: Color(0xCC222222),
);
  runApp(const ProviderScope(child: AppInterface()));
}
 
