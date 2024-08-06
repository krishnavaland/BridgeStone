import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constant/style_constant.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    Key? key,
    required this.onTapHandler,
    required this.text,
    required this.img,
    required this.asset,
  }) : super(key: key);

  final Function() onTapHandler;
  final String text;
  final String img;
  final String asset;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 2 - 24;
    return GestureDetector(
      onTap: onTapHandler,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          width: width,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CachedNetworkImage(
                imageUrl: img,
                fit: BoxFit.fitHeight,
                errorWidget: (BuildContext, Object, StackTrace) {
                  return Image.asset(
                    asset,
                    fit: BoxFit.fitHeight,
                  );
                },
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.9),
                        // Dark color with desired opacity
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: AutoSizeText(
                  text,
                  style: kWhiteText,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
