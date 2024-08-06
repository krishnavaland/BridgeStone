// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_favourite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetFavouriteModelAdapter extends TypeAdapter<GetFavouriteModel> {
  @override
  final int typeId = 14;

  @override
  GetFavouriteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetFavouriteModel(
      status: fields[0] as bool?,
      data: (fields[1] as List?)?.cast<GetFavData>(),
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GetFavouriteModel obj) {
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
      other is GetFavouriteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GetFavDataAdapter extends TypeAdapter<GetFavData> {
  @override
  final int typeId = 15;

  @override
  GetFavData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetFavData(
      id: fields[0] as int?,
      deviceId: fields[1] as String?,
      deviceType: fields[2] as String?,
      wheelTypeId: fields[3] as String?,
      wheelData: fields[4] as FavouriteData?,
    );
  }

  @override
  void write(BinaryWriter writer, GetFavData obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.deviceId)
      ..writeByte(2)
      ..write(obj.deviceType)
      ..writeByte(3)
      ..write(obj.wheelTypeId)
      ..writeByte(4)
      ..write(obj.wheelData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetFavDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavouriteDataAdapter extends TypeAdapter<FavouriteData> {
  @override
  final int typeId = 16;

  @override
  FavouriteData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavouriteData(
      id: fields[0] as int?,
      modelId: fields[1] as int?,
      wheelTypeName: fields[2] as String?,
      wheelTypeStatus: fields[3] as String?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
      deletedAt: fields[6] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, FavouriteData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.modelId)
      ..writeByte(2)
      ..write(obj.wheelTypeName)
      ..writeByte(3)
      ..write(obj.wheelTypeStatus)
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
      other is FavouriteDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
