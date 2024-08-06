import 'package:hive/hive.dart';

part 'select_make_model.g.dart';

@HiveType(typeId: 0)
class SelectMakeModel extends HiveObject {
  @HiveField(0)
  bool? status;
  @HiveField(1)
  List<MakeData>? data;
  @HiveField(2)
  String? message;

  SelectMakeModel({this.status, this.data, this.message});

  SelectMakeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <MakeData>[];
      json['data'].forEach((v) {
        data!.add(new MakeData.fromJson(v));
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

@HiveType(typeId: 1)
class MakeData extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? makeName;
  @HiveField(2)
  String? makeStatus;
  @HiveField(3)
  String? updatedAt;
  @HiveField(4)
  String? createdAt;
  @HiveField(5)
  dynamic deletedAt;
  @HiveField(6)
  int? vehicleMasterId;

  MakeData(
      {this.id,
      this.makeName,
      this.makeStatus,
      this.updatedAt,
      this.createdAt,
      this.deletedAt,
      this.vehicleMasterId});

  MakeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    makeName = json['makeName'];
    makeStatus = json['makeStatus'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    vehicleMasterId = json['VehiclemasterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['makeName'] = makeName;
    data['makeStatus'] = makeStatus;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['deleted_at'] = deletedAt;
    data['VehiclemasterId'] = vehicleMasterId;
    return data;
  }
}
