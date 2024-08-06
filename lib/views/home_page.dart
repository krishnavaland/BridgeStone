import 'package:bridge_stone_tyre/boxes.dart';
import 'package:bridge_stone_tyre/controller/homepage_controller.dart';
import 'package:bridge_stone_tyre/controller/network_controller.dart';
import 'package:bridge_stone_tyre/routes/routes.dart';
import 'package:bridge_stone_tyre/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/string_constants.dart';
import '../network/homepage_network.dart';
import '../widgets/vehicle_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeNetwork = HomepageNetwork();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Utils.getDeviceInfo();
    // Future.delayed(const Duration(milliseconds: 300), () => homeController.showSyncDialog(context));
    homeController.getOfflineData();
    homeNetwork.getVehicleCategories();
    if (mounted) {
      networkController.initCheck();
    }
  }



  final homeController = Get.find<HomepageController>();
  final networkController = Get.find<NetworkController>();
  bool runOnce = true;

  get networkStatus => networkController.connectivityStream().listen((event) {
        print('event+++111$event');
        if (event != ConnectivityResult.none && runOnce) {
          homeNetwork.getVehicleCategories().then((value) {
            setState(() {
              runOnce = false;
            });
          });
        }
      });

  @override
  Widget build(BuildContext context) {
    // homeController.selectMakeModel = Boxes.getMakeData().get('makeData') ?? {};

    // homeController.selectVehicleCategoryModel =
    //     Boxes.selectVehicleCategoryModel().get('getCategories');
    // print(('progress.value++;1${homeController.selectMakeModel['4'].map((e)=>e.id)}'));
    // print(('progress.value++;2222${homeController.selectModelByIdModel}'));
    print(('progress.value++;0${homeController.deviceId}'));
    return Scaffold(
      appBar: homeController.buildAppBarSettings(context),
      body: FutureBuilder<bool>(
        future: Utils.checkInternetConnectivity(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If you have locally saved data, show it
            if (homeController.selectVehicleCategoryModel != null) {
              return homepageColumn();
            } else {
              // Otherwise, show a loading indicator
              return const Center(child: CircularProgressIndicator());
            }
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred.'));
          } else if (!snapshot.data &&
              homeController.selectVehicleCategoryModel == null) {
            // No internet connection
            return Center(
                child: Column(
              children: [
                TextButton(
                  child: const Text('No internet connection.'),
                  onPressed: () {
                    networkStatus;
                  },
                ),
              ],
            ));
          } else {
            // Internet connection is available, render your content
            return homepageColumn();
          }
        },
      ),
      // floatingActionButton: homeController.floatingActionButton(() async {
      //   await networkStatus;
      //   setState(() {});
      // }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Obx homepageColumn() {
    return Obx(() {
      return (homeController.isLoaded.isFalse &&
              homeController.selectVehicleCategoryModel == null)
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                  child: SvgPicture.asset(assetName),
                ),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    for (int i = homeController
                                .selectVehicleCategoryModel!.data!.length -
                            1;
                        i >= 0;
                        i--)
                      VehicleCard(
                        onTapHandler: () {
                          Get.toNamed(AppRoutes.selectMakeScreen,
                              arguments: homeController
                                  .selectVehicleCategoryModel?.data?[i].id);
                        },
                        text: homeController.selectVehicleCategoryModel
                                ?.data?[i].vehicleName ??
                            '',
                        img: homeController.selectVehicleCategoryModel?.data?[i]
                                .vehicleImage ??
                            '',
                        asset: assetImage[i],
                      ),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 38.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.informationScreen);
                        },
                        child: Text('INFORMATION'.capitalize!),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.termsAndCondition);
                        },
                        child: Text('DISCLAIMER'.capitalize!),
                      ),
                    ],
                  ),
                ),
              ],
            );
    });
  }
}
