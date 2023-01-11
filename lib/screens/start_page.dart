import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jalgaon_namaz_timing/Screens/home_screen/home_page.dart';
import 'package:jalgaon_namaz_timing/repository/local/shared_preference_repo.dart';
import 'package:jalgaon_namaz_timing/screens/qiblah_screen/qiblah_page.dart';
import 'package:jalgaon_namaz_timing/screens/setting_screen/setting_page.dart';

final selectedPageProvider = StateProvider<int>((ref) {
  return 0;
});

class StartPage extends ConsumerWidget {
  StartPage({Key? key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pg = ref.watch(selectedPageProvider);
    final prefs = ref.watch(sharedPreference);
    return prefs.when(
        data: (data) => Scaffold(
              appBar: pg > 1 ? AppBar() : null,
              backgroundColor: Theme.of(context).primaryColor,
              body: [HomePage(), QiblahPage(), SettingPage()][pg],
              bottomNavigationBar: CurvedNavigationBar(
                color: Theme.of(context).primaryColor,
                buttonBackgroundColor: Colors.white,
                backgroundColor: Theme.of(context).primaryColor,
                items: [
                  Icon(
                    Icons.home,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  Icon(
                    Icons.not_listed_location,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  Icon(
                    Icons.settings,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
                onTap: (index) {
                  ref.read(selectedPageProvider.notifier).state = index;
                },
              ),
            ),
        error: (e, s) {
          print(e.toString());
          return Text(e.toString());
        },
        loading: () => CircularProgressIndicator());
  }
}

