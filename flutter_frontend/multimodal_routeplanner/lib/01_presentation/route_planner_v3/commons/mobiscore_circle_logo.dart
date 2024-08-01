import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Widget mobiScoreCircleLogo({required double size}) {
  return Container(
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
      child: Image.asset(
        'assets/mobiscore_logos/logo_primary.png',
        fit: BoxFit.contain,
        height: size,
      ),
    ),
  );
}
