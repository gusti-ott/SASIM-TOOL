import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/colors_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/costs_rates.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

Widget costsPercentageBar(BuildContext context,
    {required Trip selectedTrip, required CostsPercentageBarType barType, double? width}) {
  late Widget costsBar;
  if (barType == CostsPercentageBarType.total) {
    costsBar = totalCostsBar(context, selectedTrip: selectedTrip);
  } else if (barType == CostsPercentageBarType.social) {
    costsBar = socialCostsBar(context, selectedTrip: selectedTrip);
  } else {
    costsBar = privateCostsBar(context, selectedTrip: selectedTrip);
  }
  return SizedBox(
    width: width,
    child: costsBar,
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

Widget textRowCostsBar(BuildContext context,
    {required Trip selectedTrip,
    required PercentageTextPosition position,
    required List<PercentageTextPosition> positions,
    required List<int> percentages}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  double height = 20;

  if (positions.any((element) => element == position)) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...positions.asMap().entries.map((entry) {
            int index = entry.key;
            return Expanded(
              // if 1% then flex 2, because 1% is too small for whole text
              flex: percentages[index] == 1 ? 2 : percentages[index],
              child: positions[index] == position
                  ? Text(
                      '${percentages[index].toString()} %',
                      style: textTheme.labelMedium,
                    )
                  : const SizedBox(),
            );
          }).toList(),
        ],
      ),
    );
  } else {
    return SizedBox(height: height);
  }
}

Widget socialCostsBar(BuildContext context, {required Trip selectedTrip}) {
  int timeCostsPercentage = getSocialTimeCostsPercentage(selectedTrip);
  int healthCostsPercentage = getSocialHealthCostsPercentage(selectedTrip);
  int environmentCostsPercentage = getSocialEnvironmentalCostsPercentage(selectedTrip);

  List<int> percentages = [timeCostsPercentage, healthCostsPercentage, environmentCostsPercentage];
  List<PercentageTextPosition> positions = getPercentageTextPositions(percentages);

  return Column(
    children: [
      textRowCostsBar(context,
          selectedTrip: selectedTrip,
          position: PercentageTextPosition.above,
          positions: positions,
          percentages: percentages),
      Container(
        decoration: BoxDecoration(
          color: getColorFromMobiScore(selectedTrip.mobiScore).lighten(0.4),
        ),
        height: 20,
        child: Row(
          children: [
            Expanded(
              flex: timeCostsPercentage + healthCostsPercentage,
              child: Container(
                  decoration: BoxDecoration(
                    color: getColorFromMobiScore(selectedTrip.mobiScore).lighten(0.2),
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
                            color: getColorFromMobiScore(selectedTrip.mobiScore),
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
      textRowCostsBar(context,
          selectedTrip: selectedTrip,
          position: PercentageTextPosition.below,
          positions: positions,
          percentages: percentages),
    ],
  );
}

Widget privateCostsBar(BuildContext context, {required Trip selectedTrip}) {
  int fixedCosts = getPrivateFixedCostsPercentage(selectedTrip);
  int variableCosts = getPrivateVariableCostsPercentage(selectedTrip);

  List<int> percentages = [fixedCosts, variableCosts];
  List<PercentageTextPosition> positions = getPercentageTextPositions(percentages);

  return Column(
    children: [
      textRowCostsBar(context,
          selectedTrip: selectedTrip,
          position: PercentageTextPosition.above,
          positions: positions,
          percentages: percentages),
      Container(
        decoration: BoxDecoration(
          color: customLightGrey.lighten(0.4),
        ),
        height: 20,
        child: Row(
          children: [
            Expanded(
              flex: fixedCosts,
              child: Container(
                decoration: BoxDecoration(
                  color: customLightGrey,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                height: 20,
              ),
            ),
            Expanded(flex: variableCosts, child: const SizedBox()),
          ],
        ),
      ),
      textRowCostsBar(context,
          selectedTrip: selectedTrip,
          position: PercentageTextPosition.below,
          positions: positions,
          percentages: percentages),
    ],
  );
}

List<PercentageTextPosition> getPercentageTextPositions(List<int> percentages) {
  int length = percentages.length;
  List<PercentageTextPosition> positions = List.filled(length, PercentageTextPosition.above);
  if (percentages.length > 1 && (percentages[0] < 10 || percentages[0] >= 10 && percentages[1] < 10)) {
    positions[1] = PercentageTextPosition.below;
  }

  if (percentages.length >= 2 && (percentages[0] >= 10 && percentages[1] < 10)) {
    positions[1] = PercentageTextPosition.below;
  }

  if (percentages.length >= 3 && (positions[1] == PercentageTextPosition.above && percentages[2] < 10)) {
    positions[2] = PercentageTextPosition.below;
  }

  return positions;
}

enum CostsPercentageBarType { total, social, personal }

enum PercentageTextPosition { below, above }
