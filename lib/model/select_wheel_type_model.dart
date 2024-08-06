import 'package:hive/hive.dart';

part 'select_wheel_type_model.g.dart';

@HiveType(typeId: 6)
class SelectWheelTypeModel {
  @HiveField(0)
  bool? status;
  @HiveField(1)
  List<WheelData>? data;
  @HiveField(2)
  String? message;

  SelectWheelTypeModel({this.status, this.data, this.message});

  SelectWheelTypeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <WheelData>[];
      json['data'].forEach((v) {
        data!.add(new WheelData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

@HiveType(typeId: 7)
class WheelData {
  @HiveField(0)
  int? id;
  @HiveField(1)
  ModelId? modelId;
  @HiveField(2)
  String? wheelTypeName;
  @HiveField(3)
  String? wheelTypeStatus;
  @HiveField(4)
  String? checkDetailsDescription;

  WheelData({this.id, this.modelId, this.wheelTypeName, this.wheelTypeStatus});

  WheelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId =
        json['modelId'] != null ? new ModelId.fromJson(json['modelId']) : null;
    wheelTypeName = json['wheelTypeName'];
    wheelTypeStatus = json['wheelTypeStatus'];
    checkDetailsDescription = json['check_details_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.modelId != null) {
      data['modelId'] = this.modelId!.toJson();
    }
    data['wheelTypeName'] = this.wheelTypeName;
    data['wheelTypeStatus'] = this.wheelTypeStatus;
    data['check_details_description'] = this.checkDetailsDescription;
    return data;
  }
}

@HiveType(typeId: 8)
class ModelId {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? makeId;
  @HiveField(2)
  String? modelName;
  @HiveField(3)
  String? modelStatus;
  @HiveField(4)
  String? createdAt;
  @HiveField(5)
  String? updatedAt;
  @HiveField(6)
  dynamic deletedAt;

  ModelId(
      {this.id,
      this.makeId,
      this.modelName,
      this.modelStatus,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ModelId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    makeId = json['makeId'];
    modelName = json['modelName'];
    modelStatus = json['modelStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['makeId'] = this.makeId;
    data['modelName'] = this.modelName;
    data['modelStatus'] = this.modelStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
