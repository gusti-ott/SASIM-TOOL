import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/mode_mapping_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_map.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_mobiscore.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/diagram/diagram_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/values.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/typography.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class DetailRouteInfoContent extends StatelessWidget {
  const DetailRouteInfoContent({
    super.key,
    this.isMobile = false,
    this.currentCarTrip,
    this.currentBicycleTrip,
    this.currentPublicTransportTrip,
    this.selectedTrip,
    required this.infoViewType,
    required this.selectedDiagramType,
    required this.setInfoViewTypeCallback,
    required this.setDiagramTypeCallback,
    this.closeCallback,
    required this.startAddress,
    required this.endAddress,
  });

  final bool isMobile;
  final Trip? currentCarTrip;
  final Trip? currentBicycleTrip;
  final Trip? currentPublicTransportTrip;
  final Trip? selectedTrip;
  final InfoViewType infoViewType;
  final DiagramType selectedDiagramType;
  final Function(InfoViewType) setInfoViewTypeCallback;
  final Function(DiagramType) setDiagramTypeCallback;
  final Function()? closeCallback;
  final String startAddress;
  final String endAddress;

  void changeInfoViewType() {
    if (infoViewType == InfoViewType.diagram || infoViewType == InfoViewType.mobiscore) {
      setInfoViewTypeCallback(InfoViewType.map);
    } else {
      setInfoViewTypeCallback(InfoViewType.diagram);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColorGreyV3,
      ),
      width: isMobile ? double.infinity : getWidthInfoSection(context),
      height: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (infoViewType == InfoViewType.map) DetailRouteInfoMap(trip: selectedTrip),
          if (infoViewType == InfoViewType.mobiscore) detailRouteInfoMobiScore(context, isMobile: isMobile),
          if (infoViewType == InfoViewType.diagram)
            diagramContent(
              context,
              isMobile: isMobile,
              setDiagramTypeCallback: setDiagramTypeCallback,
              selectedDiagramType: selectedDiagramType,
              currentCarTrip: currentCarTrip,
              currentBicycleTrip: currentBicycleTrip,
              currentPublicTransportTrip: currentPublicTransportTrip,
            ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(mediumPadding),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (isMobile == true || infoViewType == InfoViewType.mobiscore)
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: customGrey, width: 3),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                icon: Icon(Icons.close, color: colorE),
                                onPressed: () {
                                  if (isMobile) {
                                    if (closeCallback != null) {
                                      closeCallback!();
                                    }
                                  } else {
                                    setInfoViewTypeCallback(InfoViewType.map);
                                  }
                                },
                              ),
                            ),
                          )
                        else
                          const SizedBox(),
                        if (infoViewType != InfoViewType.mobiscore)
                          Switch(
                            thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
                              return Icon(
                                Icons.bar_chart,
                                color: customBlack,
                              ); // All other states will use the default thumbIcon.
                            }),
                            activeTrackColor: primaryColorV3,
                            inactiveTrackColor: backgroundColorGreyV3,
                            activeColor: Colors.white,
                            inactiveThumbColor: customGrey,
                            value: (infoViewType == InfoViewType.diagram || infoViewType == InfoViewType.mobiscore),
                            onChanged: (value) {
                              changeInfoViewType();
                            },
                          )
                      ],
                    ),
                    if (infoViewType == InfoViewType.map && selectedTrip != null) ...[
                      largeVerticalSpacer,
                      modeLegend(context, trip: selectedTrip!),
                    ]
                  ],
                ),
                if (infoViewType == InfoViewType.map)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      startAddressRow(startAddress),
                      smallVerticalSpacer,
                      endAddressRow(endAddress),
                      smallVerticalSpacer,
                      if (selectedTrip != null) travelDetailsRow(selectedTrip!),
                    ],
                  ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}

Row travelDetailsRow(Trip selectedTrip) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      mapContainer(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.route_outlined, color: customGrey, size: 16),
          smallHorizontalSpacer,
          Text(
            '${selectedTrip.distance.toStringAsFixed(2)} km',
            style: mapLegendTextStyle,
          )
        ],
      )),
      mapContainer(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.access_time_outlined, color: customGrey, size: 16),
          smallHorizontalSpacer,
          Text(
            '${selectedTrip.duration.toStringAsFixed(0)} min',
            style: mapLegendTextStyle,
          )
        ],
      )),
    ],
  );
}

Row endAddressRow(String endAddress) {
  return Row(
    children: [
      Expanded(
          flex: 8, child: mapContainer(child: Text(endAddress, style: mapLegendTextStyle, textAlign: TextAlign.left))),
      Expanded(flex: 1, child: endIcon())
    ],
  );
}

Row startAddressRow(String startAddress) {
  return Row(
    children: [
      Expanded(
          flex: 8,
          child: mapContainer(child: Text(startAddress, style: mapLegendTextStyle, textAlign: TextAlign.left))),
      Expanded(flex: 1, child: startIcon())
    ],
  );
}

Widget modeLegend(BuildContext context, {required Trip trip}) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  ModeMappingHelper helper = ModeMappingHelper(lang);
  return IntrinsicWidth(
    child: mapContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (containsWalkSegment(trip)) ...[
                Text(lang.walk, style: mapLegendTextStyle),
                smallHorizontalSpacer,
                Container(
                  height: 8,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                mediumHorizontalSpacer,
              ],
              Text(helper.mapModeStringToLocalizedString(trip.mode), style: mapLegendTextStyle),
              smallHorizontalSpacer,
              Container(
                height: 8,
                width: 32,
                decoration: BoxDecoration(
                  color: colorC,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget mapContainer({required Widget child}) {
  return Container(
    height: 32,
    decoration: BoxDecoration(
      color: backgroundColorGreyV3,
      border: Border.all(color: customGrey, width: 1),
      borderRadius: BorderRadius.circular(30),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: smallPadding / 2, horizontal: mediumPadding),
      child: Align(alignment: Alignment.centerLeft, child: child),
    ),
  );
}

enum InfoViewType { diagram, map, mobiscore }

enum DiagramType {
  total,
  social,
  personal,
  detailSocial,
  detailSocialTime,
  detailSocialHealth,
  detailSocialEnvironment,
  detailPersonal,
  detailPersonalFixed,
  detailPersonalVariable
}

bool containsWalkSegment(Trip? trip) {
  if (trip == null) return false;
  return trip.segments.any((element) => element.mode == 'WALK');
}
