import 'package:bridge_stone_tyre/boxes.dart';
import 'package:bridge_stone_tyre/model/get_country_list_model.dart';
import 'package:bridge_stone_tyre/model/get_favourite_model.dart';
import 'package:bridge_stone_tyre/model/get_wheel_type_detail_model.dart';
import 'package:bridge_stone_tyre/model/select_wheel_type_model.dart';
import 'package:bridge_stone_tyre/model/vehicle_category_model.dart';
import 'package:bridge_stone_tyre/network/api_service.dart';
import 'package:bridge_stone_tyre/utils.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/homepage_controller.dart';
import '../model/select_make_model.dart';
import '../model/select_model_by_id_model.dart';

class HomepageNetwork {
  final homeController = Get.find<HomepageController>();

  Future getCountryList() async {
    final res = await ApiProvider.get(
      '/GetCountryList',
    );
    if (res['status'] >= 200 && res['status'] < 300) {
      homeController.getCountryListModel =
          GetCountryListModel.fromJson(res['body']);

      final getCountry = GetCountryListModel(
        status: res['body']['status'],
        data: List<CountryData>.from(
          res['body']['data'].map(
            (country) => CountryData(
              id: country['id'],
              countryName: country['countryName'],
              countryCode: country['countryCode'],
              countryStatus: country['countryStatus'],
              updatedAt: country['updated_at'],
              createdAt: country['created_at'],
              deletedAt: country['deleted_at'],
            ),
          ),
        ),
        message: res['body']['message'],
      );
      final box = Boxes.getCountryList();
      box.put('getCountry', getCountry);
    } else {
      Utils.showToast();
      print('error getCountryList');
    }
    print('res+++ getCountryList${homeController.getCountryListModel}');
  }

  Future getVehicleCategories() async {
    final res = await ApiProvider.get(
      '/Select_vehicle_category',
    );
    if (res['status'] >= 200 && res['status'] < 300) {
      print('getVehicleCategories++$res');
      homeController.selectVehicleCategoryModel =
          SelectVehicleCategoryModel.fromJson(res['body']);
      homeController.isLoaded.value = true;
      final getCategories = SelectVehicleCategoryModel(
        status: res['body']['status'],
        data: List<CategoryData>.from(
          res['body']['data'].map(
            (category) => CategoryData(
              id: category['id'],
              vehicleName: category['vehicleName'],
              vehicleImage: category['vehicleImage'],
              vehicleStatus: category['vehicleStatus'],
            ),
          ),
        ),
        message: res['body']['message'],
      );
      final box = Boxes.selectVehicleCategoryModel();
      box.put('getCategories', getCategories);
    } else {
      print('error getCountryList');
    }
    print('res+++ getCountryList${homeController.getCountryListModel}');
  }

  Future getSelectMakeModelName(
      // {vehicleId}
      {from}) async {
    try {
      final res = await ApiProvider.postForm(url: '/GetmakeData', body: {
        // "VehiclemasterId": vehicleId,
      });
      if (res['status'] >= 200 && res['status'] < 300) {
        final selectMakeModel = SelectMakeModel(
          status: res['body']['status'],
          data: List<MakeData>.from(
            res['body']['data'].map(
              (make) => MakeData(
                id: make['id'],
                makeName: make['makeName'],
                vehicleMasterId: make['VehiclemasterId'],
                makeStatus: make['makeStatus'],
                updatedAt: make['updated_at'],
                createdAt: make['created_at'],
                deletedAt: make['deleted_at'],
              ),
            ),
          ),
          message: res['body']['message'],
        );
        Box<Map<dynamic, dynamic>> box = Boxes.getMakeData();
        if (from != 'screen') {
          print('res+++ getVehicleModelName${homeController.selectMakeModel}');

          for (var item in homeController.selectVehicleCategoryModel!.data!) {
            List makeData = [];

            for (var make in selectMakeModel.data!) {
              if (item.id == make.vehicleMasterId) {
                makeData.add(make);
              }
            }
            homeController.selectMakeModel
                .addEntries([MapEntry(item.id.toString(), makeData)]);
          }
        }
        box.put('makeData', homeController.selectMakeModel);
      } else {
        print('error getVehicleModelName');
      }
    } catch (e) {
      homeController.isLoaded.value = true;
      print('ffffffffffff$e');
    }
  }

  Future getVehicleModelName(
      // id
      {from}) async {
    {}
    // print('getId+++$id');
    final res = await ApiProvider.post(
      url: '/GetmodelById',
    );
    if (res['status'] >= 200 && res['status'] < 300) {
      final selectModelByIdModel = SelectModelByIdModel(
        status: res['body']['status'],
        data: List<VehicleModelData>.from(
          res['body']['data'].map(
            (model) => VehicleModelData(
              id: model['id'],
              makeId: model['makeId'],
              modelName: model['modelName'],
              modelStatus: model['modelStatus'],
              updatedAt: model['updated_at'],
              createdAt: model['created_at'],
              deletedAt: model['deleted_at'],
            ),
          ),
        ),
        message: res['body']['message'],
      );
      if (from != 'screen') {
        for (var category in homeController.selectVehicleCategoryModel!.data!) {
          print('cat+++++${category.id}');
          if (homeController.selectMakeModel[category.id.toString()] != null) {
            for (var make
                in homeController.selectMakeModel[category.id.toString()]) {
              List modelData = [];
              for (var model in selectModelByIdModel.data!) {
                print('yha aayi make.id${make.id}--------${model.makeId}');
                if (make.id == model.makeId) {
                  modelData.add(model);
                }
              }

              homeController.selectModelByIdModel
                  .addEntries([MapEntry(make.id.toString(), modelData)]);
            }
          }
        }
      }

      final box = Boxes.selectModelByIdModel();
      box.put('vehicleModels', homeController.selectModelByIdModel);
    } else {
      print('error getVehicleModelName');
    }
    print('res+++ getVehicleModelName${homeController.selectModelByIdModel}');
  }

  Future getSelectWheelType(// id
      ) async {
    print(  'res getSelectWheelType+++-----');
    final res = await ApiProvider.post(
      url: '/Select_wheel_type',
      // body: {
      //   // "modelId": id,
      // },
    );
    print('res getSelectWheelType+++-----$res');
    if (res['status'] >= 200 && res['status'] < 300) {
      final selectWheelTypeModel = SelectWheelTypeModel(
        status: res['body']['status'],
        data: List<WheelData>.from(
          res['body']['data'].map(
            (wheel) {
              if (wheel['modelId'] != null) {
                return WheelData(
                  id: wheel['id'],
                  modelId: ModelId(
                    id: wheel['modelId']['id'],
                    makeId: wheel['modelId']['makeId'],
                    modelName: wheel['modelId']['modelName'],
                    modelStatus: wheel['modelId']['modelStatus'],
                    updatedAt: wheel['modelId']['updated_at'],
                    createdAt: wheel['modelId']['created_at'],
                    deletedAt: wheel['modelId']['deleted_at'],
                  ),
                  wheelTypeName: wheel['wheelTypeName'],
                  wheelTypeStatus: wheel['wheelTypeStatus'],
                );
              } else {
                return WheelData(
                  id: 0,
                  modelId: ModelId(
                    id: 0,
                    makeId: 0,
                    modelName: '',
                    modelStatus: '',
                    updatedAt: '',
                    createdAt: '',
                    deletedAt: '',
                  ),
                  wheelTypeName: wheel['wheelTypeName'],
                  wheelTypeStatus: wheel['wheelTypeStatus'],
                );
              }
            },
          ),
        ),
        message: res['body']['message'],
      );
      for (var category in homeController.selectVehicleCategoryModel!.data!) {
        print(
            'make++++++${homeController.selectMakeModel[category.id.toString()]}');
        for (var make
            in homeController.selectMakeModel[category.id.toString()]) {
          if (homeController.selectModelByIdModel[make.id.toString()] != null) {
            print('make.category.id.id${category.id}');
            print('make.idmake.id${make.id}');
            for (var model
                in homeController.selectModelByIdModel[make.id.toString()]) {
              List wheelList = [];

              for (var wheelType in selectWheelTypeModel.data!) {
                if (model.id == wheelType.modelId?.id) {
                  wheelList.add(wheelType);
                }
              }

              print('wheelList++++${wheelList}');
              homeController.selectWheelTypeModel
                  .addEntries([MapEntry(model.id.toString(), wheelList)]);
            }
          }
        }
      }
      final box = Boxes.selectWheelType();
      box.put('wheelType', homeController.selectWheelTypeModel);
    } else {
      Utils.showToast(message: res['body']['message']);
      print('error getSelectWheelType');
    }
    print('res+++ getVehicleModelName${homeController.selectMakeModel}');
  }

  Future addToFavorites({
    required String deviceId,
    required String deviceType,
    required dynamic wheelTypeId,
  }) async {
    final res = await ApiProvider.postForm(
      url: '/add_to_favourite',
      body: {
        "deviceId[]": deviceId,
        "device_type[]": deviceType.toLowerCase(),
        "wheeltypeId[]": wheelTypeId
      },
    );
    print('res+++addToFavorites$wheelTypeId-----$res');
    if (res['status'] >= 200 && res['status'] < 300) {
      print('add to favorite');
      Utils.showToast(message: res['body']['message']);
      // await getFavorites(deviceId: homeController.deviceId);
    } else {
      print('error addToFavorites');
    }
  }

  Future removeFromFavorites({
    required String deviceId,
    required String deviceType,
    required dynamic wheelTypeId,
  }) async {
    final res = await ApiProvider.postForm(
      url: '/remove_from_favourite',
      body: {
        "deviceId[]": deviceId,
        "device_type[]": deviceType.toLowerCase(),
        "wheeltypeId[]": wheelTypeId
      },
    );
    print('res+++addToFavorites$wheelTypeId-----$res');
    if (res['status'] >= 200 && res['status'] < 300) {
      print('add to favorite');
      Utils.showToast(message: res['body']['message']);
      // await getFavorites(deviceId: homeController.deviceId);
    } else {
      print('error addToFavorites');
    }
  }

  Future getFavorites({
    required String deviceId,
  }) async {
    final res = await ApiProvider.postForm(
      url: '/get_favourite',
      body: {
        "deviceId": deviceId,
      },
    );
    print('res+++getFavorites$deviceId-----$res');
    if (res['status'] >= 200 && res['status'] < 300) {
      print('getFavorites favorite');
      homeController.getFavouriteModel =
          GetFavouriteModel.fromJson(res['body']);
      final getFavouriteModel = GetFavouriteModel(
        status: res['body']['status'],
        data: List<GetFavData>.from(
          res['body']['data'].map(
            (fav) => fav['WheelData'] != null
                ? GetFavData(
                    id: fav['id'],
                    wheelTypeId: fav['wheeltypeId'],
                    wheelData: FavouriteData(
                      id: fav['WheelData']['id'],
                      modelId: fav['WheelData']['modelId'],
                      wheelTypeName: fav['WheelData']['wheelTypeName'],
                      wheelTypeStatus: fav['WheelData']['wheelTypeStatus'],
                      updatedAt: fav['WheelData']['updated_at'],
                      createdAt: fav['WheelData']['created_at'],
                      deletedAt: fav['WheelData']['deleted_at'],
                    ),
                    deviceId: fav['deviceId'],
                    deviceType: fav['device_type'],
                  )
                : GetFavData(),
          ),
        ),
        message: res['body']['message'],
      );

      final box = Boxes.getFavorite();
      box.put('getFavorite', getFavouriteModel);
    } else {
      if (homeController.getFavouriteModel?.data?.length == 1 ||
          res['body']['message'] == 'Favourite Data empty.') {
        homeController.getFavouriteModel = null;
      }
      Utils.showToast(message: res['body']['message']);
      print('error getFavorites');
    }
  }

  Future getWheelDetails(
      // {
      // required String wheelTypeId,
      {from}
      // }
      ) async {
    final pref = await SharedPreferences.getInstance();
    bool isOnce = pref.getBool('getWheelDetailsOnce') ?? true;
    if (isOnce) {
      final res = await ApiProvider.postForm(
        url: '/wheel_type_detail',
        body: {
          // "WheelTypeId": wheelTypeId,
          "deviceId": homeController.deviceId,
        },
      );
      if (res['status'] >= 200 && res['status'] < 300) {
        final selectWheelDetail = GetWheelTypeDetailModel(
          status: res['body']['status'],
          data: List<WheelDetailData>.from(res['body']['data'].map((detail) {
            print('detaildetaildetaildetail$detail');
            if (detail['modelId'] != null) {
              return WheelDetailData(
                  id: detail['id'],
                  modelId: WheelDetailModelId(
                    id: detail['modelId']['id'],
                    makeId: detail['modelId']['makeId'],
                    modelName: detail['modelId']['modelName'],
                    modelStatus: detail['modelId']['modelStatus'],
                    updatedAt: detail['modelId']['updated_at'],
                    createdAt: detail['modelId']['created_at'],
                    deletedAt: detail['modelId']['deleted_at'],
                  ),
                  wheelTypeName: detail['wheelTypeName'],
                  wheelTypeStatus: detail['wheelTypeStatus'],
                  favouriteStatus: detail['favourite_status'],
                  torque: detail['torque'],
                  torqueNm: detail['torque_nm'],
                  description: detail['description'],
                  checkDetailsDescription: detail['check_details_description'],
                  makeMaster: MakeMaster(
                    id: detail['MakeMaster']['id'],
                    vehiclemasterId: detail['MakeMaster']['VehiclemasterId'],
                    makeName: detail['MakeMaster']['makeName'],
                    updatedAt: detail['MakeMaster']['makeStatus'],
                    createdAt: detail['MakeMaster']['updated_at'],
                    deletedAt: detail['MakeMaster']['deleted_at'],
                  ));
            } else {
              return WheelDetailData(
                  id: 0,
                  modelId: WheelDetailModelId(
                    id: 0,
                    makeId: 0,
                    modelName: '',
                    modelStatus: '',
                    updatedAt: '',
                    createdAt: '',
                    deletedAt: '',
                  ),
                  wheelTypeName: '',
                  wheelTypeStatus: '',
                  favouriteStatus: '',
                  torque: '',
                  description: '',
                  checkDetailsDescription: '',
                  makeMaster: MakeMaster(
                    id: 0,
                    vehiclemasterId: 0,
                    makeName: '',
                    updatedAt: '',
                    createdAt: '',
                    deletedAt: '',
                  ));
            }
          })),
          message: res['body']['message'],
        );
        // if (from != 'screen') {
        for (var modelId in homeController.selectWheelTypeModel.keys) {
          for (var selectWheelType
              in homeController.selectWheelTypeModel[modelId]) {
            for (var detail in selectWheelDetail.data!) {
              if (selectWheelType.id == detail.id) {
                homeController.selectWheelDetail.addEntries(
                    [MapEntry(selectWheelType.id.toString(), detail)]);
              }
            }
          }
        }
        pref.setBool('getWheelDetailsOnce', false);
        // }
        //
        Box<Map<dynamic, dynamic>> box = Boxes.getWheelTypeDetail();
        box.put('wheelTypeDetail', homeController.selectWheelDetail);
      } else {
        print('error getWheelDetails');
      }
    }
  }

  Future termsAndCondition() async {
    final pref = await SharedPreferences.getInstance();
    homeController.termsAndCondition.value =
        pref.getString('termsAndCondition') ?? '';
    if (homeController.termsAndCondition.isEmpty) {
      final res = await ApiProvider.get('/terms_conditions');
      print('terms+++$res');
      if (res['status'] >= 200 && res['status'] < 300) {
        homeController.termsAndCondition.value = res['body']['data']['details'];
        pref.setString(
            'termsAndCondition', homeController.termsAndCondition.value);
      } else {
        Utils.showToast();
      }
    }
  }

  Future informationData() async {
    final pref = await SharedPreferences.getInstance();
    homeController.information.value = pref.getString('information') ?? '';
    if (homeController.information.isEmpty) {
      final res = await ApiProvider.get('/information');
      print('terms+++$res');
      if (res['status'] >= 200 && res['status'] < 300) {
        homeController.information.value = res['body']['data']['details'];
        pref.setString('information', homeController.information.value);
      } else {
        Utils.showToast();
      }
    }
  }
}
