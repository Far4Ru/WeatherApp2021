import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/locations.dart';
import 'settings.dart';

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

  final List<LocationsHive> _defaultLocations = [
    LocationsHive("Москва", "Moscow", false, []),
    LocationsHive("Лондон", "London", false, [])
  ];

  HomeData () {
    for (var element in settingsParameters) {
      element.update();
    }
    updateLocations();
  }

  updateLocations() async {
    var locationBox = await Hive.openBox<LocationsHive>('box_for_locations');
    if (locationBox.values.isEmpty) {
      for (var defaultLocation in _defaultLocations) {
        locationBox.add(
            defaultLocation
        );
      }
    }
    for (var location in locationBox.values) {
      location.update();
    }
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