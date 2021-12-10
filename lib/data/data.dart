import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/locations.dart';
import 'settings.dart';


class HomeData {

  List<SettingsParameter> settingsParameters = [
    SettingsParameter(SettingsTemperature(), 0),
    SettingsParameter(SettingsBreeze(), 0),
    SettingsParameter(SettingsBarometer(), 0),
  ];

  AppSettings appSettings = AppSettings("Light", "Moscow");

  final List<LocationsHive> _defaultLocations = [
    LocationsHive("Москва", "Moscow", false, []),
    LocationsHive("Лондон", "London", false, [])
  ];

  HomeData ();

  Future updateAll() async {
    for (var element in settingsParameters) {
      await element.update();
    }
    await appSettings.update();
    await updateLocations();
    return Future.delayed(
      const Duration(seconds: 3),
          () => true,
    );
    return true;
  }

  updateLocations() {
    var locationBox = Hive.box<LocationsHive>('box_for_locations');
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

  String getValue(String type, String value, String unit) {
    if (settingsParameters.indexWhere((element) => element.parameter.type == type) > -1) {
      SettingsParameter settingsParameter = settingsParameters.firstWhere((element) => element.parameter.type == type);
      return settingsParameter.parameter.change(value, settingsParameter.selected, unit);
    } else {
      return num.parse(value).round().toString();
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

  setLocationName(String locationName) {
    if(locationName.isNotEmpty) {
      appSettings.location = locationName;
      appSettings.updateLocation();
    }
  }
}