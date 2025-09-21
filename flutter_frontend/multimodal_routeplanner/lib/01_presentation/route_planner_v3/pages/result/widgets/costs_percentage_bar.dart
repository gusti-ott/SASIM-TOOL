import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
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

  return LayoutBuilder(
    builder: (context, constraints) {
      // Get the available width from the parent container
      double availableWidth = constraints.maxWidth;

      // Calculate the widths for external and internal costs
      double externalCostWidth = availableWidth * (externalCostsPercentage / 100);
      double internalCostWidth = availableWidth * (internalCostsPercentage / 100);

      return Column(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            height: 20,
            child: Row(
              children: [
                // External costs part with AnimatedContainer
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500), // Animation duration
                  curve: Curves.easeInOut, // Optional curve for smooth animation
                  width: externalCostWidth, // Calculate the width based on percentage
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
                      child: Text(
                        '${externalCostsPercentage.toString()} %',
                        style: textTheme.labelMedium!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // Internal costs part
                Expanded(
                  child: SizedBox(
                    width: internalCostWidth, // Calculate the width based on percentage
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: smallPadding),
                        child: Text(
                          '${internalCostsPercentage.toString()} %',
                          style: textTheme.labelMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                ),
              ],
            ),
          ]
        ],
      );
    },
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

  if (positions.any((element) => element == position)) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...positions.asMap().entries.map((entry) {
            String label = '';
            int index = entry.key;
            int flex = getFlexValue(index, percentages, position);

            if (labels != null && labels.length >= index + 1) {
              label = ' ${labels[index]}'.toUpperCase();
            }
            return Expanded(
              // if 1% then flex 2, because 1% is too small for whole text
              flex: flex,
              child: positions[index] == position
                  ? Text('${percentages[index].toString()} %$label',
                      style: textTheme.labelSmall,
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

  return LayoutBuilder(
    builder: (context, constraints) {
      // Use constraints.maxWidth to get the available width
      double availableWidth = constraints.maxWidth;

      // Adjust barWidth calculation based on availableWidth
      double barWidth = availableWidth;

      // Calculate individual widths based on the available bar width
      double timeCostWidth = barWidth * (timeCostsPercentage / 100);
      double healthCostWidth = barWidth * (healthCostsPercentage / 100);

      return Column(
        children: [
          textRowCostsBar(context,
              selectedTrip: selectedTrip,
              position: PercentageTextPosition.above,
              positions: positions,
              percentages: percentages,
              labels: [lang.time, lang.health, lang.environment]),
          // Main cost bar
          Container(
            decoration: BoxDecoration(
              color: getColorFromMobiScore(selectedTrip.mobiScore).lighten(0.4),
            ),
            height: 20,
            child: Row(
              children: [
                // Time and Health costs combined (animated)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: timeCostWidth + healthCostWidth,
                  height: 20,
                  decoration: BoxDecoration(
                    color: getColorFromMobiScore(selectedTrip.mobiScore).lighten(0.2),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Time costs (animated)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        width: timeCostWidth, // Time costs width
                        decoration: BoxDecoration(
                          color: getColorFromMobiScore(selectedTrip.mobiScore),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        height: 20,
                      ),
                      // Health costs (remaining part of the bar)
                      Expanded(
                        child: Container(
                          color: Colors.transparent, // Transparent to show the combined background
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                // Environment costs (static, non-animated, fills remaining space)
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.transparent, // No animation or color change
                    ),
                  ),
                ),
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
    },
  );
}

Widget privateCostsBar(BuildContext context, {required Trip selectedTrip}) {
  AppLocalizations lang = AppLocalizations.of(context)!;

  int fixedCosts = getPrivateFixedCostsPercentage(selectedTrip);
  int variableCosts = getPrivateVariableCostsPercentage(selectedTrip);

  List<int> percentages = [fixedCosts, variableCosts];
  List<PercentageTextPosition> positions = getPercentageTextPositions(percentages);

  return LayoutBuilder(
    builder: (context, constraints) {
      // Use constraints.maxWidth to get the available width
      double availableWidth = constraints.maxWidth;

      // Calculate the widths for fixed and variable costs based on available space
      double fixedCostsWidth = availableWidth * (fixedCosts / 100);

      return Column(
        children: [
          // Above text labels for the bar
          textRowCostsBar(context,
              selectedTrip: selectedTrip,
              position: PercentageTextPosition.above,
              positions: positions,
              percentages: percentages,
              labels: [lang.fixed, lang.variable]),

          // The bar itself
          Container(
            decoration: BoxDecoration(
              color: customLightGrey.lighten(0.4),
            ),
            height: 20,
            child: Row(
              children: [
                // Fixed Costs (animated)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: fixedCostsWidth, // Animate width of fixed costs
                  height: 20,
                  decoration: BoxDecoration(
                    color: customLightGrey,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                // Variable Costs (remaining part)
                Expanded(
                  child: Container(
                    color: Colors.transparent, // Transparent to show the combined background
                    height: 20,
                  ),
                ),
              ],
            ),
          ),

          // Below text labels for the bar
          textRowCostsBar(context,
              selectedTrip: selectedTrip,
              position: PercentageTextPosition.below,
              positions: positions,
              percentages: percentages,
              labels: [lang.fixed, lang.variable]),
        ],
      );
    },
  );
}

List<PercentageTextPosition> getPercentageTextPositions(List<int> percentages) {
  int length = percentages.length;
  List<PercentageTextPosition> positions = List.filled(length, PercentageTextPosition.above);

  // make all uneven indexes of positions below
  for (int i = 0; i < length; i++) {
    if (i % 2 == 1) {
      positions[i] = PercentageTextPosition.below;
    }
  }

  return positions;
}

int getFlexValue(int index, List<int> percentages, PercentageTextPosition position) {
  if (percentages.length == 3) {
    if ((index == 0 || index == 2) && position == PercentageTextPosition.above) {
      return 1;
    } else if (index == 0 && position == PercentageTextPosition.below) {
      return percentages[0];
    } else if (index == 1 && position == PercentageTextPosition.below) {
      return percentages[1] + percentages[2];
    } else {
      return 0;
    }
  } else if (percentages.length == 2) {
    if (index == 0 && position == PercentageTextPosition.above) {
      return 1;
    } else if (index == 0 && position == PercentageTextPosition.below) {
      return 0;
    } else if (index == 1 && position == PercentageTextPosition.below) {
      return 1;
    } else if (index == 1 && position == PercentageTextPosition.above) {
      return 0;
    } else {
      return 0;
    }
  } else {
    return percentages[index];
  }
}

enum CostsPercentageBarType { total, social, personal }

enum PercentageTextPosition { below, above }
