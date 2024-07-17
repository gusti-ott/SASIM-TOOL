import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/input_to_trip.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/layer_1/layer_1_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/layer_2_detailed/layer_2_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/mobiscore_score_board/mobi_score_score_board.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/mobiscore_score_board/score_pointer.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/mode_selection_components.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class ResultContent extends StatelessWidget {
  const ResultContent({
    super.key,
    this.isMobile = false,
    required this.selectionMode,
    required this.isElectric,
    required this.isShared,
    required this.trips,
    required this.selectedTrip,
    required this.onSelectionModeChanged,
    required this.onElectricChanged,
    required this.onSharedChanged,
    required this.infoViewType,
    required this.selectedDiagramType,
    required this.setInfoViewTypeCallback,
    required this.setDiagramTypeCallback,
    required this.changeLayerCallback,
    required this.contentLayer,
  });

  final bool isMobile;
  final SelectionMode selectionMode;
  final bool isElectric;
  final bool isShared;
  final List<Trip> trips;
  final Trip selectedTrip;
  final Function(SelectionMode) onSelectionModeChanged;
  final Function(bool) onElectricChanged;
  final Function(bool) onSharedChanged;
  final InfoViewType infoViewType;
  final DiagramType selectedDiagramType;
  final Function(InfoViewType) setInfoViewTypeCallback;
  final Function(DiagramType) setDiagramTypeCallback;
  final ContentLayer contentLayer;
  final Function(ContentLayer) changeLayerCallback;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double widthInfoSection = 350;
    double contentMaxWidth = 850;
    double horizontalPadding = mediumPadding;

    String currentCarTripMode = getCarTripMode(isElectric: isElectric, isShared: isShared);
    Trip? currentCarTrip = trips.firstWhereOrNull((trip) => trip.mode == currentCarTripMode);
    String currentBicycleTripMode = getBicycleTripMode(isElectric: isElectric, isShared: isShared);
    Trip? currentBicycleTrip = trips.firstWhereOrNull((trip) => trip.mode == currentBicycleTripMode);
    String currentPublicTransportTripMode = getPublicTransportTripMode();
    Trip? currentPublicTransportTrip = trips.firstWhereOrNull((trip) => trip.mode == currentPublicTransportTripMode);

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isMobile)
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: mobileModeSelectionContainer(context,
                    isElectric: isElectric,
                    onElectricChanged: onElectricChanged,
                    selectedMode: selectionMode,
                    onSelectionModeChanged: onSelectionModeChanged,
                    isShared: isShared,
                    onSharedChanged: onSharedChanged,
                    disableBorder: true),
              ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: horizontalPadding,
                            top: mediumPadding,
                            bottom: mediumPadding,
                            right: isMobile ? horizontalPadding : extraLargePadding + mediumPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 1000),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (!isMobile) ...[
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: mediumPadding, vertical: extraLargePadding),
                                      child: modeSelectionRow(context,
                                          isElectric: isElectric,
                                          onElectricChanged: onElectricChanged,
                                          selectionMode: selectionMode,
                                          onSelectionModeChanged: onSelectionModeChanged,
                                          isShared: isShared,
                                          onSharedChanged: onSharedChanged),
                                    ),
                                  ] else ...[
                                    mobiScoreScoreBoardWithPointers(context,
                                        heightSection: 240,
                                        selectedTrip: selectedTrip,
                                        currentCarTrip: currentCarTrip,
                                        currentBicycleTrip: currentBicycleTrip,
                                        currentPublicTransportTrip: currentPublicTransportTrip,
                                        onSelectionModeChanged: onSelectionModeChanged,
                                        horizontalPadding: horizontalPadding),
                                  ],
                                  if (contentLayer == ContentLayer.layer1)
                                    Layer1Content(
                                      selectedTrip: selectedTrip,
                                      setInfoViewTypeCallback: setInfoViewTypeCallback,
                                      setDiagramTypeCallback: setDiagramTypeCallback,
                                      isMobile: isMobile,
                                      contentMaxWidth: contentMaxWidth,
                                      changeLayerCallback: changeLayerCallback,
                                    ),
                                  if (contentLayer == ContentLayer.layer2)
                                    Layer2Content(
                                      selectedTrip: selectedTrip,
                                      isMobile: isMobile,
                                      changeLayerCallback: changeLayerCallback,
                                      setInfoViewTypeCallback: setInfoViewTypeCallback,
                                      setDiagramTypeCallback: setDiagramTypeCallback,
                                      contentMaxWidth: contentMaxWidth,
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!isMobile)
                    DetailRouteInfoSection(
                        currentCarTrip: currentCarTrip,
                        currentBicycleTrip: currentBicycleTrip,
                        currentPublicTransportTrip: currentPublicTransportTrip,
                        selectedTrip: selectedTrip,
                        infoViewType: infoViewType,
                        selectedDiagramType: selectedDiagramType,
                        setInfoViewType: setInfoViewTypeCallback,
                        setDiagramType: setDiagramTypeCallback),
                ],
              ),
            ),
          ],
        ),
        if (!isMobile)
          ...scoreBoardWithPointers(context,
              widthInfoSection: widthInfoSection,
              screenHeight: screenHeight,
              selectedTrip: selectedTrip,
              currentCarTrip: currentCarTrip,
              currentPublicTransportTrip: currentPublicTransportTrip,
              currentBicycleTrip: currentBicycleTrip)
      ],
    );
  }

  List<Widget> scoreBoardWithPointers(BuildContext context,
      {required double widthInfoSection,
      required double screenHeight,
      required Trip selectedTrip,
      required Trip? currentCarTrip,
      required Trip? currentPublicTransportTrip,
      required Trip? currentBicycleTrip}) {
    return [
      Positioned(
        right: widthInfoSection - (widthScoreColumn / 2),
        top: (screenHeight - heightScoreColumn) / 2 - mediumPadding - widthScoreColumn,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(smallPadding),
            child: Image.asset(
              'assets/mobiscore_logos/logo_primary.png',
              height: widthScoreColumn,
              width: widthScoreColumn,
            ),
          ),
        ),
      ),
      Positioned(
        right: widthInfoSection - (widthScoreColumn / 2),
        bottom: (screenHeight - heightScoreColumn) / 2,
        child: mobiScoreScoreBoard(context, selectedTrip: selectedTrip),
      ),
      ...positionedScorePointers(
          widthInfoSection: widthInfoSection,
          widthScoreColumn: widthScoreColumn,
          heightScoreColumn: heightScoreColumn,
          borderWidthScoreColumn: borderWidthScoreColumn,
          screenHeight: screenHeight,
          selectedTrip: selectedTrip,
          currentCarTrip: currentCarTrip,
          currentPublicTransportTrip: currentPublicTransportTrip,
          currentBicycleTrip: currentBicycleTrip,
          onSelectionModeChanged: onSelectionModeChanged),
    ];
  }

  List<Widget> positionedScorePointers(
      {required double widthInfoSection,
      required double widthScoreColumn,
      required double heightScoreColumn,
      required double borderWidthScoreColumn,
      required double screenHeight,
      required Trip selectedTrip,
      required Trip? currentCarTrip,
      required Trip? currentPublicTransportTrip,
      required Trip? currentBicycleTrip,
      bool isMobile = false,
      double mobileTopPositionOffset = 0,
      required Function(SelectionMode) onSelectionModeChanged}) {
    return [
      if (currentCarTrip != null)
        positionedScorePointer(
          widthInfoSection: widthInfoSection,
          widthScoreColumn: widthScoreColumn,
          heightScoreColumn: heightScoreColumn,
          borderWidthScoreColumn: borderWidthScoreColumn,
          screenHeight: screenHeight,
          selectedTrip: selectedTrip,
          thisTrip: currentCarTrip,
          isMobile: isMobile,
          onTripSelected: (value) {
            SelectionMode mode = getSelectionModeFromTripMode(value.mode);
            onSelectionModeChanged(mode);
          },
        ),
      if (currentPublicTransportTrip != null)
        positionedScorePointer(
          widthInfoSection: widthInfoSection,
          widthScoreColumn: widthScoreColumn,
          heightScoreColumn: heightScoreColumn,
          borderWidthScoreColumn: borderWidthScoreColumn,
          screenHeight: screenHeight,
          selectedTrip: selectedTrip,
          thisTrip: currentPublicTransportTrip,
          isMobile: isMobile,
          onTripSelected: (value) {
            SelectionMode mode = getSelectionModeFromTripMode(value.mode);
            onSelectionModeChanged(mode);
          },
        ),
      if (currentBicycleTrip != null)
        positionedScorePointer(
          widthInfoSection: widthInfoSection,
          widthScoreColumn: widthScoreColumn,
          heightScoreColumn: heightScoreColumn,
          borderWidthScoreColumn: borderWidthScoreColumn,
          screenHeight: screenHeight,
          selectedTrip: selectedTrip,
          thisTrip: currentBicycleTrip,
          isMobile: isMobile,
          onTripSelected: (value) {
            SelectionMode mode = getSelectionModeFromTripMode(value.mode);
            onSelectionModeChanged(mode);
          },
        ),
    ];
  }
}

enum ContentLayer { layer1, layer2 }
