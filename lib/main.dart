import 'package:flutter/material.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
// import 'package:storyswiper/storyswiper.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String theme = prefs.getString("theme") ?? "";
  runApp(MyApp(theme: theme));
}

class MyApp extends StatefulWidget {
  String theme = "";
  MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      title: 'My Weather App',
      themeMode: widget.theme == "dark" ? ThemeMode.dark : ThemeMode.light,
      theme: const NeumorphicThemeData(
        baseColor: Color(0xFFDEE9FF),
        accentColor: Colors.black,
        // lightSource: LightSource.topLeft,
        // depth: 10,
      ),
      darkTheme: const NeumorphicThemeData(
        baseColor: Color(0xFF0D172B),
        accentColor: Colors.white,
        // lightSource: LightSource.topLeft,
        // depth: 6,
      ),
      home: const MyHomePage(),
    );
  }
}
