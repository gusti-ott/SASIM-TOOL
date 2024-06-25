import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/costs_rates.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_color.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

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
                if (currentCarTrip != null) diagramBar(currentCarTrip!, selectedDiagramType),
                if (currentBicycleTrip != null) diagramBar(currentBicycleTrip!, selectedDiagramType),
                if (currentPublicTransportTrip != null) diagramBar(currentPublicTransportTrip!, selectedDiagramType),
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

Widget diagramBar(Trip trip, DiagramType diagramType) {
  // indicates the height of the colored bar, the rest ist grey
  final int percentage = getPercentageForDiagramType(trip, diagramType);

  return Container(
    height: double.infinity,
    width: 32,
    decoration: BoxDecoration(color: customLightGrey),
    child: Column(
      children: [
        Expanded(flex: 100 - percentage, child: const SizedBox()),
        Expanded(
          flex: percentage,
          child: Container(
            decoration: BoxDecoration(color: getColorFromMobiScore(trip.mobiScore)),
          ),
        ),
      ],
    ),
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
