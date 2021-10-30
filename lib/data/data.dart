class ItemDetail {
  String strTitle;
  var isFavorite = false;
  ItemDetail (this.strTitle, this.isFavorite);
}

class DayCardDetail {
  String time;
  String icon;
  String temperature;
  String temeratureUnit;
  DayCardDetail (this.time, this.icon, this.temperature, this.temeratureUnit);
}

class DayAdditionalDetail {
  String type;
  String value;
  String unit;
  String icon;
  DayAdditionalDetail (this.type, this.value, this.unit, this.icon);
}

class SettingsParameter {
  String type;
  String name;
  int selected;
  List<String> values;
  SettingsParameter (this.type, this.name, this.selected, this.values);
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
    SettingsParameter("thermometer", "Температура", 0, ["\u00B0C", "\u00B0F"]),
    SettingsParameter("breeze", "Сила ветра", 0, ["м/с", "км/ч"]),
    SettingsParameter("barometer", "Давление", 0, ["мм.рт.ст.", "гПа"]),
  ];

  List<ItemDetail> locations = [
    ItemDetail("Москва", false),
    ItemDetail("Санкт-Петербург", true),
    ItemDetail("Екатеринбург", true)
  ];

  HomeData ();
  List<DayCardDetail> get getDayDetails => dayDetails;
}
// Температура C / F
// Сила ветра м/с км/ч
// Давление мм.рт.ст. гПа

// day: time, icon, value
// [value, value2]

// home values: town, value, date
// week: date, icon, [val1, val2]