import 'package:hive/hive.dart';
part 'get_favourite_model.g.dart';

@HiveType(typeId: 14)
class GetFavouriteModel {
  @HiveField(0)
  bool? status;
  @HiveField(1)
  List<GetFavData>? data;
  @HiveField(2)
  String? message;

  GetFavouriteModel({this.status, this.data, this.message});

  GetFavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GetFavData>[];
      json['data'].forEach((v) {
        data!.add(GetFavData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

@HiveType(typeId: 15)
class GetFavData {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? deviceId;
  @HiveField(2)
  String? deviceType;
  @HiveField(3)
  String? wheelTypeId;
  @HiveField(4)
  FavouriteData? wheelData;

  GetFavData(
      {this.id,
      this.deviceId,
      this.deviceType,
      this.wheelTypeId,
      this.wheelData});

  GetFavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    deviceType = json['device_type'];
    wheelTypeId = json['wheeltypeId'];
    wheelData = json['WheelData'] != null
        ? FavouriteData.fromJson(json['WheelData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['deviceId'] = deviceId;
    data['device_type'] = deviceType;
    data['wheeltypeId'] = wheelTypeId;
    if (wheelData != null) {
      data['WheelData'] = wheelData!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 16)
class FavouriteData {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? modelId;
  @HiveField(2)
  String? wheelTypeName;
  @HiveField(3)
  String? wheelTypeStatus;
  @HiveField(4)
  String? createdAt;
  @HiveField(5)
  String? updatedAt;
  @HiveField(6)
  dynamic deletedAt;

  FavouriteData(
      {this.id,
      this.modelId,
      this.wheelTypeName,
      this.wheelTypeStatus,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  FavouriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['modelId'];
    wheelTypeName = json['wheelTypeName'];
    wheelTypeStatus = json['wheelTypeStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['modelId'] = modelId;
    data['wheelTypeName'] = wheelTypeName;
    data['wheelTypeStatus'] = wheelTypeStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
