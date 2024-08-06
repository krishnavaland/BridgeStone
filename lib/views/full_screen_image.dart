import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ViewFullScreen extends StatelessWidget {
  const ViewFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Positioned(
            right: 20,
            top: 30,
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'CLOSE',
              ),
            ),
          ),
          if (arg['img'] != null)
            SvgPicture.network(
              arg['img'],
              width: double.infinity,
            ),
          if (arg['img'] == null)
            SvgPicture.asset(
              "assets/images/Group 11.svg",
              width: double.infinity,
            ),
        ]),
      ),
    );
  }
}
