import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/colors_helper.dart';

BoxDecoration customBoxDecorationWithShadow({Color? backgroundColor}) {
  return BoxDecoration(
    color: backgroundColor?.lighten(0.5) ?? Colors.white,
    borderRadius: BorderRadius.circular(30.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  );
}
