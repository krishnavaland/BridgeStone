import 'package:bridge_stone_tyre/controller/homepage_controller.dart';
import 'package:bridge_stone_tyre/network/homepage_network.dart';
import 'package:bridge_stone_tyre/routes/routes.dart';
import 'package:bridge_stone_tyre/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../controller/network_controller.dart';

class InformationScreen extends StatefulWidget {
  InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeNetwork.informationData();

    check();
  }

  bool isInternet = true;

  check() async {
    isInternet = await Utils.checkInternetConnectivity();
    setState(() {});
  }

  final homeNetwork = HomepageNetwork();
  final homeController = Get.find<HomepageController>();
  final networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: homeController.isFirstTime.isFalse
            ? homeController.buildAppBar(title: 'Information')
            : null,
        body: Obx(
          () => (isInternet == false && homeController.information.value.isEmpty)
              ? const Center(child: Text('No Internet'))
              : homeController.information.value.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Html(
                              data: homeController.information.value,
                              style: {
                                "p": Style(textAlign: TextAlign.center),
                              },
                            ),
                          ),
                          const Spacer(),

                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
