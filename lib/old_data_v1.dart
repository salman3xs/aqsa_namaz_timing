// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'commonwidgets.dart';

// class home extends StatefulWidget {
//   @override
//   home_state createState() => home_state();
// }

// class home_state extends State<home> {
//   String? _timeString;
//   int cindex = 0;
//   final snackBar =
//       SnackBar(content: Text('There may be a difference of 1 min in time'));
//   void changepage(int index) {
//     setState(() {
//       cindex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     _getTime();
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50.0),
//         child: AppBar(
//           backgroundColor: Colors.green,
//           title: Text(' Jalgaon   ' + _timeString!),
//           leading: Builder(
//             builder: (context) => IconButton(
//               icon: Icon(Icons.person_rounded),
//               onPressed: () => Scaffold.of(context).openDrawer(),
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.help_outline,
//                 color: Colors.white,
//               ),
//               onPressed: () =>
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar),
//             )
//           ],
//         ),
//       ),
//       drawer: appdrawer(),
//       body: <Widget>[
//         TodayScreen(),
//         RamadanScreen(),
//       ][cindex],
//       bottomNavigationBar: BottomNavigationBar(
//         unselectedItemColor: Colors.green,
//         selectedItemColor: Colors.lightGreen,
//         currentIndex: cindex,
//         type: BottomNavigationBarType.shifting,
//         items: [
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.home,
//               ),
//               label: 'Today'),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.calendar_today_rounded,
//               ),
//               label: 'Ramadan'),
//         ],
//         onTap: changepage,
//       ),
//     );
//   }

//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
//   }

//   void _getTime() {
//     final String formattedDateTime =
//         DateFormat('dd MMM kk:mm').format(DateTime.now()).toString();
//     setState(() {
//       _timeString = formattedDateTime;
//     });
//   }
// }

// //Home Screen
// class TodayScreen extends StatefulWidget {
//   @override
//   TodayScreenState createState() => TodayScreenState();
// }

// class TodayScreenState extends State<TodayScreen> {
//   String? _dateString;
//   final List<String> entries = <String>[
//     'Namaz',
//     'Fajr',
//     'Zuhar',
//     'Asr',
//     'Maghrib',
//     'Isha',
//     'Sahri',
//     'Iftar',
//     'Tulu E Aftab',
//     'Zawal',
//     'Gurub E Aftab',
//     'Ishraq',
//     'Chasht'
//   ];
//   final List<Color> clr = <Color>[
//     Colors.blueAccent,
//     Colors.greenAccent,
//     Colors.greenAccent,
//     Colors.greenAccent,
//     Colors.greenAccent,
//     Colors.greenAccent,
//     Colors.lightBlueAccent,
//     Colors.lightBlueAccent,
//     Colors.redAccent,
//     Colors.redAccent,
//     Colors.redAccent,
//     Colors.lightBlueAccent,
//     Colors.lightBlueAccent
//   ];
//   List start_time = [];
//   List end_time = [];
//   @override
//   Widget build(BuildContext context) {
//     _getTime();
//     csvfile();
//     if (start_time.length == 0) {
//       return Center(child: CircularProgressIndicator());
//     } else {
//       return Container(
//         color: Colors.white,
//         child: ListView.builder(
//             padding: const EdgeInsets.all(8),
//             itemCount: entries.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Container(
//                 margin: EdgeInsets.all(10.0),
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black,
//                       blurRadius: 5.0,
//                     )
//                   ],
//                   color: clr[index],
//                 ),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text('${start_time[index]}'),
//                       Text('${entries[index]}'),
//                       Text('${end_time[index]}')
//                     ]),
//               );
//             }),
//       );
//     }
//   }

//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(minutes: 1), (Timer t) => _getTime());
//   }

//   void _getTime() {
//     final String formattedDateTime =
//         DateFormat('ddMMM').format(DateTime.now()).toString();
//     setState(() {
//       _dateString = formattedDateTime;
//     });
//   }

//   void csvfile() async {
//     final myData = await rootBundle.loadString('csv/Jalgaon Prayer Times.csv');
//     List<List<dynamic>> mylist = const CsvToListConverter().convert(myData);
//     for (var i = 1; i < 366; i++) {
//       List l = mylist[i];
//       var d = l[0];
//       var dsplit = d.split(' ');
//       var date = dsplit[1] + dsplit[2];
//       var date1 = '0' + dsplit[1] + dsplit[2];
//       if (date == _dateString || date1 == _dateString) {
//         setState(() {
//           start_time.clear();
//           end_time.clear();
//           start_time.add('Start');
//           end_time.add('End');
//           var a = l[1];
//           var a_time;
//           if (int.parse(a[2] + a[3]) - 5 > 60) {
//             a_time = TimeOfDay(
//                 hour: int.parse(a[0]) + 1,
//                 minute: int.parse(a[2] + a[3]) - 5 - 60);
//           } else
//             (a_time = TimeOfDay(
//                 hour: int.parse(a[0]), minute: int.parse(a[2] + a[3]) - 5));
//           var b = l[2];
//           var b_time;
//           if (int.parse(b[2] + b[3]) + 20 > 60) {
//             b_time = TimeOfDay(
//                 hour: int.parse(b[0]) + 1,
//                 minute: int.parse(b[2] + b[3]) + 20 - 60);
//           } else
//             (b_time = TimeOfDay(
//                 hour: int.parse(b[0]), minute: int.parse(b[2] + b[3]) + 20));
//           var g_time;
//           if (int.parse(b[2] + b[3]) + 50 > 60) {
//             g_time = TimeOfDay(
//                 hour: int.parse(b[0]) + 3,
//                 minute: int.parse(b[2] + b[3]) + 50 - 60);
//           } else
//             (g_time = TimeOfDay(
//                 hour: int.parse(b[0]) + 2,
//                 minute: int.parse(b[2] + b[3]) + 50));
//           var c = l[3];
//           var c_time;
//           if (int.parse(c[3] + c[4]) - 10 > 60) {
//             c_time = TimeOfDay(
//                 hour: int.parse(c[0] + c[1]) + 1,
//                 minute: int.parse(c[3] + c[4]) - 10 - 60);
//           } else
//             (c_time = TimeOfDay(
//                 hour: int.parse(c[0] + c[1]),
//                 minute: int.parse(c[3] + c[4]) - 10));
//           var d = l[4];
//           var e = l[5];
//           var e_time;
//           if (int.parse(e[2] + e[3]) + 2 > 60) {
//             e_time = TimeOfDay(
//                 hour: int.parse(e[0]) + 1,
//                 minute: int.parse(e[2] + e[3]) + 2 - 60);
//           } else
//             (e_time = TimeOfDay(
//                 hour: int.parse(e[0]), minute: int.parse(e[2] + e[3]) + 2));
//           var f = l[6];
//           start_time.add(a);
//           print(a);
//           start_time.add(c);
//           start_time.add(d);
//           start_time
//               .add(e_time.hour.toString() + ":" + e_time.minute.toString());
//           start_time.add(f);
//           start_time
//               .add(a_time.hour.toString() + ":" + a_time.minute.toString());
//           start_time
//               .add(e_time.hour.toString() + ":" + e_time.minute.toString());
//           start_time.add(b);
//           start_time
//               .add(c_time.hour.toString() + ":" + c_time.minute.toString());
//           start_time.add(e);
//           start_time
//               .add(b_time.hour.toString() + ":" + b_time.minute.toString());
//           start_time
//               .add(g_time.hour.toString() + ":" + g_time.minute.toString());
//           end_time.add(b);
//           end_time.add(d);
//           end_time.add(e);
//           end_time.add(f);
//           end_time.add(a);
//           end_time.add(a);
//           end_time.add(e_time.hour.toString() + ":" + e_time.minute.toString());
//           end_time.add(b_time.hour.toString() + ":" + b_time.minute.toString());
//           end_time.add(c);
//           end_time.add(e_time.hour.toString() + ":" + e_time.minute.toString());
//           end_time.add(g_time.hour.toString() + ":" + g_time.minute.toString());
//           end_time.add(c_time.hour.toString() + ":" + c_time.minute.toString());
//         });
//       }
//     }
//   }
// }

// //courses Screen
// class RamadanScreen extends StatefulWidget {
//   @override
//   RamadanScreenState createState() => RamadanScreenState();
// }

// class RamadanScreenState extends State<RamadanScreen> {
//   List date_list = [];
//   List ramadan_list = [];
//   List sahri_time = [];
//   List iftar_time = [];
//   final List<int> colorCodes = <int>[
//     100,
//     200,
//     300,
//     400,
//     500,
//     600,
//     700,
//     800,
//     800,
//     700,
//     600,
//     500,
//     400,
//     300,
//     200,
//     100,
//     200,
//     300,
//     400,
//     500,
//     600,
//     700,
//     800,
//     800,
//     700,
//     600,
//     500,
//     400,
//     300,
//     200,
//     100,
//     200,
//     300,
//     400,
//     500,
//     600,
//     700,
//     800,
//     900,
//     800,
//     700,
//     600,
//     500,
//     400,
//     300,
//     200,
//     100
//   ];
//   @override
//   Widget build(BuildContext context) {
//     csvfile();
//     if (date_list.length == 0) {
//       return Center(child: CircularProgressIndicator());
//     } else {
//       return Container(
//         color: Colors.white,
//         child: ListView.builder(
//             padding: const EdgeInsets.all(8),
//             itemCount: date_list.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Container(
//                 margin: EdgeInsets.all(10.0),
//                 height: 50,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.lightBlue,
//                       blurRadius: 5.0,
//                     )
//                   ],
//                   color: Colors.lightGreen[colorCodes[index]],
//                 ),
//                 child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text('${date_list[index]}'),
//                       Text('${ramadan_list[index]}'),
//                       Text('${sahri_time[index]}'),
//                       Text('${iftar_time[index]}')
//                     ]),
//               );
//             }),
//       );
//     }
//   }

//   void csvfile() async {
//     final myData = await rootBundle.loadString('csv/Jalgaon Prayer Times.csv');
//     List<List<dynamic>> mylist = const CsvToListConverter().convert(myData);
//     date_list.clear();
//     sahri_time.clear();
//     iftar_time.clear();
//     ramadan_list.clear();
//     date_list.add('Date');
//     sahri_time.add('Sahri');
//     iftar_time.add('Iftar');
//     ramadan_list.add('Ramadan');
//     int r = 1;
//     for (var i = 104; i < 134; i++) {
//       List l = mylist[i];
//       var d = l[0];
//       var dsplit = d.split(' ');
//       var date = dsplit[1] + ' ' + dsplit[2];
//       date_list.add(date);
//       var a = l[1];
//       var a_time =
//           TimeOfDay(hour: int.parse(a[0]), minute: int.parse(a[2] + a[3]) - 5);
//       sahri_time.add(a_time.hour.toString() + ":" + a_time.minute.toString());
//       var e = l[5];
//       var e_time =
//           TimeOfDay(hour: int.parse(e[0]), minute: int.parse(e[2] + e[3]) + 2);
//       iftar_time.add(e_time.hour.toString() + ":" + e_time.minute.toString());
//       ramadan_list.add(r);
//       r++;
//     }
//   }
// }
