import 'package:shared_preferences/shared_preferences.dart';

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
      return (num.parse(number) / 1.333).round().toString();
    } else if (select == 1 && unit != values[1]) {
      return (num.parse(number) * 1.333).round().toString();
    }
    try {
      return num.parse(number).round().toString();
    } catch (e) {
      return number;
    }
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
      return ((num.parse(number) - 32) * 5/9).round().toString();
    } else if (select == 1 && unit != values[1]) {
      return ((num.parse(number) * 9/5) + 32).round().toString();
    }
    try {
      return num.parse(number).round().toString();
    } catch (e) {
      return number;
    }
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
      return (num.parse(number) / 3.6).round().toString();
    } else if (select == 1 && unit != values[1]) {
      return (num.parse(number) * 3.6).round().toString();
    }
    try {
      return num.parse(number).round().toString();
    } catch (e) {
      return number;
    }
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

class AppSettings {
  String theme;
  String location;

  AppSettings(this.theme, this.location);

  update() async{
    if (theme.isEmpty && location.isEmpty) await setDefault();
    if (getTheme().toString().isEmpty) await updateTheme();
    if (getLocation().toString().isEmpty) await updateLocation();
  }

  setDefault() async {
    theme = "Light";
    await updateTheme();
    location = "Moscow";
    await updateLocation();
  }

  updateTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", theme);
  }

  updateLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("location", location);
  }

  getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    theme = prefs.getString("theme") ?? "";
    return theme;
  }
  getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    location = prefs.getString("location") ?? "";
    return location;
  }

  changeTheme() async {
    theme = theme == "dark" ? "light" : "dark";
    updateTheme();
  }
}