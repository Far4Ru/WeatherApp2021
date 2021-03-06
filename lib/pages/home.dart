import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/data/values.dart';
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
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String title = "Город";
  String temperatureUnit = "C";
  HomeData homeData = HomeData();

  late DateFormat dateFormatLarge;
  late DateFormat dateFormatShort;

  double width = 0;
  double height = 0;

  double _bottomPanelHeight = 0;
  double _bottomPanelMinHeight = 0;
  double _bottomPanelMaxHeight = 0;

  late NeumorphicThemeData theme;
  late Color baseColor;
  late Color accentColor;

  late Map<String, Color> colors;

  void _changeBottomPanelState() {
    setState(() {
      _bottomPanelHeight = _bottomPanelHeight < _bottomPanelMaxHeight ? _bottomPanelMaxHeight : _bottomPanelMinHeight;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {

    theme = NeumorphicTheme.currentTheme(context);
    colors = NeumorphicTheme.of(context)!.isUsingDark ? colorsDark : colorsLight;
    baseColor = theme.baseColor;
    accentColor = theme.accentColor;

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    _bottomPanelMinHeight = height * 256 / 640;
    _bottomPanelMaxHeight = height * 450 / 640;
    _bottomPanelHeight = _bottomPanelHeight == 0 ? _bottomPanelMaxHeight : _bottomPanelHeight;
    dateFormatLarge = DateFormat("d LLL y", 'ru_Ru');
    dateFormatShort = DateFormat("d LLLL", 'ru_Ru');

    return FutureBuilder(
        future: homeData.updateAll(), // the function to get your data from firebase or firestore
        builder : (BuildContext context, AsyncSnapshot snap){
          if(snap.data == null){
            return Scaffold(
              body: Center(
                child: Column(
                    children: const [
                      Text(
                        'Weather',
                        style: TextStyle(fontSize:24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                    ]
                ),
              ),
            );
          }
          else{
            return Scaffold(
                key: _scaffoldKey,
                drawer: Drawer(
                  child: Container(
                    color: colors["background"],
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        Padding(padding: const EdgeInsets.only(top: 30, left: 20, bottom: 20),
                          child: Text(
                            'Weather App',
                            style: TextStyle(
                              color: colors["textBase"],
                              fontWeight: FontWeight.normal,
                              fontSize: 24,
                              fontFamily: 'Manrope',
                            ),
                          ),
                        ),
                        ListTile(
                            leading: Icon(Icons.settings, color: colors["textBase"],),
                            title: Text('Настройки', style: TextStyle(color: colors["textBase"]),),
                            onTap: () => _toSettingsPage(context)
                        ),
                        ListTile(
                          leading: Icon(Icons.favorite_border, color: colors["textBase"],),
                          title: Text('Избранные', style: TextStyle(color: colors["textBase"])),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> const FavouritePage(),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.account_circle, color: colors["textBase"],),
                          title: Text('О приложении', style: TextStyle(color: colors["textBase"])),
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
                    if (!NeumorphicTheme.of(context)!.isUsingDark) Container(
                      height: height,
                      width: width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/image0.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    if (NeumorphicTheme.of(context)!.isUsingDark) Container(
                      height: height,
                      width: width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/image1.png'),
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
                          LocationsHive location = box.values.firstWhere((element) => element.locationName == homeData.appSettings.location);
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
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Manrope',
                                            color: colors["mainText"]
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
                                        style: TextStyle(
                                            fontSize: 80.0,
                                            fontFamily: 'Manrope',
                                            color: colors["mainText"]
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
                                        dateFormatLarge.format(now),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontFamily: 'Manrope',
                                            color: colors["mainText"]
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
                        child: Icon(
                          Icons.dehaze,
                          color: colors["mainText"],
                        ),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: const NeumorphicBoxShape.circle(),
                          depth: 1,
                          color: colors["button"],
                          lightSource: LightSource.top,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:42, left: 340),
                      child: NeumorphicButton(
                        onPressed: () => _toSearchPage(context),
                        child: Icon(
                          Icons.add_circle_outline,
                          color: colors["mainText"],
                        ),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: const NeumorphicBoxShape.circle(),
                          depth: 1,
                          color: colors["button"],
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
                          LocationsHive location = box.values.firstWhere((element) => element.locationName == homeData.appSettings.location);
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
                              width: width,
                              height: _bottomPanelHeight,
                              child: Container (
                                  decoration: BoxDecoration(
                                    color: colors["background"],
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(20.0),
                                        bottomRight: Radius.circular(0.0),
                                        topLeft: Radius.circular(20.0),
                                        bottomLeft: Radius.circular(0.0)),
                                  ),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onVerticalDragStart: (details){
                                            _changeBottomPanelState();
                                          },
                                          child: Container(
                                            height: 30,
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            color: colors["background"],
                                            child: SizedBox(
                                              height: 30,
                                              width: MediaQuery.of(context).size.width,
                                              child: Column(
                                                  children: [
                                                    Container(
                                                        width: 80,
                                                        height: 3.3,
                                                        margin: const EdgeInsets.only(top: 10),
                                                        decoration: BoxDecoration(
                                                          color: colors["line"],
                                                        )
                                                    ),
                                                  ]
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (_bottomPanelHeight == _bottomPanelMaxHeight) Text(
                                          dateFormatShort.format(DateTime.now()),
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              fontFamily: 'Manrope',
                                              color: colors["textBase"]
                                          ),
                                        ),
                                        SizedBox(
                                            height: height * 122 / templateHeight,
                                            width: width,
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: dayList.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return _buildVerticalCard(context, dayList[index]);
                                                }
                                            )
                                        ),
                                        if (_bottomPanelHeight == _bottomPanelMaxHeight) SizedBox (
                                          width: MediaQuery.of(context).size.width,
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment
                                            //     .spaceBetween,
                                            children: [
                                              Row (
                                                // mainAxisAlignment: MainAxisAlignment
                                                //     .spaceBetween,
                                                children: [
                                                  _buildHorizontalCard(context, dayDetails.firstWhere((element) => element.type == "thermometer")),
                                                  _buildHorizontalCard(context, dayDetails.firstWhere((element) => element.type == "humidity"))
                                                ],
                                              ),
                                              Row (
                                                // mainAxisAlignment: MainAxisAlignment
                                                //     .spaceBetween,
                                                children: [
                                                  _buildHorizontalCard(context, dayDetails.firstWhere((element) => element.type == "breeze")),
                                                  _buildHorizontalCard(context, dayDetails.firstWhere((element) => element.type == "barometer"))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () async => _toWeekPage(context, await homeData.appSettings.getLocation()),
                                          child: Text('Прогноз на неделю', style: TextStyle(color: colors["toWeekButtonText"])),
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(width: 1.5, color: (colors["toWeekButtonBorder"])!),
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
        }
    );

  }
  void _toSearchPage(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SearchPage(selected: title)
        )
    );
    setState(
        () {
          homeData.setLocationName(result[0]);
        }
    );
  }

  void _toSettingsPage(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SettingsPage(parameters: homeData.settingsParameters, appSettings: homeData.appSettings)
        )
    );
    setState(
            () {
          homeData.settingsParameters = result;
        }
    );
  }
  void _toWeekPage(BuildContext context, String locationName) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeekPage(locationName: locationName)));
  }

  Widget _buildVerticalCard(BuildContext context, WeatherDayHive details) {
    DayAdditionalDetailHive temperature = DayAdditionalDetailHive("thermometer", "10", "\u00B0C", "assets/icon_sun.png");
    if(details.details.isNotEmpty) {
      temperature = details.details.firstWhere(
        (element) => element.type == "thermometer"
      );
    }
    return Container(
        width: width * 65 / templateWidth,
        decoration: BoxDecoration(
          color: colors["background"],
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0)
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        // margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
        child: Column (
          children: [
            Text(
              DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(details.datetime)),
              style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'Manrope',
                  color: colors["textBase"]
              ),
            ),
            Tab(
              icon: Image.asset(
                details.icon,
                width: width * 40 / templateWidth,
                height: height * 40 / templateHeight
              )
            ),
            Text(
              homeData.getValue("thermometer",double.parse(temperature.value).round().toString(),temperature.unit) + " " + homeData.getUnit("thermometer", temperature.unit),
              style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'Manrope',
                  color: colors["textBase"]
              ),
            ),
          ],
        )
    );
  }
  Widget _buildHorizontalCard(BuildContext context, DayAdditionalDetailHive details) {
    return Container(
        height: height * 65 / templateHeight,
        width: width * 150 / templateWidth,
        decoration: BoxDecoration(
          color: colors["background"],
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0)
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        // margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
        child: Row (
          children: [
            Tab(
              icon: Image.asset(
                details.icon,
                width: width * 24 / templateWidth,
                height: height * 24 / templateHeight
              )
            ),
            Text(
              homeData.getValue(details.type,details.value,details.unit) + " ",
              style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Manrope',
                  color: colors["textBase"]
              ),
            ),
            Text(
              homeData.getUnit(details.type, details.unit),
              style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Manrope',
                  color: colors["textBase"]
              ),
            ),
          ],
        )
    );
  }
}

