import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:storyswiper/storyswiper.dart';
import 'package:weather_app/data/values.dart';
import 'package:weather_app/models/locations.dart';
import 'home.dart';

class WeekPage extends StatefulWidget {
  final String locationName;
  const WeekPage({Key? key, required this.locationName}) : super(key: key);

  @override
  State<WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
  late Map<String, Color> colors;
  late NeumorphicThemeData theme;
  late Color baseColor;
  late Color accentColor;
  late DateFormat dateFormatShort;
  double width = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    theme = NeumorphicTheme.currentTheme(context);
    baseColor = theme.baseColor;
    accentColor = theme.accentColor;
    colors = NeumorphicTheme.of(context)!.isUsingDark ? colorsDark : colorsLight;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    dateFormatShort = DateFormat("d LLLL", 'ru_RU');

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: height,
            width: width,
            color: colors["background"],
          ),
          Container(
            margin: const EdgeInsets.only(top: 25),
            width: width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        child: Text(
                          'Прогноз на неделю',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontFamily: 'Manrope',
                              color: colors["textBase"]
                          ),
                        )
                    )
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: Hive.box<LocationsHive>('box_for_locations').listenable(),
                  builder: (context, Box<LocationsHive> box, _) {
                    if (box.values.isEmpty && widget.locationName.isNotEmpty) {
                      return const Center(
                        child: Text("No data"),
                      );
                    }
                    LocationsHive location = box.values.firstWhere((element) => element.locationName == widget.locationName);
                    List<WeatherDayHive> day = location.weatherDays;
                    DateTime now = DateTime.now();
                    List<WeatherDayHive> weekArray = [];
                    List<WeatherDayHive> displayWeekArray = [];
                    int beforeNow = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
                    int afterNow = DateTime(now.year, now.month, now.day+8).millisecondsSinceEpoch;
                    if (day.isNotEmpty) {
                      weekArray = day.where(
                          (element) =>
                          element.datetime > beforeNow &&
                          element.datetime < afterNow
                      ).toList();
                      for (var element in weekArray) {
                        if (DateTime.fromMillisecondsSinceEpoch(element.datetime).hour == 15) {
                          displayWeekArray.add(element);
                        }
                      }
                    }
                    return SizedBox(
                      height: height * 387 / templateHeight,
                      child: StorySwiper.builder(
                        itemCount: displayWeekArray.length,
                        aspectRatio: 320 / 387,
                        depthFactor: 0.2,
                        dx: 10,
                        dy: 10,
                        paddingStart: 25,
                        verticalPadding: 0,
                        visiblePageCount: 3,
                        widgetBuilder: (index) {
                          return _buildCard(context, displayWeekArray[index]);
                        },
                      ),
                    );
                  }
                ),
                Container(
            margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
            child: OutlinedButton(
              onPressed: () => _navigateToPreviousPage(context),
              child: Text('Вернуться на главную', style: TextStyle(color: colors["textBase"])),
              style: OutlinedButton.styleFrom(
                side: BorderSide(width: 1.5, color: (colors["textBase"])!),
              ),
            ),
        ),
              ],
            ),
          ),
        ]
      )
    );
  }

  void _navigateToPreviousPage(BuildContext context) {
    Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const MyHomePage()));
  }

  Widget _buildCard(BuildContext context, WeatherDayHive weatherDay) {
    DayAdditionalDetailHive thermometer = weatherDay.details.firstWhere((element) => element.type == "thermometer");
    DayAdditionalDetailHive humidity = weatherDay.details.firstWhere((element) => element.type == "humidity");
    DayAdditionalDetailHive breeze = weatherDay.details.firstWhere((element) => element.type == "breeze");
    DayAdditionalDetailHive barometer = weatherDay.details.firstWhere((element) => element.type == "barometer");
    return Container(
      //color: Colors.lightBlueAccent,
        margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [
              0.1,
              0.9,
            ],
            colors: [
              (colors["card1"])!,
              (colors["card2"])!
            ],
          ),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              bottomLeft: Radius.circular(20.0)
          ),
        ),
        child: Column(
            children: [
              Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25.0, left: 30.0, bottom: 15.0),
                      child: Text(dateFormatShort.format(DateTime.fromMillisecondsSinceEpoch(weatherDay.datetime)),
                        style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'Manrope',
                            color: colors["textBase"]
                        ),
                      ),
                    ),
                  ]
              ),
              Row(
                  children: [
                    Tab(icon: Image.asset(getIcon(weatherDay.icon), width: 100, height:100)),
                  ]
              ),
              Row(
                  children: [
                    Tab(icon: Image.asset(thermometer.icon, width:52, height:24,color: colors["text16"])),
                    Text(thermometer.value, style: TextStyle(color: colors["textBase"])),
                    Text(thermometer.unit, style: TextStyle(color: colors["text16"])),
                  ]
              ),
              Row(
                  children: [
                    Tab(icon: Image.asset(breeze.icon, width:52, height:24,color: colors["text16"])),
                    Text(breeze.value, style: TextStyle(color: colors["textBase"])),
                    Text(breeze.unit, style: TextStyle(color: colors["text16"])),
                  ]
              ),
              Row(
                  children: [
                    Tab(icon: Image.asset(humidity.icon, width:52, height:24,color: colors["text16"])),
                    Text(humidity.value, style: TextStyle(color: colors["textBase"])),
                    Text(humidity.unit, style: TextStyle(color: colors["text16"])),
                  ]
              ),
              Row(
                  children: [
                    Tab(icon: Image.asset(barometer.icon, width:52, height:24,color: colors["text16"])),
                    Text(barometer.value, style: TextStyle(color: colors["textBase"])),
                    Text(barometer.unit, style: TextStyle(color: colors["text16"])),
                  ]
              ),
            ]
        )
    );
  }
}

