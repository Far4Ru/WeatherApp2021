import 'package:shared_preferences/shared_preferences.dart';

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
  String change(String number, int select);
}

class SettingsBarometer extends SettingsParameterDetails{
  SettingsBarometer () {
    type = "barometer";
    name = "Давление";
    values = ["мм.рт.ст.", "гПа"];
  }
  @override
  String change(String number, int select) {
    if (select == 0) {
      return (int.parse(number) * 1.333).round().toString();
    } else if (select == 1) {
      return (int.parse(number) / 1.333).round().toString();
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
  String change(String number, int select) {
    if (select == 0) {
      return ((int.parse(number) - 32) * 5/9).round().toString();
    } else if (select == 1) {
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
  String change(String number, int select) {
    if (select == 0) {
      return (int.parse(number) * 3.6).round().toString();
    } else if (select == 1) {
      return (int.parse(number) / 3.6).round().toString();
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

class HomeData {
  List<DayCardDetail> dayDetails = [
    DayCardDetail("06:00", "assets/icon_lightning.png", "10", "C"),
    DayCardDetail("12:00", "assets/icon_sun.png", "10", "C"),
    DayCardDetail("18:00", "assets/icon_rain_heavy.png", "10", "C"),
    DayCardDetail("00:00", "assets/icon_rain.png", "10", "C")
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
  }
  List<DayCardDetail> get getDayDetails => dayDetails;
}

// day: time, icon, value
// [value, value2]

// home values: town, value, date
// week: date, icon, [val1, val2]