import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jalgaon_namaz_timing/root.dart';
import 'package:motion/motion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Motion.instance.initialize();
  Motion.instance.setUpdateInterval(60.fps);
  runApp(const ProviderScope(child: Home()));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Motion.instance.requiresPermission &&
        !Motion.instance.isPermissionGranted) {
      showPermissionRequestDialog(context);
    }
    return MaterialApp(
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en', ''),
      //   Locale('ur', ''),
      //   Locale('hi', ''),
      // ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: "Jalgaon Namaz Timing",
      theme: ThemeData(
        // textTheme: TextTheme(
        //   headline1: TextStyle(color: )
        // ),
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
