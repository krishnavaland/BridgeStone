// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_wheel_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectWheelTypeModelAdapter extends TypeAdapter<SelectWheelTypeModel> {
  @override
  final int typeId = 6;

  @override
  SelectWheelTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectWheelTypeModel(
      status: fields[0] as bool?,
      data: (fields[1] as List?)?.cast<WheelData>(),
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SelectWheelTypeModel obj) {
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
      other is SelectWheelTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WheelDataAdapter extends TypeAdapter<WheelData> {
  @override
  final int typeId = 7;

  @override
  WheelData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WheelData(
      id: fields[0] as int?,
      modelId: fields[1] as ModelId?,
      wheelTypeName: fields[2] as String?,
      wheelTypeStatus: fields[3] as String?,
    )..checkDetailsDescription = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, WheelData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.modelId)
      ..writeByte(2)
      ..write(obj.wheelTypeName)
      ..writeByte(3)
      ..write(obj.wheelTypeStatus)
      ..writeByte(4)
      ..write(obj.checkDetailsDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WheelDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ModelIdAdapter extends TypeAdapter<ModelId> {
  @override
  final int typeId = 8;

  @override
  ModelId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelId(
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
  void write(BinaryWriter writer, ModelId obj) {
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
      other is ModelIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
