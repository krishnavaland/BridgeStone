import 'package:bridge_stone_tyre/routes/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../controller/homepage_controller.dart';
import '../controller/network_controller.dart';
import '../network/homepage_network.dart';
import '../utils.dart';
import '../widgets/custom_tile.dart';
import 'package:get/get.dart';

class MyFavouriteScreen extends StatefulWidget {
  const MyFavouriteScreen({super.key});

  @override
  State<MyFavouriteScreen> createState() => _MyFavouriteScreenState();
}

class _MyFavouriteScreenState extends State<MyFavouriteScreen> {
  final homeController = Get.find<HomepageController>();
  final homeNetwork = HomepageNetwork();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  RxBool isLoaded = false.obs;
  final networkController = Get.find<NetworkController>();

  get networkStatus => networkController.connectivityStream().listen((event) {
        print('event+++1$event');
        if (event != ConnectivityResult.none) {
          isLoaded.value = false;
          homeNetwork
              .getFavorites(deviceId: homeController.deviceId)
              .then((value) {
            isLoaded.value = true;
          });
        }
      });

  @override
  Widget build(BuildContext context) {
    networkStatus;
    print(homeController.getFavouriteModel?.data);
    return Scaffold(
      appBar: homeController.buildAppBar(),
      body: FutureBuilder<bool>(
        future: Utils.checkInternetConnectivity(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If you have locally saved data, show it
            if (homeController.getFavouriteModel != null) {
              return buildGetFavorite();
            } else {
              // Otherwise, show a loading indicator
              return const Center(child: CircularProgressIndicator());
            }
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred.'));
          } else if (!snapshot.data &&
              homeController.getFavouriteModel == null) {
            // No internet connection
            return const Center(child: Text('No internet connection.'));
          } else {
            // Internet connection is available, render your content
            return buildGetFavorite();
          }
        },
      ),
    );
  }

  Obx buildGetFavorite() {
    return Obx(
        () => (isLoaded.isFalse && homeController.getFavouriteModel == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTile(
                      text: 'My Favorites',
                      img: 'assets/icons/Image 13@3x.png',
                    ),
                    if (homeController.getFavouriteModel?.data != null)
                      for (var item in homeController.getFavouriteModel!.data!)
                        CustomTile(
                          text: item.wheelData?.wheelTypeName ?? '',
                          iconData: Icons.arrow_forward_ios_sharp,
                          onTapHandler: () {
                            Get.toNamed(
                              AppRoutes.selectWheelDetail,
                              arguments: {
                                "id": item.wheelData?.id,
                              },
                            )?.then((value) async {
                              await homeNetwork.getFavorites(
                                  deviceId: homeController.deviceId);
                              setState(() {});
                            });
                          },
                        ),
                  ],
                ),
              ));
  }
}
