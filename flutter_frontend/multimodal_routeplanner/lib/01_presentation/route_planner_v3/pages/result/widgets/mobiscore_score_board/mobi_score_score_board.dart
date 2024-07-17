import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/input_to_trip.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/mobiscore_score_board/score_pointer.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

double widthScoreColumn = 44;
double heightScoreColumn = 400;
double borderWidthScoreColumn = 6;

Widget mobiScoreScoreBoard(BuildContext context, {required Trip selectedTrip, bool isMobile = false}) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColorV3,
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white, width: borderWidthScoreColumn),
    ),
    width: !isMobile ? widthScoreColumn : double.infinity,
    height: !isMobile ? heightScoreColumn : widthScoreColumn,
    child: !isMobile
        ? Column(
            children: _listScoreSections(context, selectedTrip: selectedTrip, isMobile: isMobile),
          )
        : Row(
            children: _listScoreSections(context, selectedTrip: selectedTrip, isMobile: isMobile),
          ),
  );
}

Widget mobiScoreScoreBoardWithPointers(BuildContext context,
    {required double heightSection,
    required Trip selectedTrip,
    required Trip? currentCarTrip,
    required Trip? currentBicycleTrip,
    required Trip? currentPublicTransportTrip,
    required Function(SelectionMode) onSelectionModeChanged,
    double horizontalPadding = 0}) {
  // get screen width
  double screenWidth = MediaQuery.of(context).size.width;

  return SizedBox(
    height: heightSection,
    child: Stack(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: mobiScoreScoreBoard(context, selectedTrip: selectedTrip, isMobile: true)),
        if (currentCarTrip != null)
          positionedScorePointer(
            widthScoreColumn: widthScoreColumn,
            heightScoreColumn: heightScoreColumn,
            borderWidthScoreColumn: borderWidthScoreColumn,
            selectedTrip: selectedTrip,
            thisTrip: currentCarTrip,
            heightSection: heightSection,
            screenWidth: screenWidth,
            horizontalPadding: horizontalPadding,
            isMobile: true,
            onTripSelected: (value) {
              SelectionMode mode = getSelectionModeFromTripMode(value.mode);
              onSelectionModeChanged(mode);
            },
          ),
        if (currentBicycleTrip != null)
          positionedScorePointer(
            widthScoreColumn: widthScoreColumn,
            heightScoreColumn: heightScoreColumn,
            borderWidthScoreColumn: borderWidthScoreColumn,
            selectedTrip: selectedTrip,
            thisTrip: currentBicycleTrip,
            heightSection: heightSection,
            screenWidth: screenWidth,
            horizontalPadding: horizontalPadding,
            isMobile: true,
            onTripSelected: (value) {
              SelectionMode mode = getSelectionModeFromTripMode(value.mode);
              onSelectionModeChanged(mode);
            },
          ),
        if (currentPublicTransportTrip != null)
          positionedScorePointer(
            widthScoreColumn: widthScoreColumn,
            heightScoreColumn: heightScoreColumn,
            borderWidthScoreColumn: borderWidthScoreColumn,
            selectedTrip: selectedTrip,
            thisTrip: currentPublicTransportTrip,
            heightSection: heightSection,
            screenWidth: screenWidth,
            horizontalPadding: horizontalPadding,
            isMobile: true,
            onTripSelected: (value) {
              SelectionMode mode = getSelectionModeFromTripMode(value.mode);
              onSelectionModeChanged(mode);
            },
          ),
      ],
    ),
  );
}

List<Widget> _listScoreSections(BuildContext context, {required Trip selectedTrip, required bool isMobile}) {
  return [
    _scoreSection(context,
        selectedTrip: selectedTrip, letter: 'A', color: colorA, isFirst: true, isLast: false, isMobile: isMobile),
    _scoreSection(context,
        selectedTrip: selectedTrip, letter: 'B', color: colorB, isFirst: false, isLast: false, isMobile: isMobile),
    _scoreSection(context,
        selectedTrip: selectedTrip, letter: 'C', color: colorC, isFirst: false, isLast: false, isMobile: isMobile),
    _scoreSection(context,
        selectedTrip: selectedTrip, letter: 'D', color: colorD, isFirst: false, isLast: false, isMobile: isMobile),
    _scoreSection(context,
        selectedTrip: selectedTrip, letter: 'E', color: colorE, isFirst: false, isLast: true, isMobile: isMobile),
  ];
}

Expanded _scoreSection(BuildContext context,
    {required Trip selectedTrip,
    required String letter,
    required Color color,
    isFirst = false,
    isLast = false,
    required bool isMobile}) {
  TextTheme textTheme = Theme.of(context).textTheme;

  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: (isFirst) ? const Radius.circular(30) : const Radius.circular(0),
            topRight:
                (isFirst && !isMobile || isLast && isMobile) ? const Radius.circular(30) : const Radius.circular(0),
            bottomLeft:
                (isFirst && isMobile || isLast && !isMobile) ? const Radius.circular(30) : const Radius.circular(0),
            bottomRight: (isLast) ? const Radius.circular(30) : const Radius.circular(0)),
        color: (selectedTrip.mobiScore == letter) ? color : backgroundColorV3,
      ),
      child: Center(
        child: Text(
          letter,
          style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
