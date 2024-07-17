import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/costs_result_row.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class Layer2Content extends StatelessWidget {
  const Layer2Content(
      {super.key,
      required this.selectedTrip,
      required this.isMobile,
      required this.setInfoViewTypeCallback,
      required this.setDiagramTypeCallback,
      required this.contentMaxWidth});

  final Trip selectedTrip;
  final bool isMobile;
  final Function(InfoViewType) setInfoViewTypeCallback;
  final Function(DiagramType) setDiagramTypeCallback;
  final double contentMaxWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: contentMaxWidth,
      child: Column(
        children: [
          extraLargeVerticalSpacer,
          costResultRow(context, trip: selectedTrip, setDiagramType: (value) {
            setInfoViewTypeCallback(InfoViewType.diagram);
            setDiagramTypeCallback(value);
          }, isMobile: isMobile),
          extraLargeVerticalSpacer,
        ],
      ),
    );
  }
}
