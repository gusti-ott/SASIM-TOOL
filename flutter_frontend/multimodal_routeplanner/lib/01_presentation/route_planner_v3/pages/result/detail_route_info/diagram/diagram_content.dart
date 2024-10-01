import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_diagram.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/diagram/detail_route_text_info.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/diagram/diagram_helper_methods.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/diagram/diagram_type_selection.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

Widget diagramContent(
  BuildContext context, {
  required bool isMobile,
  required Function(DiagramType) setDiagramTypeCallback,
  required DiagramType selectedDiagramType,
  required Trip? currentCarTrip,
  required Trip? currentBicycleTrip,
  required Trip? currentPublicTransportTrip,
}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  AppLocalizations lang = AppLocalizations.of(context)!;
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.only(left: isMobile ? extraLargePadding : extraLargePadding * 2, right: extraLargePadding),
      child: Column(children: [
        SizedBox(height: largePadding * 2),
        DiagramTypeSelection(
          setDiagramType: setDiagramTypeCallback,
          selectedDiagramType: selectedDiagramType,
        ),
        mediumVerticalSpacer,
        DetailRouteInfoDiagram(
            currentCarTrip: currentCarTrip,
            currentBicycleTrip: currentBicycleTrip,
            currentPublicTransportTrip: currentPublicTransportTrip,
            selectedDiagramType: selectedDiagramType),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '${lang.what_are} ${getDiagramTitle(context, selectedDiagramType)}?',
            style: textTheme.titleMedium,
          ),
        ),
        smallVerticalSpacer,
        detailRouteTextInfo(context, diagramType: selectedDiagramType),
        largeVerticalSpacer
      ]),
    ),
  );
}
