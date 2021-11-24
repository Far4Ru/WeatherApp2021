import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:storyswiper/storyswiper.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'models/locations.dart';
import 'pages/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LocationsHiveAdapter());
  Hive.registerAdapter(WeatherDayHiveAdapter());
  Hive.registerAdapter(DayAdditionalDetailHiveAdapter());
  await Hive.openBox<LocationsHive>('box_for_locations');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Weather App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}
