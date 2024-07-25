import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mode_to_x.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

enum ShapeDirection { left, right, top, bottom }

double rotationAngle = 45 * 3.1415926535897932 / 180;

Widget positionedScorePointer(
    {double widthInfoSection = 0.0,
    double heightSection = 0.0,
    required double widthScoreColumn,
    required double heightScoreColumn,
    required double borderWidthScoreColumn,
    double screenHeight = 0,
    double screenWidth = 0,
    double horizontalPadding = 0,
    required Trip selectedTrip,
    required Trip thisTrip,
    bool isMobile = false,
    bool isReversed = false,
    required Function(Trip) onTripSelected}) {
  Color mobiScoreColor = getColorFromMobiScore(thisTrip.mobiScore);
  Color backgroundColor = Colors.white;
  Color borderColor = mobiScoreColor;

  bool isLargeScoreContainer = false;
  int index = _getIndexFromMobiScore(thisTrip.mobiScore);
  ShapeDirection direction = ShapeDirection.right;
  if (isMobile) {
    direction = ShapeDirection.top;
  }

  if (selectedTrip.mode == thisTrip.mode) {
    backgroundColor = mobiScoreColor;
    isLargeScoreContainer = true;
    if (!isMobile) {
      direction = ShapeDirection.left;
    } else {
      direction = ShapeDirection.bottom;
    }
  }

  if (isReversed) {
    if (isMobile) {
      direction = ShapeDirection.bottom;
    } else {
      direction = ShapeDirection.left;
    }
  }

  return Positioned(
    right: !isMobile
        ? _getRightPositionScorePointerDesktop(
            widthInfoSection, widthScoreColumn, borderWidthScoreColumn, direction, isLargeScoreContainer, isReversed)
        : null,
    top: !isMobile
        ? _getTopPositionScorePointerDesktop(
            screenHeight, heightScoreColumn, borderWidthScoreColumn, isLargeScoreContainer, index)
        : _getTopPositionScorePointerMobile(
            heightSection, widthScoreColumn, borderWidthScoreColumn, isLargeScoreContainer, isReversed),
    left: isMobile
        ? _getLeftPositionScorePointerMobile(
            screenWidth, horizontalPadding, borderWidthScoreColumn, isLargeScoreContainer, index)
        : null,
    child: _scorePointer(
      mode: thisTrip.mode,
      borderColor: borderColor,
      backgroundColor: backgroundColor,
      direction: direction,
      isLarge: isLargeScoreContainer,
      onTap: () {
        onTripSelected(thisTrip);
      },
    ),
  );
}

Widget _scorePointer(
    {required String mode,
    required ShapeDirection direction,
    required Color backgroundColor,
    Color? borderColor,
    bool isLarge = false,
    required Function() onTap}) {
  return Transform.rotate(
    angle: rotationAngle,
    child: InkWell(
      hoverColor: Colors.transparent, // Removes the grey hover background
      splashColor: Colors.transparent, // Removes the splash effect
      onTap: () {
        onTap();
      },
      child: Container(
        width: isLarge ? largeScoreContainerWidth : smallScoreContainerWidth,
        height: isLarge ? largeScoreContainerWidth : smallScoreContainerWidth,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: borderColor != null ? Border.all(color: borderColor, width: borderWidthScoreContainer) : null,
          borderRadius: _getBorderRadius(direction),
        ),
        child: Center(
          child: Transform.rotate(angle: -rotationAngle, child: getIconFromMode(mode, size: isLarge ? 30 : 20)),
        ),
      ),
    ),
  );
}

BorderRadius _getBorderRadius(ShapeDirection direction) {
  if (direction == ShapeDirection.top) {
    return const BorderRadius.only(
        topRight: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30));
  } else if (direction == ShapeDirection.bottom) {
    return const BorderRadius.only(
        topRight: Radius.circular(30), bottomLeft: Radius.circular(30), topLeft: Radius.circular(30));
  } else if (direction == ShapeDirection.left) {
    return const BorderRadius.only(
        topRight: Radius.circular(30), bottomRight: Radius.circular(30), topLeft: Radius.circular(30));
  } else {
    return const BorderRadius.only(
        topLeft: Radius.circular(30), bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30));
  }
}

double _getTopPositionScorePointerDesktop(double screenHeight, double heightScoreColumn, double borderWidthScoreColumn,
    bool isLargeScoreContainer, int index) {
  double scoreContainerHeight =
      (isLargeScoreContainer ? largeScoreContainerWidth : smallScoreContainerWidth) + borderWidthScoreContainer;

  double partHeight = (heightScoreColumn - 2 * borderWidthScoreColumn) / 5;

  return (screenHeight - heightScoreColumn) / 2 -
      scoreContainerHeight / 2 +
      borderWidthScoreColumn +
      index * partHeight -
      partHeight / 2;
}

double _getRightPositionScorePointerDesktop(double widthInfoSection, double widthScoreColumn,
    double borderWidthScoreColumn, ShapeDirection shapeDirection, bool isLargeScoreContainer, bool isReversed) {
  double scoreContainerWidth = isLargeScoreContainer ? largeScoreContainerWidth : smallScoreContainerWidth;

  // add offset because of overlay due to rotation
  double offset = 3;
  if (isLargeScoreContainer) {
    offset = 8;
  }

  double partWidth = (widthScoreColumn) / 2;

  if (shapeDirection == ShapeDirection.left) {
    return widthInfoSection - (partWidth + scoreContainerWidth + offset);
  } else if (shapeDirection == ShapeDirection.right) {
    return widthInfoSection + partWidth + offset;
  } else {
    return widthInfoSection;
  }
}

double _getTopPositionScorePointerMobile(double sectionHeight, double widthScoreColumn, double borderWidthScoreColumn,
    bool isLargeScoreContainer, bool isReversed) {
  double position = 0.0;
  if (isLargeScoreContainer) {
    position =
        sectionHeight / 2 - largeScoreContainerWidth - widthScoreColumn / 2 - borderWidthScoreColumn - largeOffset;
  } else if (isReversed) {
    position =
        sectionHeight / 2 - smallScoreContainerWidth - widthScoreColumn / 2 - borderWidthScoreColumn - smallOffset;
  } else {
    position = sectionHeight / 2 + widthScoreColumn / 2 + borderWidthScoreColumn + smallOffset;
  }
  return position;
}

double _getLeftPositionScorePointerMobile(
    double screenWidth, double horizontalPadding, double borderWidthScoreColumn, bool isLargePointer, int index) {
  double position = 0.0;
  double partHeight = (screenWidth - 2 * horizontalPadding - 2 * borderWidthScoreColumn) / 5;

  if (isLargePointer) {
    position = partHeight * index - largeScoreContainerWidth / 2 - partHeight / 2 + borderWidthScoreColumn;
  } else {
    position = partHeight * index - smallScoreContainerWidth / 2 - partHeight / 2 + borderWidthScoreColumn;
  }
  return position;
}

int _getIndexFromMobiScore(String mobiScore) {
  if (mobiScore == 'A') {
    return 1;
  } else if (mobiScore == 'B') {
    return 2;
  } else if (mobiScore == 'C') {
    return 3;
  } else if (mobiScore == 'D') {
    return 4;
  } else if (mobiScore == 'E') {
    return 5;
  } else {
    return 0;
  }
}

double smallScoreContainerWidth = 40;
double largeScoreContainerWidth = 60;
double borderWidthScoreContainer = 4;

double smallOffset = 3;
double largeOffset = 8;
