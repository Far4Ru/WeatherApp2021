import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:storyswiper/storyswiper.dart';
import 'package:weather_app/models/locations.dart';
import 'home.dart';

class WeekPage extends StatelessWidget {

  const WeekPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    final baseColor = theme.baseColor;
    final accentColor = theme.accentColor;
    return Scaffold(
      body: Stack(
          children: <Widget>[
            Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: baseColor,
      ),
            // TODO: - Use story swiper and Hive
            Container(
              margin: const EdgeInsets.only(top: 25),
              width: MediaQuery.of(context).size.width,
              child: Column(
        children: [
          Row(
              children: [
                IconButton(
                  onPressed: () => _navigateToPreviousPage(context),
                  icon: Icon(
                    Icons.arrow_back_ios, color: accentColor,
                  ),
                ),
                SizedBox(
                    child: Text(
                      'Прогноз на неделю',
                      style: TextStyle(
                          fontSize: 28.0,
                          fontFamily: 'Roboto',
                          color: accentColor
                      ),
                    )
                )
              ],
          ),
          ValueListenableBuilder(
            valueListenable: Hive.box<LocationsHive>('box_for_locations').listenable(),
            builder: (context, Box<LocationsHive> box, _) {
              if (box.values.isEmpty) {
                return const Center(
                  child: Text("No data"),
                );
              }

              const List<Color> colors = [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
              ];

              // homeData.appSettings.location
              // LocationsHive location = box.values.firstWhere((element) => element.locationName == "Moscow");
              // List<WeatherDayHive> day = location.weatherDays;
              // DateTime now = DateTime.now();
              // WeatherDayHive dayNow = WeatherDayHive(0, [], "");
              // int beforeNow = DateTime(now.year, now.month, now.day, now.hour - 3).millisecondsSinceEpoch;
              // int afterNow = DateTime(now.year, now.month, now.day, now.hour + 3).millisecondsSinceEpoch;
              // if (day.isNotEmpty) {
              //   dayNow = day.firstWhere(
              //           (element) =>
              //       element.datetime > beforeNow &&
              //           element.datetime < afterNow
              //       , orElse: () => WeatherDayHive(0, [], "")
              //   );
              //   if (dayNow.details.isEmpty) {
              //     return const Center(
              //       child: Text("No data"),
              //     );
              //   }
              //   thermometer = double.parse(dayNow.details.firstWhere((element) => element.type=="thermometer").value).round().toString();
              // }
              return SizedBox(
                height: 410,
                child: StorySwiper.builder(
                  itemCount: colors.length,
                  aspectRatio: 5 / 6,
                  depthFactor: 0.2,
                  dx: 10,
                  dy: 10,
                  paddingStart: 25,
                  verticalPadding: 0,
                  visiblePageCount: 3,
                  widgetBuilder: (index) {
                    return _buildCard(context);
                  },
                ),
              );
            }
          ),
          Container(
              margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
              child: OutlinedButton(
                onPressed: () => _navigateToPreviousPage(context),
                child: Text('Вернуться на главную', style: TextStyle(color: accentColor)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(width: 1.5, color: accentColor),
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
    Navigator.of(context).pop(MaterialPageRoute(builder: (context) => const MyHomePage(title: "Погода")));
  }
  
  Widget _buildCard(BuildContext context) {
    return Container(
      //color: Colors.lightBlueAccent,
        margin: const EdgeInsets.only(top:20, left: 20, bottom: 20, right: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.4,
              0.6,
              0.9,
            ],
            colors: [
              Colors.yellow,
              Colors.red,
              Colors.indigo,
              Colors.teal,
            ],
          ),
          borderRadius: BorderRadius.only(
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
                      child: const Text("23 сентября",
                        style: TextStyle(
                            fontSize: 28.0,
                            fontFamily: 'Roboto',
                            color: Colors.black
                        ),
                      ),
                    ),
                  ]
              ),
              Row(
                  children: [
                    Tab(icon: Image.asset("assets/partly_cloudy.png", width: 100, height:100)),
                  ]
              ),
              Row(
                  children: [
                    Tab(icon: Image.asset("assets/thermometer.png", width: 100, height:100)),
                    const Text("8\u00B0C"),
                  ]
              ),
              Row(
                  children: [
                    Tab(icon: Image.asset("assets/breeze.png", width: 100, height:100)),
                    const Text("9м/с"),
                  ]
              ),
              Row(
                  children: [
                    Tab(icon: Image.asset("assets/humidity.png", width: 100, height:100)),
                    const Text("87%"),
                  ]
              ),
              Row(
                  children: [
                    Tab(icon: Image.asset("assets/barometer.png", width: 100, height:100)),
                    const Text("761мм.рт.ст"),
                  ]
              ),
            ]
        )
    );
  }
}

