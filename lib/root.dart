import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/common/select_city_dialog.dart';
import 'package:jalgaon_namaz_timing/constants/constants.dart';
import 'package:jalgaon_namaz_timing/screens/start_page.dart';

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
          return const StartPage();
        },
        error: (e, s) {
          print(e.toString());
          return Text(e.toString());
        },
        loading: () => const CircularProgressIndicator());
  }
}
