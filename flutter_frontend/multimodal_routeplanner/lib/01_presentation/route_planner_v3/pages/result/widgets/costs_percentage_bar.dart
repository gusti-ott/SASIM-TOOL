import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/colors_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/costs_rates.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

Widget costsPercentageBar(BuildContext context,
    {required Trip selectedTrip, required CostsPercentageBarType barType, double? width, bool isMobile = false}) {
  late Widget costsBar;
  if (barType == CostsPercentageBarType.total) {
    costsBar = totalCostsBar(context, selectedTrip: selectedTrip, isMobile: isMobile);
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

Widget totalCostsBar(BuildContext context, {required Trip selectedTrip, bool isMobile = false}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  AppLocalizations lang = AppLocalizations.of(context)!;

  int externalCostsPercentage = getSocialCostsPercentage(selectedTrip);
  int internalCostsPercentage = 100 - externalCostsPercentage;

  return Column(
    children: [
      Container(
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
      ),
      if (isMobile) ...[
        smallVerticalSpacer,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              lang.social_costs.toUpperCase(),
              style: textTheme.labelLarge,
            ),
            Text(
              lang.personal_costs.toUpperCase(),
              style: textTheme.labelLarge,
            )
          ],
        )
      ]
    ],
  );
}

Widget textRowCostsBar(BuildContext context,
    {required Trip selectedTrip,
    required PercentageTextPosition position,
    required List<PercentageTextPosition> positions,
    required List<int> percentages,
    List<String>? labels}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  double height = 20;
  int percentageLimit = 15;

  if (positions.any((element) => element == position)) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...positions.asMap().entries.map((entry) {
            String label = '';
            int index = entry.key;
            int flex = positions[index] != position
                ? 1
                : percentages[index] < percentageLimit
                    ? percentageLimit
                    : percentages[index];

            if (labels != null && labels.length >= index + 1) {
              label = ' ${labels[index]}'.toUpperCase();
            }
            return Expanded(
              // if 1% then flex 2, because 1% is too small for whole text
              flex: flex,
              child: positions[index] == position
                  ? Text('${percentages[index].toString()} %$label',
                      style: textTheme.labelMedium,
                      textAlign: index + 1 == positions.length ? TextAlign.right : TextAlign.left)
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
  AppLocalizations lang = AppLocalizations.of(context)!;

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
          percentages: percentages,
          labels: [lang.time, lang.health, lang.environment]),
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
          percentages: percentages,
          labels: [lang.time, lang.health, lang.environment]),
    ],
  );
}

Widget privateCostsBar(BuildContext context, {required Trip selectedTrip}) {
  AppLocalizations lang = AppLocalizations.of(context)!;

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
          percentages: percentages,
          labels: [lang.fixed, lang.variable]),
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
          percentages: percentages,
          labels: [lang.fixed, lang.variable]),
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
