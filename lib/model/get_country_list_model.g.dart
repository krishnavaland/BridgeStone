// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_country_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetCountryListModelAdapter extends TypeAdapter<GetCountryListModel> {
  @override
  final int typeId = 2;

  @override
  GetCountryListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetCountryListModel(
      status: fields[0] as bool?,
      data: (fields[1] as List?)?.cast<CountryData>(),
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GetCountryListModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetCountryListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CountryDataAdapter extends TypeAdapter<CountryData> {
  @override
  final int typeId = 3;

  @override
  CountryData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountryData(
      countryName: fields[0] as String?,
      countryCode: fields[1] as String?,
      countryStatus: fields[2] as String?,
      createdAt: fields[3] as String?,
      updatedAt: fields[4] as String?,
      deletedAt: fields[5] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, CountryData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.countryName)
      ..writeByte(1)
      ..write(obj.countryCode)
      ..writeByte(2)
      ..write(obj.countryStatus)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.deletedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
