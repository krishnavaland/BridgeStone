import 'package:bridge_stone_tyre/network/homepage_network.dart';
import 'package:bridge_stone_tyre/routes/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../boxes.dart';
import '../constant/string_constants.dart';
import '../controller/homepage_controller.dart';
import '../controller/network_controller.dart';
import '../utils.dart';
import '../widgets/custom_tile.dart';

class SelectModelScreen extends StatefulWidget {
  const SelectModelScreen({super.key});

  @override
  State<SelectModelScreen> createState() => _SelectModelScreenState();
}

class _SelectModelScreenState extends State<SelectModelScreen> {
  final homeNetwork = HomepageNetwork();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeNetwork
        .getVehicleModelName(
            // arg
            from: 'screen')
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
              .getVehicleModelName(
                  // arg
                  )
              .then((value) {
            isLoaded.value = true;
          });
        }
      });

  @override
  Widget build(BuildContext context) {
    // homeController.selectModelByIdModel =
    //     Boxes.selectModelByIdModel().get('vehicleModels') ?? {};

    return Scaffold(
      appBar: homeController.buildAppBar(),
      body: FutureBuilder<bool>(
        future: Utils.checkInternetConnectivity(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If you have locally saved data, show it
            if (homeController.selectModelByIdModel.isNotEmpty) {
              return buildSelectModelScreen();
            } else {
              // Otherwise, show a loading indicator
              return const Center(child: CircularProgressIndicator());
            }
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred.'));
          } else if (!snapshot.data &&
              (homeController.selectModelByIdModel.isEmpty ||
                  homeController.selectModelByIdModel[arg] == null)) {
            print('model scrn4${homeController.selectModelByIdModel[arg]}');
            // No internet connection
            return const Center(child: Text('No internet connection.'));
          } else {
            // Internet connection is available, render your content
            return buildSelectModelScreen();
          }
        },
      ),
      // floatingActionButton: homeController.floatingActionButton(() async {
      //   await networkStatus;
      //   setState(() {});
      // }),
    );
  }

  Obx buildSelectModelScreen() {
    return Obx(() =>
        (isLoaded.isFalse && homeController.selectModelByIdModel[arg] == null)
            ? const Center(child: CircularProgressIndicator())
            : (homeController.selectModelByIdModel[arg].isEmpty)
                ? const Center(child: Text('No Data Found'))
                : SingleChildScrollView(
                    child: Center(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTile(
                            text: 'Select Model',
                            img: img6,
                          ),
                          if (homeController.selectModelByIdModel[arg] != null)
                            for (var item
                                in homeController.selectModelByIdModel[arg])
                              CustomTile(
                                text: item.modelName ?? '',
                                iconData: Icons.arrow_forward_ios_sharp,
                                onTapHandler: () {
                                  Get.toNamed(
                                    AppRoutes.wheelType,
                                    arguments: item.id,
                                  );
                                },
                              ),
                        ],
                      ),
                    ),
                  ));
  }
}
