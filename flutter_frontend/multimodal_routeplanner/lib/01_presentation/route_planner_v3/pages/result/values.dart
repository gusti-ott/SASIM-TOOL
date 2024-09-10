import 'package:flutter/material.dart';

double widthInfoSectionMax = 480;
double widthInfoSectionMin = 400;
double contentMaxWidth = 1000;

double getWidthInfoSection(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  if (width > 1500) {
    return widthInfoSectionMax;
  } else {
    return widthInfoSectionMin;
  }
}
