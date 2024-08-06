// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_model_by_id_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectModelByIdModelAdapter extends TypeAdapter<SelectModelByIdModel> {
  @override
  final int typeId = 4;

  @override
  SelectModelByIdModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectModelByIdModel(
      status: fields[0] as bool?,
      data: (fields[1] as List?)?.cast<VehicleModelData>(),
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SelectModelByIdModel obj) {
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
      other is SelectModelByIdModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class VehicleModelDataAdapter extends TypeAdapter<VehicleModelData> {
  @override
  final int typeId = 5;

  @override
  VehicleModelData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleModelData(
      id: fields[0] as int?,
      makeId: fields[1] as int?,
      modelName: fields[2] as String?,
      modelStatus: fields[3] as String?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
      deletedAt: fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, VehicleModelData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.makeId)
      ..writeByte(2)
      ..write(obj.modelName)
      ..writeByte(3)
      ..write(obj.modelStatus)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.deletedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleModelDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
