import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/select_city_dialog.dart';
import 'constants/constants.dart';
import 'screens/start_page.dart';
import 'common/select_language_dailog.dart';
import 'repository/local/shared_preference_repo.dart';

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(sharedPreference);
    return prefs.when(
        data: (data) {
          if (data == null || data.getString(PrefKeys.city) == null) {
            return const Scaffold(
              body: Center(
                child: SelectCityDialog(),
              ),
            );
          }
          if (data.getString(PrefKeys.language) == null) {
            return const Scaffold(
              body: Center(
                child: SelectLanguageDialog(),
              ),
            );
          }
          return const StartPage();
        },
        error: (e, s) {
          print(e.toString());
          return Text(e.toString());
        },
        loading: () => const CircularProgressIndicator());
  }
}
