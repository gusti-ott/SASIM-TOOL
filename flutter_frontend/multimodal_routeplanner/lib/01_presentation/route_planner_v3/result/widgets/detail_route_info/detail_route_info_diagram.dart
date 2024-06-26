import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/costs_rates.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_color.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mode_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';

class DetailRouteInfoDiagram extends StatelessWidget {
  const DetailRouteInfoDiagram(
      {super.key,
      required this.selectedDiagramType,
      this.currentCarTrip,
      this.currentBicycleTrip,
      this.currentPublicTransportTrip});

  final Trip? currentCarTrip;
  final Trip? currentBicycleTrip;
  final Trip? currentPublicTransportTrip;
  final DiagramType selectedDiagramType;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    double maxCosts = getMaxCostsValue(currentCarTrip, currentBicycleTrip, currentPublicTransportTrip);

    return SizedBox(
      height: 350,
      width: 160,
      child: Column(
        children: [
          Container(
            height: 270,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (currentCarTrip != null)
                  diagramBar(context, trip: currentCarTrip!, diagramType: selectedDiagramType, maxCosts: maxCosts),
                if (currentBicycleTrip != null)
                  diagramBar(context, trip: currentBicycleTrip!, diagramType: selectedDiagramType, maxCosts: maxCosts),
                if (currentPublicTransportTrip != null)
                  diagramBar(context,
                      trip: currentPublicTransportTrip!, diagramType: selectedDiagramType, maxCosts: maxCosts),
              ],
            ),
          ),
          const Divider(),
          Text('${getDiagramTitle(selectedDiagramType)} COSTS BY MODE', style: textTheme.labelLarge),
        ],
      ),
    );
  }
}

Widget diagramBar(BuildContext context,
    {required Trip trip, required DiagramType diagramType, required double maxCosts}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  double width = 32;

  // indicates the height of the whole bar - highest is the fullcosts of the most expensive trip
  final int globalPercentage = (trip.costs.getFullcosts() / maxCosts * 100).round();

  // indicates the height of the colored bar, the rest ist grey
  final int internalPercentage = getPercentageForDiagramType(trip, diagramType);

  // costs value as string
  final String costsValue = getDiagramCostsValue(diagramType, trip.costs);

  return Column(
    children: [
      Expanded(flex: 100 - globalPercentage, child: const SizedBox()),
      Expanded(
        flex: globalPercentage,
        child: Container(
          height: double.infinity,
          width: width,
          decoration: BoxDecoration(
            color: customLightGrey,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Expanded(flex: 100 - internalPercentage, child: const SizedBox()),
              Container(
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
                      backgroundColor: Colors.white, radius: width / 2, child: Icon(getIconDataFromMode(trip.mode))),
                ),
              ),
              Expanded(
                flex: internalPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: getColorFromMobiScore(trip.mobiScore),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      smallVerticalSpacer,
      Text(costsValue, style: textTheme.labelMedium),
    ],
  );
}

int getPercentageForDiagramType(Trip trip, DiagramType type) {
  if (type == DiagramType.total) {
    return 100;
  } else {
    int percantageExternalCosts = calculateExternalCostsPercantage(trip);

    if (type == DiagramType.personal) {
      return 100 - percantageExternalCosts;
    } else {
      return percantageExternalCosts;
    }
  }
}

String getDiagramCostsValue(DiagramType type, Costs costs) {
  if (type == DiagramType.total) {
    return costs.getFullcosts().currencyString;
  } else if (type == DiagramType.social) {
    return costs.externalCosts.all.currencyString;
  } else {
    return costs.internalCosts.all.currencyString;
  }
}

double getMaxCostsValue(Trip? currentCarTrip, Trip? currentBicycleTrip, Trip? currentPublicTransportTrip) {
  List costs = [
    if (currentCarTrip != null) currentCarTrip.costs.getFullcosts(),
    if (currentBicycleTrip != null) currentBicycleTrip.costs.getFullcosts(),
    if (currentPublicTransportTrip != null) currentPublicTransportTrip.costs.getFullcosts(),
  ];

  double maxValue = costs.reduce((value, element) => max(value as double, element as double));

  return maxValue;
}

String getDiagramTitle(DiagramType diagramType) {
  switch (diagramType) {
    case DiagramType.total:
      return 'TOTAL';
    case DiagramType.social:
      return 'SOCIAL';
    case DiagramType.personal:
      return 'PERSONAL';
  }
}
