// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayAdditionalDetailHiveAdapter
    extends TypeAdapter<DayAdditionalDetailHive> {
  @override
  final int typeId = 2;

  @override
  DayAdditionalDetailHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayAdditionalDetailHive(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DayAdditionalDetailHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayAdditionalDetailHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WeatherDayHiveAdapter extends TypeAdapter<WeatherDayHive> {
  @override
  final int typeId = 0;

  @override
  WeatherDayHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherDayHive(
      fields[0] as int,
      fields[1] as String,
      (fields[2] as List).cast<DayAdditionalDetailHive>(),
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherDayHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.datetime)
      ..writeByte(1)
      ..write(obj.location)
      ..writeByte(2)
      ..write(obj.details)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherDayHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
