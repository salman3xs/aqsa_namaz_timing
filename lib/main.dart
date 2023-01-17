import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'constants/constants.dart';
import 'root.dart';
import 'package:motion/motion.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'repository/local/shared_preference_repo.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Motion.instance.initialize();
  Motion.instance.setUpdateInterval(60.fps);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const ProviderScope(child: Home()));
}

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(sharedPreference);
    if (Motion.instance.requiresPermission &&
        !Motion.instance.isPermissionGranted) {
      showPermissionRequestDialog(context);
    }
    return prefs.when(
        data: (data) {
          FlutterNativeSplash.remove();
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            locale: Locale(data == null
                ? 'en'
                : data.getString(PrefKeys.language) ?? 'en'),
            title: "Jalgaon Namaz Timing",
            theme: ThemeData(
              primaryColor: getColor(),
              scaffoldBackgroundColor: getColor(),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  primary: getColor(),
                  minimumSize: const Size.fromHeight(40),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  primary: Colors.white,
                  minimumSize: const Size.fromHeight(40),
                ),
              ),
            ),
            home: const Root(),
          );
        },
        error: (e, s) {
          print(e.toString());
          return Text(e.toString());
        },
        loading: () => const CircularProgressIndicator());
  }

  ThemeData getCurrentTheme() {
    TimeOfDay timeOfDay = TimeOfDay.now();
    if (timeOfDay.hour < 6 || timeOfDay.hour >= 18) {
      return ThemeData.dark();
    }
    return ThemeData.light();
  }

  Color? getColor() {
    final timeState = DateTime.now();
    final hour = timeState.hour;
    final isDay = hour >= 6 && hour <= 18;
    final isDusk = hour >= 16 && hour <= 18;
    if (!isDay) {
      return Colors.blueGrey[900];
    }
    if (isDusk) {
      return Colors.orange[400];
    }
    return Colors.blue[200];
  }

  Future<void> showPermissionRequestDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Permission required'),
              content: const Text(
                  'On iOS 13+, you need to grant access to the gyroscope. A permission will be requested to proceed.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Motion.instance.requestPermission();
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }
}
