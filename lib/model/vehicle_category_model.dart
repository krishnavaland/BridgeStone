import 'package:hive/hive.dart';

part 'vehicle_category_model.g.dart';

@HiveType(typeId: 9)
class SelectVehicleCategoryModel {
  @HiveField(0)
  bool? status;
  @HiveField(1)
  List<CategoryData>? data;
  @HiveField(2)
  String? message;

  SelectVehicleCategoryModel({this.status, this.data, this.message});

  SelectVehicleCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
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

@HiveType(typeId: 10)
class CategoryData {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? vehicleName;
  @HiveField(2)
  String? vehicleImage;
  @HiveField(3)
  String? vehicleStatus;

  CategoryData(
      {this.id, this.vehicleName, this.vehicleImage, this.vehicleStatus});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleName = json['vehicleName'];
    vehicleImage = json['vehicleImage'];
    vehicleStatus = json['vehicleStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vehicleName'] = vehicleName;
    data['vehicleImage'] = vehicleImage;
    data['vehicleStatus'] = vehicleStatus;
    return data;
  }
}
