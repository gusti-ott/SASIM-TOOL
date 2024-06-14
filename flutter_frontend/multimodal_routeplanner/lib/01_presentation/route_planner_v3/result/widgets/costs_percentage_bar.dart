import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_color.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

Widget costsPercentageBar(BuildContext context, {required Trip selectedTrip}) {
  TextTheme textTheme = Theme.of(context).textTheme;

  double externalCostsRate = selectedTrip.costs.externalCosts.all / selectedTrip.costs.getFullcosts();
  int externalCostsPercent = (externalCostsRate * 100).toInt();
  int internalCostsPercent = 100 - externalCostsPercent;

  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    height: 20,
    child: Row(
      children: [
        Expanded(
          flex: externalCostsPercent,
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
                child: Text('${externalCostsPercent.toString()} %',
                    style: textTheme.labelMedium!.copyWith(color: Colors.white)),
              ),
            ),
          ),
        ),
        Expanded(
            flex: internalCostsPercent,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: smallPadding),
                child: Text('${internalCostsPercent.toString()} %', style: textTheme.labelMedium),
              ),
            ))
      ],
    ),
  );
}
