import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/detail_route_info/detail_route_info_diagram.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/detail_route_info/diagram_type_selection.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class DetailRouteInfoSection extends StatefulWidget {
  const DetailRouteInfoSection({
    super.key,
    this.currentCarTrip,
    this.currentBicycleTrip,
    this.currentPublicTransportTrip,
  });

  final Trip? currentCarTrip;
  final Trip? currentBicycleTrip;
  final Trip? currentPublicTransportTrip;

  @override
  State<DetailRouteInfoSection> createState() => _DetailRouteInfoSectionState();
}

class _DetailRouteInfoSectionState extends State<DetailRouteInfoSection> {
  InfoViewType infoViewType = InfoViewType.map;
  DiagramType selectedDiagramType = DiagramType.total;

  void changeInfoViewType() {
    void setInfoViewType(InfoViewType infoViewType) {
      setState(() {
        this.infoViewType = infoViewType;
      });
    }

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
      child: SingleChildScrollView(
        child: Padding(
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
            if (infoViewType == InfoViewType.diagram)
              DiagramTypeSelection(
                height: diagramTypeSelectionHeight,
                setDiagramType: (value) {
                  setState(() {
                    selectedDiagramType = value;
                  });
                },
                selectedDiagramType: selectedDiagramType,
              ),
            extraLargeVerticalSpacer,
            if (infoViewType == InfoViewType.diagram)
              DetailRouteInfoDiagram(
                  currentCarTrip: widget.currentCarTrip,
                  currentBicycleTrip: widget.currentBicycleTrip,
                  currentPublicTransportTrip: widget.currentPublicTransportTrip,
                  selectedDiagramType: selectedDiagramType)
          ]),
        ),
      ),
    );
  }
}

enum InfoViewType { diagram, map }

enum DiagramType { total, social, personal }
