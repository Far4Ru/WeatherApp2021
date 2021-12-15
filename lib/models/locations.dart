import 'dart:convert';

import 'package:hive/hive.dart';
import '../data/values.dart';
import 'package:http/http.dart' as http;

part 'locations.g.dart';


@HiveType(typeId: 0)
class LocationsHive extends HiveObject {

  @HiveField(0)
  String name; // View

  @HiveField(1)
  String locationName; // Server

  @HiveField(2)
  bool favourite;

  @HiveField(3)
  List<WeatherDayHive> weatherDays;

  LocationsHive(this.name, this.locationName, this.favourite, this.weatherDays);

  Future<bool> update() async {
    create();
    await _loadWeatherDays();
    if (locationName.isNotEmpty && !checkWeatherToday()) {
      final response = await http.get(Uri.parse(url + locationName + urlParams));
      if (response.statusCode == 200) {
        _fillWeatherDays(json.decode(response.body));
        return true;
      } else {
        return false;
      }
    }
    return checkWeatherToday();
  }

  Future<String> getName() async {
    await update();
    return locationName;
  }

  bool checkWeatherToday() {
    DateTime now = DateTime.now();
    int beforeNow = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    int afterNow = DateTime(now.year, now.month, now.day+5).millisecondsSinceEpoch;
    var today = weatherDays.where((weatherDay) => weatherDay.datetime > beforeNow && weatherDay.datetime < afterNow);
    if (today.length >= (8 * 5 - (now.hour + 3) ~/ 3)) {
      return true;
    } else {
      return false;
    }
  }

  _loadWeatherDays() async {
    var _locationsBox = Hive.box<LocationsHive>('box_for_locations');
    weatherDays = _locationsBox.values.firstWhere((element) => element.locationName == locationName).weatherDays;
  }

  _fillWeatherDays(Map body) async {
    var _locationsBox = Hive.box<LocationsHive>('box_for_locations');
    weatherDays = _locationsBox.values.firstWhere((element) => element.locationName == locationName).weatherDays;
    body["list"].forEach((day) =>
    {
      if (
        weatherDays
          .where(
            (element) =>
            element.datetime == day["dt"] * 1000
          )
          .toList()
          .isEmpty
      ) weatherDays.add(
        WeatherDayHive(
          day["dt"] * 1000,
          [
            DayAdditionalDetailHive(
              "thermometer", day["main"]["temp"].toString(),
              "\u00B0C", "assets/thermometer.png"),
            DayAdditionalDetailHive(
              "barometer", day["main"]["pressure"].toString(),
              "гПа", "assets/barometer.png"),
            DayAdditionalDetailHive(
              "breeze", day["wind"]["speed"].toString(), "м/с",
              "assets/breeze.png"),
            DayAdditionalDetailHive(
              "humidity", day["main"]["humidity"].toString(), "%",
              "assets/humidity.png")
          ],
          day["weather"].first["icon"]
        )
      ),
    });
    _updateBox();
  }

  favouriteChange() async {
    await update();
    favourite = !favourite;
    _updateBox();
  }
  _updateBox() {
    var _locationsBox = Hive.box<LocationsHive>('box_for_locations');
    _locationsBox.putAt(_locationsBox.values.toList().indexWhere((element) => element.locationName == locationName), LocationsHive(name, locationName, favourite, weatherDays));
  }

  check() {
    return Hive.box<LocationsHive>('box_for_locations').values.where((element) => element.locationName == locationName).isEmpty;
  }

  create() {
    if (check() && name.isNotEmpty && locationName.isNotEmpty) Hive.box<LocationsHive>('box_for_locations').add(LocationsHive(name, locationName, favourite, weatherDays));
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