// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_wheel_type_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetWheelTypeDetailModelAdapter
    extends TypeAdapter<GetWheelTypeDetailModel> {
  @override
  final int typeId = 11;

  @override
  GetWheelTypeDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetWheelTypeDetailModel(
      status: fields[0] as bool?,
      data: (fields[1] as List?)?.cast<WheelDetailData>(),
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GetWheelTypeDetailModel obj) {
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
      other is GetWheelTypeDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WheelDetailDataAdapter extends TypeAdapter<WheelDetailData> {
  @override
  final int typeId = 12;

  @override
  WheelDetailData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WheelDetailData(
      id: fields[0] as int?,
      modelId: fields[1] as WheelDetailModelId?,
      wheelTypeName: fields[2] as String?,
      wheelTypeStatus: fields[3] as String?,
      favouriteStatus: fields[4] as String?,
      torque: fields[6] as String?,
      wheelTypeIMG: fields[5] as String?,
      description: fields[7] as String?,
      checkDetailsDescription: fields[8] as String?,
      makeMaster: fields[9] as MakeMaster?,
      torqueNm: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WheelDetailData obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.modelId)
      ..writeByte(2)
      ..write(obj.wheelTypeName)
      ..writeByte(3)
      ..write(obj.wheelTypeStatus)
      ..writeByte(4)
      ..write(obj.favouriteStatus)
      ..writeByte(5)
      ..write(obj.wheelTypeIMG)
      ..writeByte(6)
      ..write(obj.torque)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.checkDetailsDescription)
      ..writeByte(9)
      ..write(obj.makeMaster)
      ..writeByte(10)
      ..write(obj.torqueNm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WheelDetailDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WheelDetailModelIdAdapter extends TypeAdapter<WheelDetailModelId> {
  @override
  final int typeId = 13;

  @override
  WheelDetailModelId read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WheelDetailModelId(
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
  void write(BinaryWriter writer, WheelDetailModelId obj) {
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
      other is WheelDetailModelIdAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MakeMasterAdapter extends TypeAdapter<MakeMaster> {
  @override
  final int typeId = 17;

  @override
  MakeMaster read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MakeMaster(
      id: fields[0] as int?,
      vehiclemasterId: fields[1] as int?,
      makeName: fields[2] as String?,
      makeStatus: fields[3] as String?,
      updatedAt: fields[4] as String?,
      createdAt: fields[5] as String?,
      deletedAt: fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, MakeMaster obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vehiclemasterId)
      ..writeByte(2)
      ..write(obj.makeName)
      ..writeByte(3)
      ..write(obj.makeStatus)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.deletedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MakeMasterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
