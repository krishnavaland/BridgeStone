// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_make_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SelectMakeModelAdapter extends TypeAdapter<SelectMakeModel> {
  @override
  final int typeId = 0;

  @override
  SelectMakeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SelectMakeModel(
      status: fields[0] as bool?,
      data: (fields[1] as List?)?.cast<MakeData>(),
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SelectMakeModel obj) {
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
      other is SelectMakeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MakeDataAdapter extends TypeAdapter<MakeData> {
  @override
  final int typeId = 1;

  @override
  MakeData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MakeData(
      id: fields[0] as int?,
      makeName: fields[1] as String?,
      makeStatus: fields[2] as String?,
      updatedAt: fields[3] as String?,
      createdAt: fields[4] as String?,
      deletedAt: fields[5] as dynamic,
      vehicleMasterId: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MakeData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.makeName)
      ..writeByte(2)
      ..write(obj.makeStatus)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.deletedAt)
      ..writeByte(6)
      ..write(obj.vehicleMasterId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MakeDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
