// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_category_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectVehicleCategoryModelAdapter
    extends TypeAdapter<SelectVehicleCategoryModel> {
  @override
  final int typeId = 9;

  @override
  SelectVehicleCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectVehicleCategoryModel(
      status: fields[0] as bool?,
      data: (fields[1] as List?)?.cast<CategoryData>(),
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SelectVehicleCategoryModel obj) {
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
      other is SelectVehicleCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryDataAdapter extends TypeAdapter<CategoryData> {
  @override
  final int typeId = 10;

  @override
  CategoryData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryData(
      id: fields[0] as int?,
      vehicleName: fields[1] as String?,
      vehicleImage: fields[2] as String?,
      vehicleStatus: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vehicleName)
      ..writeByte(2)
      ..write(obj.vehicleImage)
      ..writeByte(3)
      ..write(obj.vehicleStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
