import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/diagram/diagram_helper_methods.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/diagram/stacked_diagram_bar.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class DetailRouteInfoDiagram extends StatelessWidget {
  const DetailRouteInfoDiagram({
    super.key,
    required this.selectedDiagramType,
    this.currentCarTrip,
    this.currentBicycleTrip,
    this.currentPublicTransportTrip,
  });

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

    bool greyOnly = !(selectedDiagramType == DiagramType.social ||
        selectedDiagramType == DiagramType.detailSocial ||
        selectedDiagramType == DiagramType.detailSocialTime ||
        selectedDiagramType == DiagramType.detailSocialEnvironment ||
        selectedDiagramType == DiagramType.detailSocialHealth);

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
                      trip: currentCarTrip!, diagramType: selectedDiagramType, maxValue: maxCosts, greyOnly: greyOnly),
                if (currentBicycleTrip != null)
                  stackedDiagramBar(context,
                      trip: currentBicycleTrip!,
                      diagramType: selectedDiagramType,
                      maxValue: maxCosts,
                      greyOnly: greyOnly),
                if (currentPublicTransportTrip != null)
                  stackedDiagramBar(context,
                      trip: currentPublicTransportTrip!,
                      diagramType: selectedDiagramType,
                      maxValue: maxCosts,
                      greyOnly: greyOnly),
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
