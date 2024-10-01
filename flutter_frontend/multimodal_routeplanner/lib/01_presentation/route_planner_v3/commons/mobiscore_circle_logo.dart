import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

double infoIconPadding = 8;

Widget mobiScoreCircleLogo({required double size, required Function() onTap, bool showInfoIcon = false}) {
  double radius = showInfoIcon ? size + infoIconPadding : size;
  return SizedBox(
    width: radius,
    height: radius,
    child: Stack(
      children: [
        Center(
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              color: customMobiScoreIconWhite,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 6,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(smallPadding / 1.7),
              child: InkWell(
                onTap: onTap,
                child: Image.asset(
                  'assets/mobiscore_logos/logo_primary.png',
                  fit: BoxFit.contain,
                  height: size,
                ),
              ),
            ),
          ),
        ),
        if (showInfoIcon)
          Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  Icons.info,
                  color: primaryColorV3,
                  size: 20,
                ),
                onPressed: onTap,
              ))
      ],
    ),
  );
}
