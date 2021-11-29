import 'dart:convert';

import 'package:hive/hive.dart';
import '../data/values.dart';
import 'package:http/http.dart' as http;

part 'locations.g.dart';


@HiveType(typeId: 0)
class LocationsHive extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String locationName;

  @HiveField(2)
  bool favourite;

  @HiveField(3)
  List<WeatherDayHive> weatherDays;

  final Map<String, String> _icons = {
    "thunderstorm" : "assets/icon_lightning.png",
    "light rain" : "assets/icon_rain.png",
    "shower rain" : "assets/icon_rain_heavy.png",
    "clear sky" : "assets/icon_sun.png"
  };

  LocationsHive(this.name, this.locationName, this.favourite, this.weatherDays);

  update() async {
    checkWeatherToday();
    if (locationName.isNotEmpty && !checkWeatherToday()) {
      final response = await http.get(Uri.parse(url + locationName + urlParams));
      if (response.statusCode == 200) {
        _fillWeatherDays(json.decode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    }
  }

  checkWeatherToday() {
    _loadWeatherDays();
    DateTime now = DateTime.now();
    int beforeNow = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    int afterNow = DateTime(now.year, now.month, now.day+1).millisecondsSinceEpoch;
    var today = weatherDays.where((weatherDay) => weatherDay.datetime > beforeNow && weatherDay.datetime < afterNow);
    if (today.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  _loadWeatherDays() async {
    Box<WeatherDayHive> weatherDayBox = Hive.box<WeatherDayHive>('box_for_weather_day');
    weatherDays = weatherDayBox.values.toList();
  }

  _fillWeatherDays(Map body) async {
    // If the server did return a 200 OK response,
    Box<WeatherDayHive> weatherDayBox = Hive.box<WeatherDayHive>('box_for_weather_day');
    body["list"].forEach((day) =>
    {
      if (
      weatherDays
          .where(
              (element) =>
          element.datetime == day["dt"]
      )
          .toList()
          .isEmpty
      ) weatherDayBox.add(
          WeatherDayHive(
              day["dt"] * 1000,
              [
                DayAdditionalDetailHive(
                    "thermometer", day["main"]["temp"].toString(),
                    "\u00B0C", "assets/thermometer.png"),
                DayAdditionalDetailHive(
                    "barometer", day["main"]["pressure"].toString(),
                    "мм.рт.ст.", "assets/barometer.png"),
                DayAdditionalDetailHive(
                    "breeze", day["wind"]["speed"].toString(), "м/с",
                    "assets/breeze.png"),
                DayAdditionalDetailHive(
                    "humidity", day["main"]["humidity"].toString(), "%",
                    "assets/humidity.png")
              ],
              _icons.keys.firstWhere((element) =>
              element == day["weather"][0]["description"],
                  orElse: () => "assets/icon_sun.png")
          )
      ),
    });
    weatherDays = weatherDayBox.values.toList();
  }
}

@HiveType(typeId: 1)
class WeatherDayHive extends HiveObject {

  @HiveField(0)
  int datetime;

  @HiveField(1)
  List<DayAdditionalDetailHive> details;

  @HiveField(2)
  String icon;

  WeatherDayHive(this.datetime, this.details, this.icon);
}

@HiveType(typeId: 2)
class DayAdditionalDetailHive extends HiveObject {

  @HiveField(0)
  String type;

  @HiveField(1)
  String value;

  @HiveField(2)
  String unit;

  @HiveField(3)
  String icon;

  DayAdditionalDetailHive (this.type, this.value, this.unit, this.icon);
}