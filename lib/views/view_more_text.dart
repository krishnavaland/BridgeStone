import 'package:bridge_stone_tyre/constant/style_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ViewMoreText extends StatelessWidget {
  const ViewMoreText({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = Get.arguments;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Notes'),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 14),

              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Close")),
              const SizedBox(height: 14),
              Center(
                child: Text(
                  arg['moreText'],
                  style: kMediumText,
                  // textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
    );
  }
}
