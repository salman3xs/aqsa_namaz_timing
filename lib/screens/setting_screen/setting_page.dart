import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/select_city_dialog.dart';

class SettingPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              showDialog(context: context, builder: (_) => SelectCityDialog());
            },
            child: Text('Change City'))
      ],
    );
  }
}
