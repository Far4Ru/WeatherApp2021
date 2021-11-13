import 'package:hive/hive.dart';
part 'locations.g.dart';

@HiveType(typeId: 1)
class LocationsHive extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String locationName;

  @HiveField(2)
  bool favourite;

  LocationsHive(this.name, this.locationName, this.favourite);
}