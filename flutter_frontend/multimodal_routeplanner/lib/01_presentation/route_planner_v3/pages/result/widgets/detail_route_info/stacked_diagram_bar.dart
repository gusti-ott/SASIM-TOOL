import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mode_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_diagram.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

Widget stackedDiagramBar(BuildContext context,
    {required Trip trip, required DiagramType diagramType, required double maxValue}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  double width = 32;

  // indicates the height of the whole bar - highest is the fullcosts of the most expensive trip
  int globalPercentage = getGlobalPercentage(diagramType, trip, maxValue);

  // indicates the height of the colored bar, the rest ist grey
  final int internalPercentage = getInternalPercentage(trip, diagramType);

  // costs value as string
  final String costsValue = getDiagramCostsValue(diagramType, trip.costs);

  int internalFlex = 100 - globalPercentage - ((internalPercentage - 100) / 100 * globalPercentage).round();

  return Column(
    children: [
      Expanded(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(flex: getFlexLargerZero(100 - globalPercentage), child: const SizedBox()),
                Container(
                  height: width,
                  width: width,
                  decoration: BoxDecoration(
                    color: customLightGrey,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                Expanded(
                  flex: getFlexLargerZero(globalPercentage),
                  child: Container(
                    height: double.infinity,
                    width: width,
                    decoration: BoxDecoration(
                      color: customLightGrey,
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Expanded(
                  flex: getFlexLargerZero(internalFlex),
                  child: const SizedBox(),
                ),
                Container(
                  height: width,
                  decoration: BoxDecoration(
                    color: getColorFromMobiScore(trip.mobiScore),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                        backgroundColor: Colors.white, radius: width / 2, child: getIconFromMode(trip.mode)),
                  ),
                ),
                Expanded(
                  flex: getFlexLargerZero(100 - internalFlex),
                  child: Container(
                    height: double.infinity,
                    width: width,
                    decoration: BoxDecoration(
                      color: getColorFromMobiScore(trip.mobiScore),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      smallVerticalSpacer,
      Text(costsValue, style: textTheme.labelMedium),
    ],
  );
}

int getFlexLargerZero(int flex) {
  return flex < 1 ? 1 : flex;
}
