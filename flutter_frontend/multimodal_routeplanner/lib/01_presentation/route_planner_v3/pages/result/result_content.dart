import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/input_to_trip.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/layer_1/layer_1_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/layer_2_detailed/layer_2_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/mobiscore_score_board/mobi_score_score_board.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/search_screen_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/mode_selection_components.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class ResultContent extends StatelessWidget {
  const ResultContent({
    super.key,
    this.isMobile = false,
    this.showAdditionalMobileInfo = false,
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
    required this.hideAdditionalInfoCallback,
  });

  final bool isMobile;
  final bool showAdditionalMobileInfo;
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
  final Function() hideAdditionalInfoCallback;

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

    ScrollController scrollController = ScrollController();

    return Stack(
      children: [
        if (isMobile)
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                leading: Padding(
                  padding: EdgeInsets.all(smallPadding),
                  child: InkWell(
                      onTap: () {
                        context.goNamed(SearchScreenV3.routeName);
                      },
                      child: Image.asset('assets/mobiscore_logos/logo_with_text_primary.png')),
                ),
                expandedHeight: 110,
                flexibleSpace: FlexibleSpaceBar(
                  background: mobileModeSelectionContainer(
                    context,
                    isElectric: isElectric,
                    onElectricChanged: onElectricChanged,
                    selectedMode: selectionMode,
                    onSelectionModeChanged: onSelectionModeChanged,
                    isShared: isShared,
                    onSharedChanged: onSharedChanged,
                    disableBorder: true,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.only(
                        left: horizontalPadding,
                        top: mediumPadding,
                        bottom: mediumPadding,
                        right: isMobile ? horizontalPadding : extraLargePadding + mediumPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1000),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                mobiScoreScoreBoardWithPointers(
                                  context,
                                  heightSection: 240,
                                  selectedTrip: selectedTrip,
                                  currentCarTrip: currentCarTrip,
                                  currentBicycleTrip: currentBicycleTrip,
                                  currentPublicTransportTrip: currentPublicTransportTrip,
                                  onSelectionModeChanged: onSelectionModeChanged,
                                  horizontalPadding: horizontalPadding,
                                ),
                                if (contentLayer == ContentLayer.layer1)
                                  Layer1Content(
                                    selectedTrip: selectedTrip,
                                    setInfoViewTypeCallback: setInfoViewTypeCallback,
                                    setDiagramTypeCallback: setDiagramTypeCallback,
                                    isMobile: isMobile,
                                    contentMaxWidth: contentMaxWidth,
                                    changeLayerCallback: (layer) {
                                      changeLayerAndScrollUp(layer, scrollController);
                                    },
                                  ),
                                if (contentLayer == ContentLayer.layer2)
                                  Layer2Content(
                                    selectedTrip: selectedTrip,
                                    isMobile: isMobile,
                                    changeLayerCallback: (layer) {
                                      changeLayerAndScrollUp(layer, scrollController);
                                    },
                                    setInfoViewTypeCallback: setInfoViewTypeCallback,
                                    setDiagramTypeCallback: setDiagramTypeCallback,
                                    contentMaxWidth: contentMaxWidth,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        if (!isMobile)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
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
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: mediumPadding, vertical: extraLargePadding),
                                      child: modeSelectionRow(
                                        context,
                                        isElectric: isElectric,
                                        onElectricChanged: onElectricChanged,
                                        selectionMode: selectionMode,
                                        onSelectionModeChanged: onSelectionModeChanged,
                                        isShared: isShared,
                                        onSharedChanged: onSharedChanged,
                                      ),
                                    ),
                                    if (contentLayer == ContentLayer.layer1)
                                      Layer1Content(
                                        selectedTrip: selectedTrip,
                                        setInfoViewTypeCallback: setInfoViewTypeCallback,
                                        setDiagramTypeCallback: setDiagramTypeCallback,
                                        isMobile: isMobile,
                                        contentMaxWidth: contentMaxWidth,
                                        changeLayerCallback: (layer) {
                                          changeLayerAndScrollUp(layer, scrollController);
                                        },
                                      ),
                                    if (contentLayer == ContentLayer.layer2)
                                      Layer2Content(
                                        selectedTrip: selectedTrip,
                                        isMobile: isMobile,
                                        changeLayerCallback: (layer) {
                                          changeLayerAndScrollUp(layer, scrollController);
                                        },
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
                    DetailRouteInfoSection(
                      currentCarTrip: currentCarTrip,
                      currentBicycleTrip: currentBicycleTrip,
                      currentPublicTransportTrip: currentPublicTransportTrip,
                      selectedTrip: selectedTrip,
                      infoViewType: infoViewType,
                      selectedDiagramType: selectedDiagramType,
                      setInfoViewTypeCallback: setInfoViewTypeCallback,
                      setDiagramTypeCallback: setDiagramTypeCallback,
                    ),
                  ],
                ),
              ),
            ],
          ),
        if (!isMobile)
          ...scoreBoardWithPointers(
            context,
            widthInfoSection: widthInfoSection,
            screenHeight: screenHeight,
            selectedTrip: selectedTrip,
            currentCarTrip: currentCarTrip,
            currentPublicTransportTrip: currentPublicTransportTrip,
            currentBicycleTrip: currentBicycleTrip,
            onSelectionModeChanged: onSelectionModeChanged,
          ),
        if (isMobile && showAdditionalMobileInfo)
          DetailRouteInfoSection(
            isMobile: isMobile,
            closeCallback: hideAdditionalInfoCallback,
            currentCarTrip: currentCarTrip,
            currentBicycleTrip: currentBicycleTrip,
            currentPublicTransportTrip: currentPublicTransportTrip,
            selectedTrip: selectedTrip,
            infoViewType: infoViewType,
            selectedDiagramType: selectedDiagramType,
            setInfoViewTypeCallback: setInfoViewTypeCallback,
            setDiagramTypeCallback: setDiagramTypeCallback,
          ),
      ],
    );
  }

  void changeLayerAndScrollUp(ContentLayer layer, ScrollController scrollController) {
    changeLayerCallback(layer);
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

enum ContentLayer { layer1, layer2 }
