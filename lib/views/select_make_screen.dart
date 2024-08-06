import 'package:bridge_stone_tyre/routes/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../boxes.dart';
import '../controller/homepage_controller.dart';
import '../controller/network_controller.dart';
import '../network/homepage_network.dart';
import '../utils.dart';
import '../widgets/custom_tile.dart';

class SelectMakeScreen extends StatefulWidget {
  SelectMakeScreen({super.key});

  @override
  State<SelectMakeScreen> createState() => _SelectMakeScreenState();
}

class _SelectMakeScreenState extends State<SelectMakeScreen> {
  final homeNetwork = HomepageNetwork();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeNetwork
        .getSelectMakeModelName(
      // vehicleId: args
      from: 'screen',
    )
        .then((value) {
      isLoaded.value = true;
    });
  }

  final args = Get.arguments.toString();
  final homeController = Get.find<HomepageController>();
  final networkController = Get.find<NetworkController>();
  RxBool isLoaded = false.obs;

  get networkStatus => networkController.connectivityStream().listen((event) {
        print('event+++$event');
        if (event != ConnectivityResult.none) {
          isLoaded.value = false;
          homeNetwork
              .getSelectMakeModelName(
                  // vehicleId: args

                  )
              .then((value) {
            isLoaded.value = true;
          });
        }
      });

  @override
  Widget build(BuildContext context) {
    homeController.selectMakeModel = Boxes.getMakeData().get('makeData') ?? {};
    return Scaffold(
      appBar: homeController.buildAppBar(),
      body: FutureBuilder<bool>(
        future: Utils.checkInternetConnectivity(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If you have locally saved data, show it
            if (homeController.selectMakeModel.isNotEmpty) {
              return buildSelectMake();
            } else {
              // Otherwise, show a loading indicator
              return const Center(child: CircularProgressIndicator());
            }
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred.'));
          } else if (!snapshot.data &&
              (homeController.selectMakeModel.isEmpty ||
                  homeController.selectMakeModel[args] == null)) {
            // No internet connection
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: TextButton(
                    child: Text('No internet connection.'),
                    onPressed: () async {
                      await networkStatus;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ));
          } else {
            // Internet connection is available, render your content
            return buildSelectMake();
          }
        },
      ),
      // floatingActionButton: homeController.floatingActionButton(() async{
      //   await networkStatus;
      //   setState(() {});
      // }),
    );
  }

  Obx buildSelectMake() {
    return Obx(
        () => (isLoaded.isFalse && homeController.selectMakeModel[args] == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTile(
                      text: 'Select Make',
                      img: 'assets/icons/Image 13@3x.png',
                    ),
                    if (homeController.selectMakeModel[args] != null)
                      for (var item in homeController.selectMakeModel[args])
                        CustomTile(
                          text: item.makeName ?? '',
                          iconData: Icons.arrow_forward_ios_sharp,
                          onTapHandler: () {
                            Get.toNamed(AppRoutes.modelScreen,
                                arguments: item.id);
                          },
                        ),
                  ],
                ),
              ));
  }
}
