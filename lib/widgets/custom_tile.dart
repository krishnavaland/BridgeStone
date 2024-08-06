import 'package:flutter/material.dart';

import '../constant/theme_constant.dart';

class CustomTile extends StatelessWidget {
  CustomTile(
      {Key? key,
      required this.text,
      this.img,
      this.onTapHandler,
      this.iconData})
      : super(key: key);

  final String text;
  String? img;
  IconData? iconData;
  final Function()? onTapHandler;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapHandler,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text.toUpperCase().trim(),
                style: const TextStyle(color: textColor),
              ),
            ),
            if (img == null && iconData != null) Icon(iconData),
            if (img != null)
              Image.asset(
                img!,
                height: 30,
              ),
          ],
        ),
      ),
    );
  }
}
