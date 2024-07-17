import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/question_icons.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';

Widget costResultRow(
  BuildContext context, {
  required Trip trip,
  required Function(DiagramType) setDiagramType,
  isMobile = false,
}) {
  double diameter = 200;
  double width = 350;
  return SizedBox(
    width: double.infinity,
    child: Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.spaceBetween,
      spacing: largePadding,
      runSpacing: largePadding,
      children: [
        socialCostsCard(context, width: width, height: diameter, trip: trip, setDiagramType: setDiagramType),
        personalCostsCard(context, width: width, height: diameter, trip: trip, setDiagramType: setDiagramType)
      ],
    ),
  );
}

Widget socialCostsCard(BuildContext context,
    {required double width,
    required double height,
    required Trip trip,
    required Function(DiagramType) setDiagramType}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return SizedBox(
    width: width,
    height: height,
    child: Stack(
      children: [
        Positioned.fill(
          left: 40, // Adjust this value as needed for proper alignment
          child: Container(
            padding: EdgeInsets.all(mediumPadding),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.45),
              borderRadius: BorderRadius.circular(height / 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      trip.costs.externalCosts.all.currencyString,
                      style: textTheme.headlineMedium,
                    ),
                    Text(
                      'SOCIAL COSTS',
                      style: textTheme.labelLarge,
                    ),
                    smallVerticalSpacer,
                    customQuestionIcon(
                      onTap: () {
                        setDiagramType(DiagramType.social);
                      },
                    ),
                  ],
                ),
                mediumHorizontalSpacer
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: Image.asset(getAssetPathFromMobiScore(trip.mobiScore)),
        ),
      ],
    ),
  );
}

Widget personalCostsCard(BuildContext context,
    {required double width,
    required double height,
    required Trip trip,
    required Function(DiagramType) setDiagramType}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return SizedBox(
    width: width,
    height: height,
    child: Stack(
      children: [
        Positioned.fill(
          left: 100,
          child: Container(
            padding: EdgeInsets.all(mediumPadding),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.45),
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      trip.costs.internalCosts.all.currencyString,
                      style: textTheme.headlineMedium,
                    ),
                    Text(
                      'PERSONAL COSTS',
                      style: textTheme.labelLarge,
                    ),
                    smallVerticalSpacer,
                    customQuestionIcon(
                      onTap: () {
                        setDiagramType(DiagramType.personal);
                      },
                    ),
                  ],
                ),
                mediumHorizontalSpacer,
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          child: Image.asset('assets/icons/personal_null.png'),
        ),
      ],
    ),
  );
}
