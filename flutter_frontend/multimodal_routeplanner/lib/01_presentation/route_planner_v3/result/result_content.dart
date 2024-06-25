import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/input_to_trip.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/costs_percentage_bar.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/costs_result_row.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/question_icons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/score_container.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/mode_selection_components.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';

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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    double widthInfoSection = 350;
    double widthScoreColumn = 40;
    double heightScoreColumn = 400;
    double borderWidthScoreColumn = 6;

    String currentCarTripMode = getCarTripMode(isElectric: isElectric, isShared: isShared);
    Trip? currentCarTrip = trips.firstWhereOrNull((trip) => trip.mode == currentCarTripMode);
    String currentBicycleTripMode = getBicycleTripMode(isElectric: isElectric, isShared: isShared);
    Trip? currentBicycleTrip = trips.firstWhereOrNull((trip) => trip.mode == currentBicycleTripMode);
    String currentPublicTransportTripMode = getPublicTransportTripMode();
    Trip? currentPublicTransportTrip = trips.firstWhereOrNull((trip) => trip.mode == currentPublicTransportTripMode);

    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: extraLargePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1000),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              extraLargeVerticalSpacer,
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: mediumPadding),
                                child: modeSelectionRow(context,
                                    isElectric: isElectric,
                                    onElectricChanged: onElectricChanged,
                                    selectionMode: selectionMode,
                                    onSelectionModeChanged: onSelectionModeChanged,
                                    isShared: isShared,
                                    onSharedChanged: onSharedChanged),
                              ),
                              extraLargeVerticalSpacer,
                              largeVerticalSpacer,
                              Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                // TODO: change text to custom text
                                children: [
                                  SizedBox(
                                      width: 500,
                                      child: Text('These are the real costs of mobility with a private car',
                                          style: textTheme.displayMedium)),
                                  SizedBox(
                                    width: 200,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          selectedTrip.costs.getFullcosts().currencyString,
                                          style: textTheme.displayLarge,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('Full costs of the trip', style: textTheme.labelLarge),
                                            smallHorizontalSpacer,
                                            customQuestionIcon()
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              extraLargeVerticalSpacer,
                              costsPercentageBar(context, selectedTrip: selectedTrip),
                              extraLargeVerticalSpacer,
                              costResultRow(context, trip: selectedTrip),
                              extraLargeVerticalSpacer,
                            ],
                          ),
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
            ),
          ],
        ),
        Positioned(
          right: widthInfoSection - (widthScoreColumn / 2),
          bottom: (screenHeight - heightScoreColumn) / 2,
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColorV3,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: borderWidthScoreColumn),
            ),
            width: widthScoreColumn,
            height: heightScoreColumn,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: (selectedTrip.mobiScore == 'A') ? colorA : backgroundColorV3,
                    ),
                    child: Center(
                      child: Text(
                        'A',
                        style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                        color: (selectedTrip.mobiScore == 'B') ? colorB : backgroundColorV3,
                        child: Center(
                          child: Text(
                            'B',
                            style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ))),
                Expanded(
                    child: Container(
                        color: (selectedTrip.mobiScore == 'C') ? colorC : backgroundColorV3,
                        child: Center(
                          child: Text(
                            'C',
                            style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ))),
                Expanded(
                    child: Container(
                        color: (selectedTrip.mobiScore == 'D') ? colorD : backgroundColorV3,
                        child: Center(
                          child: Text(
                            'D',
                            style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ))),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: (selectedTrip.mobiScore == 'E') ? colorE : backgroundColorV3,
                    ),
                    child: Center(
                      child: Text(
                        'E',
                        style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (currentCarTrip != null)
          positionedScoreContainer(
            widthInfoSection: widthInfoSection,
            widthScoreColumn: widthScoreColumn,
            heightScoreColumn: heightScoreColumn,
            borderWidthScoreColumn: borderWidthScoreColumn,
            screenHeight: screenHeight,
            selectedTrip: selectedTrip,
            thisTrip: currentCarTrip,
          ),
        if (currentPublicTransportTrip != null)
          positionedScoreContainer(
            widthInfoSection: widthInfoSection,
            widthScoreColumn: widthScoreColumn,
            heightScoreColumn: heightScoreColumn,
            borderWidthScoreColumn: borderWidthScoreColumn,
            screenHeight: screenHeight,
            selectedTrip: selectedTrip,
            thisTrip: currentPublicTransportTrip,
          ),
        if (currentBicycleTrip != null)
          positionedScoreContainer(
            widthInfoSection: widthInfoSection,
            widthScoreColumn: widthScoreColumn,
            heightScoreColumn: heightScoreColumn,
            borderWidthScoreColumn: borderWidthScoreColumn,
            screenHeight: screenHeight,
            selectedTrip: selectedTrip,
            thisTrip: currentBicycleTrip,
          ),
      ],
    );
  }
}
