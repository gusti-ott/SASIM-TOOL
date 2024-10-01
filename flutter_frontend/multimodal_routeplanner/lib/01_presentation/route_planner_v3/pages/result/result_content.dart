import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/input_to_trip.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/layer_1/layer_1_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/layer_2_detailed/layer_2_content_desktop.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/layer_2_detailed/layer_2_content_mobile.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/values.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/mobiscore_score_board/mobi_score_score_board.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/search_screen_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/mode_selection_components.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class ResultContent extends StatelessWidget {
  const ResultContent(
      {super.key,
      this.isMobile = false,
      required this.screenWidth,
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
      required this.backgroundColor,
      required this.startAddress,
      required this.endAddress,
      required this.onMobiscoreLogoPressed});

  final bool isMobile;
  final double screenWidth;
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
  final Color backgroundColor;
  final String startAddress;
  final String endAddress;
  final Function() onMobiscoreLogoPressed;

  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;

    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = largePadding;

    String currentCarTripMode = getCarTripMode(isElectric: isElectric, isShared: isShared);
    Trip? currentCarTrip = trips.firstWhereOrNull((trip) => trip.mode == currentCarTripMode);
    String currentBicycleTripMode = getBicycleTripMode(isElectric: isElectric, isShared: isShared);
    Trip? currentBicycleTrip = trips.firstWhereOrNull((trip) => trip.mode == currentBicycleTripMode);
    String currentPublicTransportTripMode = getPublicTransportTripMode();
    Trip? currentPublicTransportTrip = trips.firstWhereOrNull((trip) => trip.mode == currentPublicTransportTripMode);

    ScrollController scrollController = ScrollController();

    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        if (isMobile)
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                leading: Padding(
                  padding: EdgeInsets.all(smallPadding),
                  child: IconButton(
                      icon: const Icon(Icons.keyboard_double_arrow_left),
                      onPressed: () {
                        context.goNamed(SearchScreenV3.routeName);
                      }),
                ),
                expandedHeight: screenWidth < 340 ? 140 : 110,
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
                        left: horizontalPadding - mediumPadding,
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
                                if (contentLayer == ContentLayer.layer2details)
                                  Padding(
                                    padding: EdgeInsets.only(left: mediumPadding),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: V3CustomButton(
                                        label: lang.back_to_results,
                                        leadingIcon: Icons.arrow_back,
                                        color: primaryColorV3,
                                        textColor: primaryColorV3,
                                        onTap: () {
                                          changeLayerCallback(ContentLayer.layer1);
                                        },
                                        reverseColors: true,
                                      ),
                                    ),
                                  ),
                                if (contentLayer == ContentLayer.layer1)
                                  Layer1Content(
                                    selectedTrip: selectedTrip,
                                    currentCarTrip: currentCarTrip,
                                    currentBicycleTrip: currentBicycleTrip,
                                    currentPublicTransportTrip: currentPublicTransportTrip,
                                    onSelectionModeChanged: onSelectionModeChanged,
                                    setInfoViewTypeCallback: setInfoViewTypeCallback,
                                    setDiagramTypeCallback: setDiagramTypeCallback,
                                    isMobile: isMobile,
                                    screenWidth: screenWidth,
                                    contentMaxWidth: contentMaxWidth,
                                    changeLayerCallback: (layer) {
                                      changeLayerAndScrollUp(layer, scrollController);
                                    },
                                  )
                                else if (contentLayer == ContentLayer.layer2details)
                                  Layer2ContentMobile(
                                    selectedTrip: selectedTrip,
                                    changeLayerCallback: (layer) {
                                      changeLayerAndScrollUp(layer, scrollController);
                                    },
                                    setInfoViewTypeCallback: setInfoViewTypeCallback,
                                    setDiagramTypeCallback: setDiagramTypeCallback,
                                    startAddress: startAddress,
                                    endAddress: endAddress,
                                  )
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
                              left: (contentLayer == ContentLayer.layer1)
                                  ? horizontalPadding - mediumPadding
                                  : horizontalPadding,
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
                                      padding: EdgeInsets.symmetric(horizontal: mediumPadding, vertical: largePadding),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            child: IconButton(
                                                icon: const Icon(Icons.keyboard_double_arrow_left),
                                                onPressed: () {
                                                  context.goNamed(SearchScreenV3.routeName);
                                                }),
                                          ),
                                          if (screenWidth > 1350)
                                            modeSelectionRow(context,
                                                isElectric: isElectric,
                                                onElectricChanged: onElectricChanged,
                                                selectionMode: selectionMode,
                                                onSelectionModeChanged: onSelectionModeChanged,
                                                isShared: isShared,
                                                onSharedChanged: onSharedChanged,
                                                width: 700,
                                                backgroundColor: backgroundColor)
                                          else
                                            Expanded(
                                                child: modeSelectionRow(context,
                                                    isElectric: isElectric,
                                                    onElectricChanged: onElectricChanged,
                                                    selectionMode: selectionMode,
                                                    onSelectionModeChanged: onSelectionModeChanged,
                                                    isShared: isShared,
                                                    onSharedChanged: onSharedChanged,
                                                    width: 700,
                                                    backgroundColor: backgroundColor)),
                                          const SizedBox(width: 40),
                                        ],
                                      ),
                                    ),
                                    if (contentLayer == ContentLayer.layer1)
                                      Layer1Content(
                                        selectedTrip: selectedTrip,
                                        currentCarTrip: currentCarTrip,
                                        currentBicycleTrip: currentBicycleTrip,
                                        currentPublicTransportTrip: currentPublicTransportTrip,
                                        onSelectionModeChanged: onSelectionModeChanged,
                                        setInfoViewTypeCallback: setInfoViewTypeCallback,
                                        setDiagramTypeCallback: setDiagramTypeCallback,
                                        isMobile: isMobile,
                                        screenWidth: screenWidth,
                                        contentMaxWidth: contentMaxWidth,
                                        changeLayerCallback: (layer) {
                                          changeLayerAndScrollUp(layer, scrollController);
                                        },
                                      )
                                    else if (contentLayer == ContentLayer.layer2details)
                                      Layer2ContentDesktop(
                                        selectedTrip: selectedTrip,
                                        changeLayerCallback: (layer) {
                                          changeLayerAndScrollUp(layer, scrollController);
                                        },
                                        setInfoViewTypeCallback: setInfoViewTypeCallback,
                                        setDiagramTypeCallback: setDiagramTypeCallback,
                                        contentMaxWidth: contentMaxWidth,
                                        startAddress: startAddress,
                                        endAddress: endAddress,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    DetailRouteInfoContent(
                      currentCarTrip: currentCarTrip,
                      currentBicycleTrip: currentBicycleTrip,
                      currentPublicTransportTrip: currentPublicTransportTrip,
                      selectedTrip: selectedTrip,
                      infoViewType: infoViewType,
                      selectedDiagramType: selectedDiagramType,
                      setInfoViewTypeCallback: setInfoViewTypeCallback,
                      setDiagramTypeCallback: setDiagramTypeCallback,
                      startAddress: startAddress,
                      endAddress: endAddress,
                    ),
                  ],
                ),
              ),
            ],
          ),
        if (!isMobile)
          ...scoreBoardWithPointers(
            context,
            widthInfoSection: getWidthInfoSection(context),
            screenHeight: screenHeight,
            selectedTrip: selectedTrip,
            currentCarTrip: currentCarTrip,
            currentPublicTransportTrip: currentPublicTransportTrip,
            currentBicycleTrip: currentBicycleTrip,
            onSelectionModeChanged: onSelectionModeChanged,
            onMobiscoreLogoPressed: onMobiscoreLogoPressed,
          ),
        if (isMobile && showAdditionalMobileInfo)
          DetailRouteInfoContent(
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
            startAddress: startAddress,
            endAddress: endAddress,
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

enum ContentLayer { layer1, layer2details }
