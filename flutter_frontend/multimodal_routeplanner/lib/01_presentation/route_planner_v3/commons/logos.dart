import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/commons/mcube_logo.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Widget mobiScoreWithMcubeLogo(BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Row(
    children: [
      Image.asset('assets/mobiscore_logos/logo_with_text_primary.png', width: 70),
      smallHorizontalSpacer,
      Text('by', style: textTheme.labelLarge!.copyWith(color: primaryColorV3)),
      smallHorizontalSpacer,
      mcubeLogo(),
    ],
  );
}
