import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/costs_rates.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_color.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

Widget costsPercentageBar(BuildContext context, {required Trip selectedTrip}) {
  TextTheme textTheme = Theme.of(context).textTheme;

  int externalCostsPercentage = calculateExternalCostsPercantage(selectedTrip);
  int internalCostsPercentage = 100 - externalCostsPercentage;

  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    height: 20,
    child: Row(
      children: [
        Expanded(
          flex: externalCostsPercentage,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: getColorFromMobiScore(selectedTrip.mobiScore),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: smallPadding),
                child: Text('${externalCostsPercentage.toString()} %',
                    style: textTheme.labelMedium!.copyWith(color: Colors.white)),
              ),
            ),
          ),
        ),
        Expanded(
            flex: internalCostsPercentage,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: smallPadding),
                child: Text('${internalCostsPercentage.toString()} %', style: textTheme.labelMedium),
              ),
            ))
      ],
    ),
  );
}
