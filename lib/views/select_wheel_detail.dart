import 'package:auto_size_text/auto_size_text.dart';
import 'package:bridge_stone_tyre/network/homepage_network.dart';
import 'package:bridge_stone_tyre/routes/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../boxes.dart';
import '../constant/theme_constant.dart';
import '../controller/homepage_controller.dart';
import '../controller/network_controller.dart';
import '../utils.dart';

class SelectWheelDetailScreen extends StatefulWidget {
  const SelectWheelDetailScreen({super.key});

  @override
  State<SelectWheelDetailScreen> createState() =>
      _SelectWheelDetailScreenState();
}

class _SelectWheelDetailScreenState extends State<SelectWheelDetailScreen> {
  final homeNetwork = HomepageNetwork();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeNetwork
        .getWheelDetails(
            // wheelTypeId: arg['id'].toString()
            from: 'screen')
        .then((value) {
      isLoaded.value = true;
      setState(() {});
    });
  }

  final arg = Get.arguments;
  RxBool isLoaded = false.obs;
  final homeController = Get.find<HomepageController>();
  final networkController = Get.find<NetworkController>();
  bool runOnce = true;

  get networkStatus =>
      networkController.connectivityStream().listen((event) async {
        print('event+++111123$event');
        if (event != ConnectivityResult.none && runOnce) {
          await homeNetwork
              .getWheelDetails(
            // wheelTypeId: arg['id'].toString()
          )
              .then((value) {
            isLoaded.value = true;
          });
          setState(() {
            runOnce = false;
          });
        } else {
          homeController.isFavTextLoading.value = false;
        }
      });
  RxBool isFav = true.obs;
  RxBool _expanded = true.obs;



  @override
  Widget build(BuildContext context) {
    homeController.selectWheelDetail =
        Boxes.getWheelTypeDetail().get('wheelTypeDetail') ?? {};
    final argId = arg['id'].toString();

    return Scaffold(
      appBar: homeController.buildAppBarFav(
          argId,
          (homeController.selectWheelDetail[argId] != null &&
                  homeController.selectWheelDetail[argId].favouriteStatus ==
                      'active')
              ? isFav
              : false.obs,
          argId),
      body: FutureBuilder<bool>(
        future: Utils.checkInternetConnectivity(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If you have locally saved data, show it
            if (homeController.selectWheelDetail.isNotEmpty) {
              return buildWheelDetail(argId);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred.'));
          } else if (!snapshot.data &&
              (homeController.selectWheelDetail.isEmpty ||
                  homeController.selectWheelDetail[argId] == null)) {
            // No internet connection
            return const Center(child: Text('No internet connection.'));
          } else {
            print('ye render');
            // Internet connection is available, render your content
            return buildWheelDetail(argId);
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 8.0),
          //   child: homeController.floatingActionButton(padding: 0, () async {
          //     await networkStatus;
          //   }),
          // ),
          if (homeController.selectWheelDetail[argId] != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (homeController.selectWheelDetail[argId] != null)
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          homeController.selectWheelDetail[argId]
                                  .checkDetailsDescription ??
                              'Check Daily.',
                          maxLines: 3,
                          // overflow: TextOverflow.ellipsis,
                        )),
                  ),
                if (homeController
                        .selectWheelDetail[argId].checkDetailsDescription
                        .toString()
                        .split(" ")
                        .length >
                    20)
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.viewMoreText, arguments: {
                        'moreText': homeController
                            .selectWheelDetail[argId].checkDetailsDescription
                      });
                    },
                    child: Text(
                      'More',
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Obx buildWheelDetail(argId) {
    return Obx(() {
      if (isLoaded.isFalse && homeController.selectWheelDetail[argId] == null) {
        return const Center(child: CircularProgressIndicator());
      } else {
        var wheel = homeController.selectWheelDetail[argId];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: AutoSizeText(
                  '${wheel.makeMaster.makeName} - ${wheel.modelId.modelName}\n${wheel.wheelTypeName.trim()}\n${wheel.description ?? ''}.',
                  // 'Wheel Type\nSteel disc, 8 stud spigot (hub) mounted\nDO NOT LUBRICATE Clean, dry threads.',
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    (homeController.nmCheck.isFalse)
                        ? (wheel.torque ?? wheel.torqueNm)
                        : (wheel.torqueNm ?? wheel.torque),
                    style: const TextStyle(color: primaryColor, fontSize: 32),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.viewFullScreen,
                        arguments: {
                          "img": wheel.wheelTypeIMG,
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SvgPicture.asset('assets/icons/Group 13.svg'),
                    ),
                  )),
              Row(
                children: [
                  if (wheel.wheelTypeIMG != null)
                    Expanded(
                        child: SvgPicture.network(
                      wheel.wheelTypeIMG,
                      height: MediaQuery.of(context).size.height / 2.5,
                    )),
                  if (wheel.wheelTypeIMG == null || wheel.wheelTypeIMG.isEmpty)
                    Expanded(
                        child: SvgPicture.asset(
                      'assets/images/Group 11.svg',
                      height: MediaQuery.of(context).size.height / 2.5,
                    )),
                ],
              )
            ],
          ),
        );
      }
    });
  }
}
