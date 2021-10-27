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