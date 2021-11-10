import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ItemDetail {
  String strTitle;
  var isFavorite = false;
  ItemDetail (this.strTitle, this.isFavorite);
}

class DayCardDetail {
  String time;
  String icon;
  String temperature;
  String temperatureUnit;
  DayCardDetail (this.time, this.icon, this.temperature, this.temperatureUnit);
}

class DayAdditionalDetail {
  String type;
  String value;
  String unit;
  String icon;
  DayAdditionalDetail (this.type, this.value, this.unit, this.icon);
}

abstract class SettingsParameterDetails {
  late String type;
  late String name;
  late List<String> values;
  String change(String number, int select, String unit);
}

class SettingsBarometer extends SettingsParameterDetails{
  SettingsBarometer () {
    type = "barometer";
    name = "Давление";
    values = ["мм.рт.ст.", "гПа"];
  }
  @override
  String change(String number, int select, String unit) {
    if (select == 0 && unit != values[0]) {
      return (int.parse(number) / 1.333).round().toString();
    } else if (select == 1 && unit != values[1]) {
      return (int.parse(number) * 1.333).round().toString();
    }
    return number;
  }
}
class SettingsTemperature extends SettingsParameterDetails{
  SettingsTemperature () {
    type = "thermometer";
    name = "Температура";
    values = ["\u00B0C", "\u00B0F"];
  }
  @override
  String change(String number, int select, String unit) {
    if (select == 0 && unit != values[0]) {
      return ((int.parse(number) - 32) * 5/9).round().toString();
    } else if (select == 1 && unit != values[1]) {
      return ((int.parse(number) * 9/5) + 32).round().toString();
    }
    return number;
  }
}
class SettingsBreeze extends SettingsParameterDetails{
  SettingsBreeze () {
    type = "breeze";
    name = "Сила ветра";
    values = ["м/с", "км/ч"];
  }
  @override
  String change(String number, int select, String unit) {
    if (select == 0 && unit != values[0]) {
      return (int.parse(number) / 3.6).round().toString();
    } else if (select == 1 && unit != values[1]) {
      return (int.parse(number) * 3.6).round().toString();
    }
    return number;
  }
}

class SettingsParameter {
  int selected;
  SettingsParameterDetails parameter;
  SettingsParameter (this.parameter, this.selected);
  switchParameter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selected = selected == 1 ? 0 : 1;
    await prefs.setInt(parameter.name, selected);
  }
  update() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selected = prefs.getInt(parameter.name) ?? 0;
  }
  String getUnit() {
    return parameter.values[selected];
  }
}

class AboutAppDetail {
  String name;
  String org;
  String version;
  String date;
  String year;

  AboutAppDetail(this.name, this.org, this.version, this.date, this.year);
}

class PageTitles {
  String name;
  String title;
  PageTitles(this.name, this.title);
}
// class Album {
//   final int coord;
//   final int id;
//   final String title;
//
//   Album({
//     required this.userId,
//     required this.id,
//     required this.title,
//   });
//
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//     );
//   }
// }
class WeatherDay {
  List<DayCardDetail> dayDetails;
  List<DayAdditionalDetail> dayAdditionalDetails;
  DateTime datetime;
  String location;
  String locationName;

  WeatherDay(this.dayDetails, this.dayAdditionalDetails, this.datetime, this.location, this.locationName);

  update() async {
    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=Moscow&appid=0802fd908c155491e99f266ff0d443e5&lang=ru&units=metric'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // return Album.fromJson(jsonDecode(response.body));
      Map body = json.decode(response.body);
      body["list"].forEach((day) => {
        day["dt"],
        day["weather"]["main"] / ["description"],
        DayCardDetail("06:00", "assets/icon_lightning.png", day["main"]["temp"], "\u00B0C"),
        DayCardDetail("12:00", "assets/icon_sun.png", day["main"]["temp"], "\u00B0C"),
        DayCardDetail("18:00", "assets/icon_rain_heavy.png", day["main"]["temp"], "\u00B0C"),
        DayCardDetail("00:00", "assets/icon_rain.png", day["main"]["temp"], "\u00B0C"),
        DayAdditionalDetail("thermometer", day["main"]["temp"], "\u00B0C", "assets/thermometer.png"),
        DayAdditionalDetail("barometer", day["main"]["pressure"], "мм.рт.ст.", "assets/barometer.png"),
        DayAdditionalDetail("breeze", day["wind"], "м/с", "assets/breeze.png"),
        DayAdditionalDetail("humidity", day["main"]["humidity"], "%", "assets/humidity.png"),
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }
}

class WeatherDays {
  List<WeatherDay> weatherDays;
  DateTime timeUpdated;
  List<ItemDetail> locations;

  WeatherDays(this.weatherDays, this.timeUpdated, this.locations);
}

class HomeData {
  List<DayCardDetail> dayDetails = [
    DayCardDetail("06:00", "assets/icon_lightning.png", "10", "\u00B0C"),
    DayCardDetail("12:00", "assets/icon_sun.png", "10", "\u00B0C"),
    DayCardDetail("18:00", "assets/icon_rain_heavy.png", "10", "\u00B0C"),
    DayCardDetail("00:00", "assets/icon_rain.png", "10", "\u00B0C")
  ];
  List<DayAdditionalDetail> dayAdditionalDetails = [
    DayAdditionalDetail("thermometer", "8", "\u00B0C", "assets/thermometer.png"),
    DayAdditionalDetail("barometer", "761", "мм.рт.ст.", "assets/barometer.png"),
    DayAdditionalDetail("breeze", "9", "м/с", "assets/breeze.png"),
    DayAdditionalDetail("humidity", "87", "%", "assets/humidity.png"),
  ];

  List<SettingsParameter> settingsParameters = [
    SettingsParameter(SettingsTemperature(), 0),
    SettingsParameter(SettingsBreeze(), 0),
    SettingsParameter(SettingsBarometer(), 0),
  ];

  List<ItemDetail> locations = [
    ItemDetail("Москва", false),
    ItemDetail("Санкт-Петербург", true),
    ItemDetail("Екатеринбург", true)
  ];

  HomeData () {
    for (var element in settingsParameters) {
      element.update();
    }
    WeatherDay weatherDay = WeatherDay(dayDetails, dayAdditionalDetails, DateTime(2021), "London", "Лондон");
    weatherDay.update();
  }
  List<DayCardDetail> get getDayDetails => dayDetails;
  String getValue(String type, String value, String unit) {
    if (settingsParameters.indexWhere((element) => element.parameter.type == type) > -1) {
      SettingsParameter settingsParameter = settingsParameters.firstWhere((element) => element.parameter.type == type);
      return settingsParameter.parameter.change(value, settingsParameter.selected, unit);
    } else {
      return value;
    }
  }
  String getUnit(String type, String unit) {
    if (settingsParameters.indexWhere((element) => element.parameter.type == type) > -1) {
      SettingsParameter settingsParameter = settingsParameters
          .firstWhere((element) => element.parameter.type == type);
      return settingsParameter.getUnit();
    }
    return unit;
  }
}

// day: time, icon, value
// [value, value2]

// home values: town, value, date
// week: date, icon, [val1, val2]