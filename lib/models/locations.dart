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
    if (locationName.isNotEmpty) {
      final response = await http.get(Uri.parse(url + locationName + urlParams));
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        var weatherBox = await Hive.openBox<WeatherDayHive>(
            'box_for_weather_day');
        Map body = json.decode(response.body);
        body["list"].forEach((day) =>
        {
          if (weatherDays
              .where((element) =>
          element.datetime == day["dt"])
              .toList()
              .isEmpty) weatherBox.add(
              WeatherDayHive(
                  day["dt"],
                  [
                    DayAdditionalDetailHive(
                        "thermometer", day["main"]["temp"].toString(),
                        "\u00B0C", "assets/thermometer.png"),
                    DayAdditionalDetailHive(
                        "barometer", day["main"]["pressure"].toString(),
                        "мм.рт.ст.", "assets/barometer.png"),
                    DayAdditionalDetailHive(
                        "breeze", day["wind"].toString(), "м/с",
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
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }
    }
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