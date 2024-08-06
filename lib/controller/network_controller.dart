import 'dart:async';

import 'package:bridge_stone_tyre/constant/theme_constant.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? connectivitySubscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('networkCOntroller++3');
  }

  initCheck() {
    connectivitySubscription = connectivityStream().listen(
      (ConnectivityResult connectivityResult) {
        print('networkCOntroller++4$connectivityResult');

        if (connectivityResult == ConnectivityResult.none) {
          // Get.rawSnackbar(
          //   messageText: const Text(
          //     'PLEASE CONNECT TO THE INTERNET',
          //     style: TextStyle(color: secondaryColor),
          //   ),
          //   isDismissible: false,
          //   duration: const Duration(days: 1),
          //   icon: const Icon(
          //     Icons.wifi_off,
          //     color: secondaryColor,
          //   ),
          //   backgroundColor: primaryColor,
          //   snackStyle: SnackStyle.FLOATING,
          //   margin: const EdgeInsets.only(top : 56.0),
          // );
        } else {
          if (Get.isSnackbarOpen) {
            Get.closeCurrentSnackbar();
          }
        }
      },
    );
  }

  Stream<ConnectivityResult> connectivityStream() async* {
    final Connectivity connectivity = Connectivity();
    ConnectivityResult previousResult = await connectivity.checkConnectivity();
    yield previousResult;
    await for (final ConnectivityResult result
        in connectivity.onConnectivityChanged) {
      if (result != previousResult) {
        yield result;
        previousResult = result;
      }
    }
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    print('networkCOntroller++2');
    if (connectivityResult == ConnectivityResult.none) {
      print('networkCOntroller++1');
      Get.rawSnackbar(
        messageText: const Text(
          'PLEASE CONNECT TO THE INTERNET',
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        icon: const Icon(Icons.wifi_off),
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
