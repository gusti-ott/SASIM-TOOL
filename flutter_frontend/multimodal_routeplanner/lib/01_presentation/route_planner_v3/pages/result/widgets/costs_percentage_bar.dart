import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/colors_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/costs_rates.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

Widget costsPercentageBar(BuildContext context,
    {required Trip selectedTrip, required CostsPercentageBarType barType, double? width}) {
  return SizedBox(
    width: width,
    child: Column(
      children: [
        (barType == CostsPercentageBarType.total)
            ? totalCostsBar(context, selectedTrip: selectedTrip)
            : socialCostsBar(context, selectedTrip: selectedTrip),
      ],
    ),
  );
}

Widget totalCostsBar(BuildContext context, {required Trip selectedTrip}) {
  TextTheme textTheme = Theme.of(context).textTheme;

  int externalCostsPercentage = getSocialCostsPercentage(selectedTrip);
  int internalCostsPercentage = 100 - externalCostsPercentage;

  return Container(
    decoration: const BoxDecoration(color: Colors.white),
    height: 20,
    child: Row(children: [
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
    ]),
  );
}

Widget textRow(BuildContext context,
    {required Trip selectedTrip,
    required PercentageTextPosition position,
    required List<PercentageTextPosition> positions}) {
  TextTheme textTheme = Theme.of(context).textTheme;

  int timeCostsPercentage = getSocialTimeCostsPercentage(selectedTrip);
  int healthCostsPercentage = getSocialHealthCostsPercentage(selectedTrip);
  int environmentCostsPercentage = getSocialEnvironmentalCostsPercentage(selectedTrip);
  return Row(
    children: [
      Expanded(
          flex: timeCostsPercentage,
          child: positions[0] == position
              ? Text(
                  '${timeCostsPercentage.toString()} %',
                  style: textTheme.labelMedium,
                )
              : const SizedBox()),
      Expanded(
          flex: healthCostsPercentage,
          child: positions[1] == position
              ? Text(
                  '${healthCostsPercentage.toString()} %',
                  style: textTheme.labelMedium,
                )
              : const SizedBox()),
      Expanded(
          flex: environmentCostsPercentage,
          child: positions[2] == position
              ? Text(
                  '${environmentCostsPercentage.toString()} %',
                  style: textTheme.labelMedium,
                )
              : const SizedBox()),
    ],
  );
}

Widget socialCostsBar(BuildContext context, {required Trip selectedTrip}) {
  int timeCostsPercentage = getSocialTimeCostsPercentage(selectedTrip);
  int healthCostsPercentage = getSocialHealthCostsPercentage(selectedTrip);
  int environmentCostsPercentage = getSocialEnvironmentalCostsPercentage(selectedTrip);

  List<int> percentages = [timeCostsPercentage, healthCostsPercentage, environmentCostsPercentage];
  List<PercentageTextPosition> positions = getPercentageTextPositions(percentages);

  return Column(
    children: [
      if (positions.any((element) => element == PercentageTextPosition.above))
        textRow(context, selectedTrip: selectedTrip, position: PercentageTextPosition.above, positions: positions),
      Container(
        decoration: BoxDecoration(
          color: getColorFromMobiScore(selectedTrip.mobiScore),
        ),
        height: 20,
        child: Row(
          children: [
            Expanded(
              flex: timeCostsPercentage + healthCostsPercentage,
              child: Container(
                  decoration: BoxDecoration(
                    color: getColorFromMobiScore(selectedTrip.mobiScore).lighten(0.4),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  height: 20,
                  child: Row(
                    children: [
                      Expanded(
                        flex: timeCostsPercentage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: getColorFromMobiScore(selectedTrip.mobiScore).lighten(0.2),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          height: 20,
                        ),
                      ),
                      Expanded(
                        flex: healthCostsPercentage,
                        child: const SizedBox(),
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: environmentCostsPercentage,
              child: const SizedBox(),
            )
          ],
        ),
      ),
      if (positions.any((element) => element == PercentageTextPosition.below))
        textRow(context, selectedTrip: selectedTrip, position: PercentageTextPosition.below, positions: positions),
    ],
  );
}

List<PercentageTextPosition> getPercentageTextPositions(List<int> percentages) {
  List<PercentageTextPosition> positions = [
    PercentageTextPosition.above,
    PercentageTextPosition.above,
    PercentageTextPosition.above
  ];
  if (percentages.isNotEmpty && (percentages[0] < 10 || percentages[0] >= 10 && percentages[1] < 10)) {
    positions[1] = PercentageTextPosition.below;
  }

  if (percentages.isNotEmpty && (percentages[0] >= 10 && percentages[1] < 10)) {
    positions[1] = PercentageTextPosition.below;
  }

  if (percentages.isNotEmpty && (positions[1] == PercentageTextPosition.above && percentages[2] < 10)) {
    positions[2] = PercentageTextPosition.below;
  }

  return positions;
}

enum CostsPercentageBarType { total, social, personal }

enum PercentageTextPosition { below, above }
