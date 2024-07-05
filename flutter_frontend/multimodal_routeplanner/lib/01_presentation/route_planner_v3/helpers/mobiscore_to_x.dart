import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/logger.dart';

Logger logger = getLogger();

Color getColorFromMobiScore(String mobiScore, {bool isLight = false}) {
  if (mobiScore == 'A') {
    return isLight ? lightColorA : colorA;
  }
  if (mobiScore == 'B') {
    return isLight ? lightColorB : colorB;
  }
  if (mobiScore == 'C') {
    return isLight ? lightColorC : colorC;
  }
  if (mobiScore == 'D') {
    return isLight ? lightColorD : colorD;
  }
  if (mobiScore == 'E') {
    return isLight ? lightColorE : colorE;
  }
  logger.e('MobiScore not found: $mobiScore. Returned transparent color.');
  return Colors.white;
}

String getAssetPathFromMobiScore(String mobiScore) {
  String path = '';
  if (mobiScore == 'A') {
    path = 'assets/icons/social_A.png';
  } else if (mobiScore == 'B') {
    path = 'assets/icons/social_B.png';
  } else if (mobiScore == 'C') {
    path = 'assets/icons/social_C.png';
  } else if (mobiScore == 'D') {
    path = 'assets/icons/social_D.png';
  } else if (mobiScore == 'E') {
    path = 'assets/icons/social_E.png';
  }
  return path;
}
