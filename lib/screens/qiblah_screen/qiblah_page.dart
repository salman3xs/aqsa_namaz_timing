
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:jalgaon_namaz_timing/screens/qiblah_screen/compass_widget.dart';

class QiblahPage extends StatelessWidget {
 QiblahPage({Key? key}) : super(key: key);
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _deviceSupport,
      builder: (_, AsyncSnapshot<bool?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error.toString()}"),
          );
        }

        if (snapshot.data!) {
          return QiblahCompass();
        } else {
          return Container();
        }
      },
    );
  }
}
