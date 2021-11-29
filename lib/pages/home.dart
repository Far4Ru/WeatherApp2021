import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:weather_app/models/locations.dart';
// import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'about.dart';
import 'favourite.dart';
import 'search.dart';
import 'settings.dart';
import 'week.dart';
import '../data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _bottomPanelHeight = 300;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String title = "Город";
  String temperatureUnit = "C";
  HomeData homeData = HomeData();

  void _changeBottomPanelState() {
    setState(() {
      _bottomPanelHeight = _bottomPanelHeight == 300 ? 550 : 300;
    });
  } // Bottom Panel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.lightBlue,
        drawer: Drawer(
          child: Container(
            color: const Color(0xFFE2EBFF),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 30, left: 20, bottom: 20),
                  child: Text(
                    'Weather App',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Настройки'),
                  onTap: () => _toSettingsPage(context)
                ),
                ListTile(
                  leading: const Icon(Icons.favorite_border),
                  title: const Text('Избранные'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> FavouritePage(items: homeData.locations.where((i) => i.isFavorite).toList()),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('О приложении'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> const AboutPage(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ), // Left Panel
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/image0.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: Hive.box<LocationsHive>('box_for_locations').listenable(),
              builder: (context, Box<LocationsHive> box, _) {
                if (box.values.isEmpty) {
                  return const Center(
                    child: Text("No data"),
                  );
                }
                LocationsHive location = box.values.firstWhere((element) => element.locationName == homeData.locationName);
                List<WeatherDayHive> day = location.weatherDays;
                DateTime now = DateTime.now();
                WeatherDayHive dayNow = WeatherDayHive(0, [], "");
                String thermometer = "";
                int beforeNow = DateTime(now.year, now.month, now.day, now.hour - 3).millisecondsSinceEpoch;
                int afterNow = DateTime(now.year, now.month, now.day, now.hour + 3).millisecondsSinceEpoch;
                if (day.isNotEmpty) {
                  dayNow = day.firstWhere(
                      (element) =>
                      element.datetime > beforeNow &&
                      element.datetime < afterNow
                      , orElse: () => WeatherDayHive(0, [], "")
                  );
                  if (dayNow.details.isEmpty) {
                    return const Center(
                      child: Text("No data"),
                    );
                  }
                  thermometer = double.parse(dayNow.details.firstWhere((element) => element.type=="thermometer").value).round().toString();
                }
                return Container(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                location.name,
                                style: const TextStyle(
                                    fontSize: 32.0,
                                    fontFamily: 'Manrope',
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                homeData.getValue("thermometer",thermometer,"\u00B0C") + homeData.getUnit("thermometer", "\u00B0C"),
                                style: const TextStyle(
                                    fontSize: 72.0,
                                    fontFamily: 'Manrope',
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                DateFormat("d LLL y").format(now),
                                style: const TextStyle(
                                    fontSize: 22.0,
                                    fontFamily: 'Manrope',
                                    color: Colors.white
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
              }
            ),
            Container(
              margin: const EdgeInsets.only(top: 42, left: 20),
              child: NeumorphicButton(
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                child: const Icon(
                  Icons.dehaze,
                  color: Colors.white,
                ),
                style: const NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 1,
                  color: Color(0xFF0256FF),
                  lightSource: LightSource.top,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top:42, left: 340),
              child: NeumorphicButton(
                onPressed: () => _toSearchPage(context),
                child: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                ),
                style: const NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 1,
                  color: Color(0xFF0256FF),
                  lightSource: LightSource.top,
                ),
              ),
            ),
    ValueListenableBuilder(
      valueListenable: Hive.box<LocationsHive>('box_for_locations').listenable(),
      builder: (context, Box<LocationsHive> box, _) {
        if (box.values.isEmpty) {
          return const Center(
          child: Text("No data"),
        );
      }
      LocationsHive location = box.values.firstWhere((element) => element.locationName == homeData.locationName);
      List<WeatherDayHive> day = location.weatherDays;
      DateTime now = DateTime.now();
      WeatherDayHive dayNow = WeatherDayHive(0, [], "");
      List<WeatherDayHive> dayList = [];
      List<DayAdditionalDetailHive> dayDetails = [];
      String thermometer = "";
      int beforeNow = DateTime(now.year, now.month, now.day, now.hour - 3).millisecondsSinceEpoch;
      int afterNow = DateTime(now.year, now.month, now.day + 1, 1).millisecondsSinceEpoch;
      if (day.isNotEmpty) {
        dayNow = day.firstWhere(
          (element) =>
          element.datetime > beforeNow &&
          element.datetime < afterNow,
          orElse: () => WeatherDayHive(0, [], "")
        );

        if (dayNow.details.isEmpty) {
          return const Center(
            child: Text("No data"),
          );
        }
        dayList = day.where(
          (element) =>
          element.datetime > beforeNow &&
          element.datetime < afterNow
        ).toList();
        dayDetails = dayNow.details;
      }
      return Positioned(
          bottom: 00,
          width: MediaQuery.of(context).size.width,
          height: _bottomPanelHeight,
          child: Container (
              decoration: const BoxDecoration(
                color: Color(0xFFE2EBFF),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(0.0),
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(0.0)),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    GestureDetector(
                      onVerticalDragStart: (details){
                        _changeBottomPanelState();
                      },
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width * 0.8,
                        color: const Color(0xFFE2EBFF),
                        child: SizedBox(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                              children: [
                                Container(
                                    width: 80,
                                    height: 3.3,
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                    )
                                ),
                              ]
                          ),
                        ),
                      ),
                    ),
                    if (_bottomPanelHeight > 400) Text(
                      DateFormat("d LLLL").format(DateTime.now()),
                      style: const TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Manrope',
                          color: Colors.black
                      ),
                    ),
                    SizedBox(
                      height: 180.0,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dayList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _buildVerticalCard(context, dayList[index]);
                        }
                      )
                    ),
                    if (_bottomPanelHeight > 400) SizedBox (
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row (
                            children: [
                              _buildHorizontalCard(context, dayDetails.firstWhere((element) => element.type == "thermometer")),
                              _buildHorizontalCard(context, dayDetails.firstWhere((element) => element.type == "humidity"))
                            ],
                          ),
                          Row (
                            children: [
                              _buildHorizontalCard(context, dayDetails.firstWhere((element) => element.type == "breeze")),
                              _buildHorizontalCard(context, dayDetails.firstWhere((element) => element.type == "barometer"))
                            ],
                          ),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => _toWeekPage(context),
                      child: const Text('Прогноз на неделю', style: TextStyle(color: Color(0xFF038CFE))),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 1.5, color: Color(0xFF038CFE)),
                      ),
                    ),
                  ],
                ),
              )
          )
      );
      }
    ),
          ],
      )
    );
  }
  void _toSearchPage(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchPage(items: homeData.locations, selected: title)
        )
    );
    setState(
            () {
          title = result[0];
          homeData.locations = result[1];
        }
    );
  }

  void _toSettingsPage(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SettingsPage(parameters: homeData.settingsParameters)
        )
    );
    setState(
            () {
          homeData.settingsParameters = result;
        }
    );
  }
  void _toWeekPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WeekPage()));
  }

  Widget _buildVerticalCard(BuildContext context, WeatherDayHive details) {
    DayAdditionalDetailHive temperature = DayAdditionalDetailHive("thermometer", "10", "\u00B0C", "assets/icon_sun.png");
    if(details.details.isNotEmpty) {
      temperature = details.details.firstWhere(
        (element) => element.type == "thermometer"
      );
    }
    return Container(
        height: 120,
        width: 70,
        decoration: const BoxDecoration(
          color: Color(0xFFE0E9FD),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
        child: Column (
          children: [
            Text(
              DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(details.datetime)),
              style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                  color: Colors.black
              ),
            ),
            Tab(icon: Image.asset(details.icon, width: 40, height: 40,)),
            Text(
              homeData.getValue("thermometer",double.parse(temperature.value).round().toString(),temperature.unit) + " " + homeData.getUnit("thermometer", temperature.unit),
              style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                  color: Colors.black
              ),
            ),
          ],
        )
    );
  }
  Widget _buildHorizontalCard(BuildContext context, DayAdditionalDetailHive details) {
    return Container(
        height: 70,
        width: 150,
        decoration: const BoxDecoration(
          color: Color(0xFFE2EBFF),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
        child: Row (
          children: [
            Tab(icon: Image.asset(details.icon, width: 40, height: 40,)),
            Text(
              homeData.getValue(details.type,details.value,details.unit) + " ",
              style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                  color: Colors.black
              ),
            ),
            Text(
              homeData.getUnit(details.type, details.unit),
              style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                  color: Colors.black
              ),
            ),
          ],
        )
    );
  }
}

