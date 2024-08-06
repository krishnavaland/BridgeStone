import 'package:hive/hive.dart';

part 'select_model_by_id_model.g.dart';

@HiveType(typeId: 4)
class SelectModelByIdModel {
  @HiveField(0)
  bool? status;
  @HiveField(1)
  List<VehicleModelData>? data;
  @HiveField(2)
  String? message;

  SelectModelByIdModel({this.status, this.data, this.message});

  SelectModelByIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <VehicleModelData>[];
      json['data'].forEach((v) {
        data!.add(VehicleModelData.fromJson(v));
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

@HiveType(typeId: 5)
class VehicleModelData {
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

  VehicleModelData(
      {this.id,
      this.makeId,
      this.modelName,
      this.modelStatus,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  VehicleModelData.fromJson(Map<String, dynamic> json) {
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
