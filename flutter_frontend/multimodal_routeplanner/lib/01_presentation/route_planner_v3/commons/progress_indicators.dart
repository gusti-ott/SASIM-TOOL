import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';

Widget circularProgressIndicatorWithPadding() {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(smallPadding),
      child: const CircularProgressIndicator(),
    ),
  );
}
