import 'package:bridge_stone_tyre/model/get_country_list_model.dart';
import 'package:bridge_stone_tyre/model/get_favourite_model.dart';
import 'package:bridge_stone_tyre/model/vehicle_category_model.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Map<dynamic, dynamic>> getMakeData() =>
      Hive.box<Map<dynamic, dynamic>>('selectMakeModel');

  static Box<GetCountryListModel> getCountryList() =>
      Hive.box<GetCountryListModel>('getCountryListModel');

  static Box<Map<dynamic, dynamic>> selectModelByIdModel() =>
      Hive.box<Map<dynamic, dynamic>>('selectModelByIdModel');

  static Box<Map<dynamic, dynamic>> selectWheelType() =>
      Hive.box<Map<dynamic, dynamic>>('selectWheelTypeModel');

  static Box<Map<dynamic, dynamic>> getWheelTypeDetail() =>
      Hive.box<Map<dynamic, dynamic>>('getWheelTypeDetailModel');

  static Box<SelectVehicleCategoryModel> selectVehicleCategoryModel() =>
      Hive.box<SelectVehicleCategoryModel>('selectVehicleCategoryModel');

  static Box<GetFavouriteModel> getFavorite() =>
      Hive.box<GetFavouriteModel>('getFavouriteModel');
}
