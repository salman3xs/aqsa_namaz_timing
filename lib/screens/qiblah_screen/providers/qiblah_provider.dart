// import 'dart:async';
// import 'package:flutter_qiblah/flutter_qiblah.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';

// final qiblahProvider = StreamProvider((ref) => QiblahProvier().stream());

// class QiblahProvier {
//   // ignore: close_sinks
//   final locationStreamController = StreamController<LocationStatus>.broadcast();
//   get stream => locationStreamController.stream;

//   Future<bool?> getDeviceInfo() async {
//     return await FlutterQiblah.androidDeviceSensorSupport();
//   }

//   Stream<QiblahDirection?> getQiblah() {
//     return FlutterQiblah.qiblahStream;
//   }

//   Future<void> checkLocationStatus() async {
//     await Geolocator.requestPermission();
//     final locationStatus = await FlutterQiblah.checkLocationStatus();
//     if (locationStatus.enabled &&
//         locationStatus.status == LocationPermission.denied) {
//       await FlutterQiblah.requestPermissions();
//       final s = await FlutterQiblah.checkLocationStatus();
//       locationStreamController.sink.add(s);
//     } else
//       locationStreamController.sink.add(locationStatus);
//   }
// }
