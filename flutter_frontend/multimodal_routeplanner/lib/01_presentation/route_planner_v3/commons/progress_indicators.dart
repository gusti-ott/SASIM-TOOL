import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';

Widget circularProgressIndicatorWithPadding({Color? color}) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(smallPadding),
      child: CircularProgressIndicator(
        color: color,
      ),
    ),
  );
}
