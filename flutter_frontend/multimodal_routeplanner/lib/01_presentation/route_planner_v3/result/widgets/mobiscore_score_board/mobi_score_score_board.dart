import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

double widthScoreColumn = 40;
double heightScoreColumn = 400;
double borderWidthScoreColumn = 6;

Widget mobiScoreScoreBoard(BuildContext context, {required Trip selectedTrip}) {
  TextTheme textTheme = Theme.of(context).textTheme;

  return Container(
    decoration: BoxDecoration(
      color: backgroundColorV3,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white, width: borderWidthScoreColumn),
    ),
    width: widthScoreColumn,
    height: heightScoreColumn,
    child: Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: (selectedTrip.mobiScore == 'A') ? colorA : backgroundColorV3,
            ),
            child: Center(
              child: Text(
                'A',
                style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Expanded(
            child: Container(
                color: (selectedTrip.mobiScore == 'B') ? colorB : backgroundColorV3,
                child: Center(
                  child: Text(
                    'B',
                    style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ))),
        Expanded(
            child: Container(
                color: (selectedTrip.mobiScore == 'C') ? colorC : backgroundColorV3,
                child: Center(
                  child: Text(
                    'C',
                    style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ))),
        Expanded(
            child: Container(
                color: (selectedTrip.mobiScore == 'D') ? colorD : backgroundColorV3,
                child: Center(
                  child: Text(
                    'D',
                    style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ))),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: (selectedTrip.mobiScore == 'E') ? colorE : backgroundColorV3,
            ),
            child: Center(
              child: Text(
                'E',
                style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
