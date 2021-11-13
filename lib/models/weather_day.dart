import 'package:hive/hive.dart';
part 'weather_day.g.dart';

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

@HiveType(typeId: 0)
class WeatherDayHive extends HiveObject {

  @HiveField(0)
  int datetime;

  @HiveField(1)
  String location;

  @HiveField(2)
  List<DayAdditionalDetailHive> details;

  @HiveField(3)
  String icon;

  WeatherDayHive(this.datetime, this.location, this.details, this.icon);
}