import 'package:bridge_stone_tyre/boxes.dart';
import 'package:bridge_stone_tyre/network/homepage_network.dart';
import 'package:bridge_stone_tyre/routes/routes.dart';
import 'package:bridge_stone_tyre/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/string_constants.dart';
import '../controller/homepage_controller.dart';
import '../controller/network_controller.dart';
import '../widgets/custom_tile.dart';
import 'package:get/get.dart';

class SelectCountry extends StatefulWidget {
  const SelectCountry({super.key});

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (homeController.getCountryListModel == null) {
      homeNetwork.getCountryList().then((value) {
        isLoaded.value = true;
      });
    }
  }

  RxBool isLoaded = false.obs;

  final homeController = Get.find<HomepageController>();
  final homeNetwork = HomepageNetwork();
  final networkController = Get.find<NetworkController>();

  get networkStatus => networkController.connectivityStream().listen((event) {
        print('event+++1$event');
        if (event != ConnectivityResult.none) {
          isLoaded.value = false;
          if (homeController.getCountryListModel == null) {
            homeNetwork.getCountryList().then((value) {
              isLoaded.value = true;
            });
          }
        }
      });

  @override
  Widget build(BuildContext context) {
    networkStatus;
    homeController.getCountryListModel =
        Boxes.getCountryList().get('getCountry');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(kHomeTitle),
        ),
        body: FutureBuilder<bool>(
          future: Utils.checkInternetConnectivity(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // If you have locally saved data, show it
              if (homeController.getCountryListModel != null) {
                return buildSelectCountry();
              } else {
                // Otherwise, show a loading indicator
                return const Center(child: CircularProgressIndicator());
              }
            } else if (snapshot.hasError) {
              return const Center(child: Text('An error occurred.'));
            } else if (!snapshot.data &&
                homeController.getCountryListModel == null) {
              // No internet connection
              return const Center(child: Text('No internet connection.'));
            } else {
              // Internet connection is available, render your content
              return buildSelectCountry();
            }
          },
        ),
      ),
    );
  }

  Obx buildSelectCountry() {
    return Obx(
        () => (isLoaded.isFalse && homeController.getCountryListModel == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTile(
                      text: 'Select Country',
                      img: 'assets/icons/Image 13@3x.png',
                    ),
                    if (homeController.getCountryListModel?.data != null)
                      for (var item
                          in homeController.getCountryListModel!.data!.reversed)
                        CustomTile(
                          text: item.countryName ?? '',
                          onTapHandler: () async {
                            final pref = await SharedPreferences.getInstance();
                            bool isFirst =
                                pref.getBool('isFirstLaunch') ?? true;
                            pref.setString('country', item.countryName ?? '');
                            homeController.selectedCountry.value =
                                item.countryName ?? '';
                            if (isFirst) {
                              homeController.isFirstTime.value = false;
                              pref.setBool('isFirstLaunch', false);
                              Get.offAllNamed(AppRoutes.home);
                            } else {
                              Get.back();
                            }
                          },
                        ),
                  ],
                ),
              ));
  }
}
