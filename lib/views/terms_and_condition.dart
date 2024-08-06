import 'package:bridge_stone_tyre/controller/homepage_controller.dart';
import 'package:bridge_stone_tyre/network/homepage_network.dart';
import 'package:bridge_stone_tyre/routes/routes.dart';
import 'package:bridge_stone_tyre/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../controller/network_controller.dart';

class TermsAndCondition extends StatefulWidget {
  TermsAndCondition({super.key});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeNetwork.termsAndCondition();
    // networkController.initCheck();

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
            ? homeController.buildAppBar(title: 'Terms & Conditions')
            : null,
        body: Obx(
          () => (isInternet == false && homeController.termsAndCondition.value.isEmpty)
              ? const Center(child: Text('No Internet'))
              : homeController.termsAndCondition.value.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Html(
                              data: homeController.termsAndCondition.value.trim(),
                              style: {
                                "p": Style(textAlign: TextAlign.center,padding: HtmlPaddings(blockStart: HtmlPadding(0))),
                              },
                            ),
                          ),
                          const Spacer(),
                          if(homeController.isFirstTime.isTrue)
                          TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.country);
                            },
                            child: const Text(
                              'Accept Terms And Conditions',
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
