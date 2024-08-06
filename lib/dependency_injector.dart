import 'package:bridge_stone_tyre/controller/network_controller.dart';
import 'package:get/get.dart';

import 'controller/homepage_controller.dart';

class DependencyInjector {
  static initializeController() async {
    Get.put<HomepageController>(HomepageController(), permanent: true);
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
