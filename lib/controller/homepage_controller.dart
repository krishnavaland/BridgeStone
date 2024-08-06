import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bridge_stone_tyre/constant/theme_constant.dart';
import 'package:bridge_stone_tyre/model/get_country_list_model.dart';
import 'package:bridge_stone_tyre/model/get_favourite_model.dart';
import 'package:bridge_stone_tyre/model/select_make_model.dart';
import 'package:bridge_stone_tyre/model/select_wheel_type_model.dart';
import 'package:bridge_stone_tyre/model/vehicle_category_model.dart';
import 'package:bridge_stone_tyre/network/homepage_network.dart';
import 'package:bridge_stone_tyre/routes/routes.dart';
import 'package:bridge_stone_tyre/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../boxes.dart';
import '../constant/string_constants.dart';
import '../constant/style_constant.dart';
import '../model/select_model_by_id_model.dart';
import '../widgets/app_bar_button.dart';
import 'network_controller.dart';

class HomepageController extends GetxController {
  var deviceModel;
  var deviceVersion;
  var deviceId;
  RxString selectedCountry = ''.obs;
  RxString selectWheelId = ''.obs;
  RxString termsAndCondition = ''.obs;
  RxString information = ''.obs;
  RxInt progress = 0.obs;
  RxDouble totalCount = 751.0.obs;
  RxBool nmCheck = true.obs;
  RxBool lbCheck = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isFirstTime = true.obs;
  RxBool isFavTextLoading = false.obs;
  Map<dynamic, dynamic> selectModelByIdModel = <dynamic, dynamic>{};
  Map<dynamic, dynamic> selectMakeModel = <dynamic, dynamic>{};
  Map<dynamic, dynamic> selectWheelDetail = <dynamic, dynamic>{};
  Map<dynamic, dynamic> selectWheelTypeModel = <dynamic, dynamic>{};
  SelectVehicleCategoryModel? selectVehicleCategoryModel;
  GetCountryListModel? getCountryListModel;
  GetFavouriteModel? getFavouriteModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setLocal();
    // getOfflineData();
  }

  setLocal() async {
    final pref = await SharedPreferences.getInstance();
    bool isFirst = pref.getBool('isFirstLaunch') ?? true;

    selectedCountry.value = pref.getString('country') ?? '';
    lbCheck.value = pref.getBool('torque') ?? false;
    nmCheck.value = !lbCheck.value;
    isFirstTime.value = isFirst;
  }

  // Widget floatingActionButton(void Function() function, {double? padding}) {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //       bottom: padding ?? 32,
  //     ),
  //     child: FloatingActionButton(
  //       onPressed: function,
  //       child: SvgPicture.asset('assets/icons/Group 6.svg'),
  //     ),
  //   );
  // }

  AppBar buildAppBar({String? title}) {
    return AppBar(
      title: Text(title ?? kHomeTitle),
      titleSpacing: 0,
      leadingWidth: 35,
      leading: IconButton(
        padding: const EdgeInsets.only(left: 16),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 16,
        ),
      ),
      actions: [
        AppBarButton(
          text: const Text('HOME'),
          onPressed: () {
            Get.offAllNamed(AppRoutes.home);
          },
        ),
      ],
    );
  }

  getOfflineData() async {
    selectMakeModel = Boxes.getMakeData().get('makeData') ?? {};
    selectVehicleCategoryModel = Boxes.selectVehicleCategoryModel().get('getCategories');
    selectModelByIdModel = Boxes.selectModelByIdModel().get('vehicleModels') ?? {};
    selectWheelTypeModel = Boxes.selectWheelType().get('wheelType') ?? {};
    selectWheelDetail = Boxes.getWheelTypeDetail().get('wheelTypeDetail') ?? {};
  }

  syncApiData() async {
    final homeNetwork = HomepageNetwork();
    if (await Utils.checkInternetConnectivity()) {
      /// sync homepage

      // await homeNetwork.getVehicleCategories();
      // progress.value = 20;
      // progress.value =
      //     double.parse((progress.value / totalCount.value).toStringAsFixed(4)) *
      //         100;

      /// sync my favorite
      await homeNetwork.getFavorites(deviceId: deviceId);
      progress.value = 20;
      // progress.value =
      //     double.parse((progress.value / totalCount.value).toStringAsFixed(4)) *
      //         100;
      /// sync make model
      if (selectMakeModel.isEmpty) await homeNetwork.getSelectMakeModelName();

      progress.value = 40;
      // for (int i = selectVehicleCategoryModel!.data!.length - 1; i >= 0; i--) {
      //   /// sync select make screen
      //   progress.value = progress.value + 10;
      //   progress.value = double.parse((progress.value / totalCount.value).toStringAsFixed(4)) * 100;
      // }
      // progress.value = 20.0;

      /// sync select model screen
      if (selectModelByIdModel.isEmpty) await homeNetwork.getVehicleModelName();

      progress.value = 60;
      // for (int i = selectMakeModel.length; i > 0; i--) {
      //   print('snyc Select+++${selectMakeModel[i.toString()].data}');
      //   for (var item in selectMakeModel[i.toString()].data) {
      //     progress.value = progress.value + 10;
      //     progress.value = double.parse((progress.value / totalCount.value).toStringAsFixed(4)) * 100;
      //   }
      // }
      // // progress.value = 30.0;
      //
      /// sync select wheeltype screen
      if (selectWheelTypeModel.isEmpty) await homeNetwork.getSelectWheelType();

      progress.value = 80;
      // for (int i = 0; i < selectModelByIdModel.length; i++) {
      //   for (var item
      //       in selectModelByIdModel[selectModelByIdModel.keys.toList()[i]]
      //           .data) {
      //     await homeNetwork.getSelectWheelType(item.id);
      //     progress.value = progress.value + 10;
      //     progress.value = double.parse((progress.value / totalCount.value).toStringAsFixed(4)) * 100;
      //   }
      // }
      // // progress.value = 50.0;
      //
      /// sync select wheel detail screen
      if (selectWheelDetail.isEmpty) await homeNetwork.getWheelDetails();
      progress.value = 100;
      progress.value = 0;

      // for (int i = 0; i < selectWheelTypeModel.length; i++) {
      //   print(
      //       'ye check krna${selectWheelTypeModel[selectWheelTypeModel.keys.toList()[i]].data}');
      //
      //   for (var item
      //       in selectWheelTypeModel[selectWheelTypeModel.keys.toList()[i]]
      //           .data) {
      //     await homeNetwork.getWheelDetails(wheelTypeId: item.id.toString());
      //     progress.value = progress.value + 10;
      //     progress.value = double.parse((progress.value / totalCount.value).toStringAsFixed(4)) * 100;
      //   }
      // }
      // progress.value = 100.0;
    }
  }

  AppBar buildAppBarFav(id, RxBool isFav, argId) {
    return AppBar(
      title: Text(kHomeTitle),
      titleSpacing: 0,
      leadingWidth: 35,
      leading: IconButton(
        padding: const EdgeInsets.only(left: 16),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 16,
        ),
      ),
      actions: [
        AppBarButton(
          text: const Text('HOME'),
          onPressed: () {
            Get.offAllNamed(AppRoutes.home);
          },
        ),
        const Center(child: Text('|')),
        Obx(() => AppBarButton(
              text: isFavTextLoading.isTrue
                  ? Container(
                      height: 20,
                      width: 20,
                      child: const CircularProgressIndicator(
                        color: secondaryColor,
                        strokeWidth: 1,
                      ),
                    )
                  : isFav.value
                      ? const Text('UN-FAVOURITE')
                      : const Text('FAVOURITE'),
              onPressed: () async {
                final box = Boxes.getWheelTypeDetail();
                final home = HomepageNetwork();
                bool isInternet = await Utils.checkInternetConnectivity();
                print('isInternet+++$isInternet');
                if (isInternet) {
                  isFavTextLoading.toggle();
                  if (isFavTextLoading.isTrue) {
                    if (isFav.isFalse) {
                      await home.addToFavorites(
                        deviceId: deviceId,
                        deviceType: Platform.isAndroid ? 'Android' : 'IOS',
                        wheelTypeId: id,
                      );
                      isFavTextLoading.toggle();
                      isFav.toggle();

                      selectWheelDetail[argId].favouriteStatus = 'active';
                      await box.put('wheelTypeDetail', selectWheelDetail);
                    } else {
                      await home.removeFromFavorites(
                        deviceId: deviceId,
                        deviceType: Platform.isAndroid ? 'Android' : 'IOS',
                        wheelTypeId: id,
                      );
                      isFav.toggle();
                      isFavTextLoading.toggle();
                      selectWheelDetail[argId].favouriteStatus = 'inactive';
                      await box.put('wheelTypeDetail', selectWheelDetail);
                    }
                  }
                } else {}
              },
            )),
      ],
    );
  }

  AppBar buildAppBarSettings(context) {
    return AppBar(
      title: Text(kHomeTitle),
      actions: [
        AppBarButton(
          text: const Text('SETTINGS'),
          onPressed: () {
            showSettingDialog(context);
          },
        ),
        const Center(child: Text('|')),
        AppBarButton(
          text: const Text('FAVOURITE'),
          onPressed: () {
            Get.toNamed(AppRoutes.myFavouriteScreen);
          },
        ),
      ],
    );
  }

  showSettingDialog(context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              // Return false to prevent closing the dialog
              return false;
            },
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.symmetric(horizontal: 48),
                color: Colors.white,
                // height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'CANCEL',
                                style: TextStyle(color: Colors.red),
                              )),
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('DONE'))
                        ],
                      ),
                    ),
                    AutoSizeText('Torque Units', style: kMediumText),
                    const SizedBox(height: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => CheckboxListTile(
                              dense: true,
                              title: Padding(
                                padding: const EdgeInsets.only(left: 38.0),
                                child: Center(child: AutoSizeText('NM', style: kMediumText)),
                              ),
                              value: nmCheck.value,
                              onChanged: (v) async {
                                final pref = await SharedPreferences.getInstance();
                                lbCheck.value = false;
                                nmCheck.value = true;
                                pref.remove('torque');
                              },
                            )),
                        Obx(() => CheckboxListTile(
                              dense: true,
                              title: Padding(
                                padding: const EdgeInsets.only(left: 38.0),
                                child: Center(child: AutoSizeText('lb ft', style: kMediumText)),
                              ),
                              value: lbCheck.value,
                              onChanged: (v) async {
                                final pref = await SharedPreferences.getInstance();
                                nmCheck.value = false;
                                lbCheck.value = true;
                                pref.setBool('torque', lbCheck.value);
                              },
                            )),
                      ],
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('COUNTRY'),
                    Obx(
                      () => TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.country);
                        },
                        child: Text(
                          selectedCountry.value.capitalize!,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                        showSyncDialog(context);
                        await syncApiData();

                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(color: secondaryColor, borderRadius: BorderRadius.circular(50)),
                        child: SvgPicture.asset(
                          'assets/icons/Group 6.svg',
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showSyncDialog(BuildContext context) {
    syncApiData();

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          // Return false to prevent closing the dialog
          // return false;
          return true;
        },
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 14,
                  ),
                  Obx(() => Text('Sync in progress...${progress.value}%'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
