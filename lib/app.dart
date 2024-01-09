import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:motion/motion.dart';

import 'constants/constants.dart';
import 'repository/local/shared_preference_repo.dart';
import 'root.dart';
import 'utils/app_colors.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(sharedPreference);
    if (!Motion.instance.isPermissionGranted) {
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
            title: "Aqsa Namaz Timing",
            theme: ThemeData(
              primaryColor: AppColors.ans,
              scaffoldBackgroundColor: AppColors.ans,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(4),
                  backgroundColor: AppColors.ans,
                  minimumSize: const Size.fromHeight(40),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(4),
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
