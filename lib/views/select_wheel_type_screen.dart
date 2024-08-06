import 'package:bridge_stone_tyre/boxes.dart';
import 'package:bridge_stone_tyre/network/homepage_network.dart';
import 'package:bridge_stone_tyre/routes/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/string_constants.dart';
import '../controller/homepage_controller.dart';
import '../controller/network_controller.dart';
import '../utils.dart';
import '../widgets/custom_tile.dart';

class SelectWheelTypeScreen extends StatefulWidget {
  const SelectWheelTypeScreen({super.key});

  @override
  State<SelectWheelTypeScreen> createState() => _SelectWheelTypeScreenState();
}

class _SelectWheelTypeScreenState extends State<SelectWheelTypeScreen> {
  final homeNetwork = HomepageNetwork();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    homeNetwork
        .getSelectWheelType(
            // arg
            )
        .then((value) {
      isLoaded.value = true;
    });
  }

  final arg = Get.arguments.toString();
  RxBool isLoaded = false.obs;
  final homeController = Get.find<HomepageController>();
  final networkController = Get.find<NetworkController>();

  get networkStatus => networkController.connectivityStream().listen((event) {
        print('event+++1$event');
        if (event != ConnectivityResult.none) {
          isLoaded.value = false;
          homeNetwork
              .getSelectWheelType(
                  // arg
                  )
              .then((value) {
            isLoaded.value = true;
          });
        }
      });

  @override
  Widget build(BuildContext context) {
    homeController.selectWheelTypeModel =
        Boxes.selectWheelType().get('wheelType') ?? {};
    return Scaffold(
      appBar: homeController.buildAppBar(),
      body: FutureBuilder<bool>(
        future: Utils.checkInternetConnectivity(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If you have locally saved data, show it
            if (homeController.selectWheelTypeModel.isNotEmpty) {
              return buildWheelTypeScreen();
            } else {
              // Otherwise, show a loading indicator
              return const Center(child: CircularProgressIndicator());
            }
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred.'));
          } else if (!snapshot.data &&
              (homeController.selectWheelTypeModel.isEmpty ||
                  homeController.selectWheelTypeModel[arg] == null)) {
            // No internet connection
            return const Center(child: Text('No internet connection.'));
          } else {
            // Internet connection is available, render your content
            return buildWheelTypeScreen();
          }
        },
      ),
      // floatingActionButton: homeController.floatingActionButton(() async {
      //   await networkStatus;
      //   setState(() {});
      // }),
    );
  }

  Obx buildWheelTypeScreen() {
    return Obx(() =>
        (isLoaded.isFalse && homeController.selectWheelTypeModel[arg] == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTile(
                        text: 'Select Wheel Type',
                        img: img6,
                      ),
                      if (homeController.selectWheelTypeModel[arg] != null &&
                          homeController.selectWheelTypeModel[arg] != null)
                        for (var item
                            in homeController.selectWheelTypeModel[arg]!)
                          CustomTile(
                            text: item.wheelTypeName ?? '',
                            iconData: Icons.arrow_forward_ios_sharp,
                            onTapHandler: () {
                              Get.toNamed(
                                AppRoutes.selectWheelDetail,
                                arguments: {
                                  "id": item.id,
                                },
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ));
  }
}
