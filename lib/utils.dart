import 'dart:io';

import 'package:bridge_stone_tyre/controller/homepage_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utils {
  static void showNoInternetSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('No Internet Connection'),
      backgroundColor: Colors.blueGrey,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false; // No internet connection
    } else {
      return true; // Internet connection is available
    }
  }

  static getDeviceInfo() async {
    final home = Get.find<HomepageController>();
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      home.deviceModel = androidInfo.model;
      home.deviceVersion = androidInfo.version.release;
      home.deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      home.deviceModel = "${iosInfo.model}-${iosInfo.utsname.machine}";
      home.deviceVersion = iosInfo.systemVersion;
    }
    print('home.deviceModel++${home.deviceModel}');
    print('home.deviceVersion++${home.deviceVersion}');
    print('home.deviceId++${home.deviceId}');
  }

  static showToast({String? message}) {
    Fluttertoast.showToast(
      msg: message ?? 'Something Went Wrong',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromRGBO(32, 41, 71, 1),
      textColor: Colors.white,
      fontSize: 12,
    );
  }
}
