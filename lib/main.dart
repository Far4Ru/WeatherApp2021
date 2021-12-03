import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:storyswiper/storyswiper.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'models/locations.dart';
import 'pages/home.dart';
import 'package:intl/intl.dart';

void main() async {
  // Intl.defaultLocale = 'ru_RU';
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
    return const NeumorphicApp(
      title: 'My Weather App',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFDEE9FF),
        accentColor: Colors.black,
        // lightSource: LightSource.topLeft,
        // depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF0D172B),
        accentColor: Colors.white,
        // lightSource: LightSource.topLeft,
        // depth: 6,
      ),
      home: MyHomePage(title: ''),
    );
  }
}
