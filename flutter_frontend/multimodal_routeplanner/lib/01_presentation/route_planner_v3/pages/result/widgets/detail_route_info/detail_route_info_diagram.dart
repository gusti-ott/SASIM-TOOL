import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mode_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/diagram_helper_methods.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/stacked_diagram_bar.dart';
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
    AppLocalizations lang = AppLocalizations.of(context)!;

    double maxCosts = getMaxCostsValue(
        currentCarTrip: currentCarTrip,
        currentBicycleTrip: currentBicycleTrip,
        currentPublicTransportTrip: currentPublicTransportTrip,
        diagramType: selectedDiagramType);

    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 270,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentCarTrip != null)
                  stackedDiagramBar(context,
                      trip: currentCarTrip!, diagramType: selectedDiagramType, maxValue: maxCosts),
                if (currentBicycleTrip != null)
                  stackedDiagramBar(context,
                      trip: currentBicycleTrip!, diagramType: selectedDiagramType, maxValue: maxCosts),
                if (currentPublicTransportTrip != null)
                  stackedDiagramBar(context,
                      trip: currentPublicTransportTrip!, diagramType: selectedDiagramType, maxValue: maxCosts),
              ],
            ),
          ),
          const Divider(),
          Text('${getDiagramDescription(context, selectedDiagramType)} ${lang.by_mode.toUpperCase()}',
              style: textTheme.labelLarge, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

Widget diagramBar(BuildContext context,
    {required Trip trip, required DiagramType diagramType, required double maxValue}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  double width = 32;

  // indicates the height of the whole bar - highest is the fullcosts of the most expensive trip
  final int globalPercentage = getGlobalPercentage(diagramType, trip, maxValue);
  print('globalPercentage for ${trip.mode}: $globalPercentage');

  // indicates the height of the colored bar, the rest ist grey
  final int internalPercentage = getInternalPercentage(trip, diagramType);
  print('internalPercentage for ${trip.mode}: $internalPercentage');

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
                  child:
                      CircleAvatar(backgroundColor: Colors.white, radius: width / 2, child: getIconFromMode(trip.mode)),
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
