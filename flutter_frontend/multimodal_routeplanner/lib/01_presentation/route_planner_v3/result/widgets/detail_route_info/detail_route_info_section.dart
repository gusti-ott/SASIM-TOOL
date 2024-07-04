import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/detail_route_info/detail_route_info_diagram.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/detail_route_info/detail_route_info_map.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/detail_route_info/diagram_type_selection.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class DetailRouteInfoSection extends StatelessWidget {
  const DetailRouteInfoSection({
    super.key,
    this.currentCarTrip,
    this.currentBicycleTrip,
    this.currentPublicTransportTrip,
    this.selectedTrip,
    required this.infoViewType,
    required this.selectedDiagramType,
    required this.setInfoViewType,
    required this.setDiagramType,
  });

  final Trip? currentCarTrip;
  final Trip? currentBicycleTrip;
  final Trip? currentPublicTransportTrip;
  final Trip? selectedTrip;
  final InfoViewType infoViewType;
  final DiagramType selectedDiagramType;
  final Function(InfoViewType) setInfoViewType;
  final Function(DiagramType) setDiagramType;

  void changeInfoViewType() {
    if (infoViewType == InfoViewType.diagram) {
      setInfoViewType(InfoViewType.map);
    } else {
      setInfoViewType(InfoViewType.diagram);
    }
  }

  @override
  Widget build(BuildContext context) {
    double diagramTypeSelectionHeight = 80;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: backgroundColorV3,
      ),
      width: 350,
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (infoViewType == InfoViewType.map) DetailRouteInfoMap(trip: selectedTrip),
          Padding(
            padding: EdgeInsets.all(largePadding),
            child: Column(children: [
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Diagramm', style: textTheme.titleSmall!.copyWith(color: Colors.black)),
                    Switch(
                      value: (infoViewType == InfoViewType.diagram),
                      onChanged: (value) {
                        changeInfoViewType();
                      },
                      activeColor: secondaryColorV3,
                      inactiveThumbColor: Colors.grey,
                    ),
                  ],
                ),
              ),
              extraLargeVerticalSpacer,
              if (infoViewType == InfoViewType.diagram) ...[
                DiagramTypeSelection(
                  height: diagramTypeSelectionHeight,
                  setDiagramType: (value) {
                    setDiagramType(value);
                  },
                  selectedDiagramType: selectedDiagramType,
                ),
                extraLargeVerticalSpacer,
                DetailRouteInfoDiagram(
                    currentCarTrip: currentCarTrip,
                    currentBicycleTrip: currentBicycleTrip,
                    currentPublicTransportTrip: currentPublicTransportTrip,
                    selectedDiagramType: selectedDiagramType)
              ]
            ]),
          ),
        ],
      ),
    );
  }
}

enum InfoViewType { diagram, map }

enum DiagramType { total, social, personal }
