import 'package:hive/hive.dart';

part 'get_wheel_type_detail_model.g.dart';

@HiveType(typeId: 11)
class GetWheelTypeDetailModel {
  @HiveField(0)
  bool? status;
  @HiveField(1)
  List<WheelDetailData>? data;

  @HiveField(2)
  String? message;

  GetWheelTypeDetailModel({this.status, this.data, this.message});

  GetWheelTypeDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <WheelDetailData>[];
      json['data'].forEach((v) {
        data!.add(new WheelDetailData.fromJson(v));
      });
    }    message = json['message'];
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

@HiveType(typeId: 12)
class WheelDetailData {
  @HiveField(0)
  int? id;
  @HiveField(1)
  WheelDetailModelId? modelId;
  @HiveField(2)
  String? wheelTypeName;
  @HiveField(3)
  String? wheelTypeStatus;
  @HiveField(4)
  String? favouriteStatus;
  @HiveField(5)
  String? wheelTypeIMG;
  @HiveField(6)
  String? torque;
  @HiveField(7)
  String? description;
  @HiveField(8)
  String? checkDetailsDescription;
  @HiveField(9)
  MakeMaster? makeMaster;
  @HiveField(10)
  String? torqueNm;

  WheelDetailData(
      {this.id,
      this.modelId,
      this.wheelTypeName,
      this.wheelTypeStatus,
      this.favouriteStatus,
      this.torque,
      this.wheelTypeIMG,
      this.description,
      this.checkDetailsDescription,
      this.makeMaster,this.torqueNm});

  WheelDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['modelId'] != null
        ? WheelDetailModelId.fromJson(json['modelId'])
        : null;
    wheelTypeName = json['wheelTypeName'];
    wheelTypeStatus = json['wheelTypeStatus'];
    favouriteStatus = json['favourite_status'];
    torque = json['torque'];
    torqueNm = json['torque_nm'];
    wheelTypeIMG = json['WheelTypeIMG'];
    description = json['description'];
    checkDetailsDescription = json['check_details_description'];
    makeMaster = json['MakeMaster'] != null
        ? new MakeMaster.fromJson(json['MakeMaster'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (modelId != null) {
      data['modelId'] = modelId!.toJson();
    }
    data['wheelTypeName'] = wheelTypeName;
    data['wheelTypeStatus'] = wheelTypeStatus;
    data['favourite_status'] = favouriteStatus;
    data['torque'] = torque;
    data['torque_nm'] = torqueNm;
    data['WheelTypeIMG'] = wheelTypeIMG;
    data['description'] = description;
    data['check_details_description'] = checkDetailsDescription;
    if (this.makeMaster != null) {
      data['MakeMaster'] = this.makeMaster!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 13)
class WheelDetailModelId {
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

  WheelDetailModelId(
      {this.id,
      this.makeId,
      this.modelName,
      this.modelStatus,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  WheelDetailModelId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    makeId = json['makeId'];
    modelName = json['modelName'];
    modelStatus = json['modelStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['makeId'] = makeId;
    data['modelName'] = modelName;
    data['modelStatus'] = modelStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

@HiveType(typeId: 17)
class MakeMaster {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? vehiclemasterId;
  @HiveField(2)
  String? makeName;
  @HiveField(3)
  String? makeStatus;
  @HiveField(4)
  String? updatedAt;
  @HiveField(5)
  String? createdAt;
  @HiveField(6)
  dynamic deletedAt;

  MakeMaster(
      {this.id,
      this.vehiclemasterId,
      this.makeName,
      this.makeStatus,
      this.updatedAt,
      this.createdAt,
      this.deletedAt});

  MakeMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehiclemasterId = json['VehiclemasterId'];
    makeName = json['makeName'];
    makeStatus = json['makeStatus'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['VehiclemasterId'] = this.vehiclemasterId;
    data['makeName'] = this.makeName;
    data['makeStatus'] = this.makeStatus;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
