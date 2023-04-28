import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:motion/motion.dart';
import 'app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Motion.instance.initialize();
  Motion.instance.setUpdateInterval(60.fps);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: Home()));
}