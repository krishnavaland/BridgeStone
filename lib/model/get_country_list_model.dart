import 'package:hive/hive.dart';
part 'get_country_list_model.g.dart';
@HiveType(typeId: 2)
class GetCountryListModel {
  @HiveField(0)
  bool? status;
  @HiveField(1)
  List<CountryData>? data;
  @HiveField(2)
  String? message;

  GetCountryListModel({this.status, this.data, this.message});

  GetCountryListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CountryData>[];
      json['data'].forEach((v) {
        data!.add(CountryData.fromJson(v));
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

@HiveType(typeId: 3)
class CountryData {
  int? id;
  @HiveField(0)
  String? countryName;
  @HiveField(1)
  String? countryCode;
  @HiveField(2)
  String? countryStatus;
  @HiveField(3)
  String? createdAt;
  @HiveField(4)
  String? updatedAt;
  @HiveField(5)
  dynamic deletedAt;

  CountryData(
      {this.id,
      this.countryName,
      this.countryCode,
      this.countryStatus,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  CountryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryName = json['countryName'];
    countryCode = json['countryCode'];
    countryStatus = json['countryStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['countryName'] = countryName;
    data['countryCode'] = countryCode;
    data['countryStatus'] = countryStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
