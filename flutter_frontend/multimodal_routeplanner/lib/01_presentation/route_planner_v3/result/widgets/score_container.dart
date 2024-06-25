import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_color.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

enum ShapeDirection { left, right, top, bottom }

double rotationAngle = 45 * 3.1415926535897932 / 180;

Widget positionedScoreContainer({
  required double widthInfoSection,
  required double widthScoreColumn,
  required double heightScoreColumn,
  required double borderWidthScoreColumn,
  required double screenHeight,
  required Trip selectedTrip,
  required Trip thisTrip,
}) {
  Color mobiScoreColor = getColorFromMobiScore(thisTrip.mobiScore);
  Color backgroundColor = Colors.white;
  Color borderColor = mobiScoreColor;

  bool isLargeScoreContainer = false;
  ShapeDirection direction = ShapeDirection.right;
  int index = getIndexFromMobiScore(thisTrip.mobiScore);
  IconData iconData = getIconDataFromTripMode(thisTrip.mode);

  if (selectedTrip.mode == thisTrip.mode) {
    backgroundColor = mobiScoreColor;
    isLargeScoreContainer = true;
    direction = ShapeDirection.left;
  }

  return Positioned(
    right: getRightPositionScoreContainer(
        widthInfoSection, widthScoreColumn, borderWidthScoreColumn, direction, isLargeScoreContainer),
    top: getTopPositionScoreContainer(
        screenHeight, heightScoreColumn, borderWidthScoreColumn, isLargeScoreContainer, index),
    child: scoreContainer(
        borderColor: borderColor,
        backgroundColor: backgroundColor,
        direction: direction,
        iconData: iconData,
        isLarge: isLargeScoreContainer),
  );
}

Widget scoreContainer(
    {required ShapeDirection direction,
    required Color backgroundColor,
    Color? borderColor,
    bool isLarge = false,
    IconData? iconData}) {
  return Transform.rotate(
    angle: rotationAngle,
    child: Container(
      width: isLarge ? largeScoreContainerWidth : smallScoreContainerWidth,
      height: isLarge ? largeScoreContainerWidth : smallScoreContainerWidth,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: borderColor != null ? Border.all(color: borderColor, width: borderWidthScoreContainer) : null,
        borderRadius: getBorderRadius(direction),
      ),
      child: Center(
        child: Transform.rotate(angle: -rotationAngle, child: Icon(iconData, size: isLarge ? 30 : 20)),
      ),
    ),
  );
}

BorderRadius getBorderRadius(ShapeDirection direction) {
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

double getTopPositionScoreContainer(double screenHeight, double heightScoreColumn, double borderWidthScoreColumn,
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

double getRightPositionScoreContainer(double widthInfoSection, double widthScoreColumn, double borderWidthScoreColumn,
    ShapeDirection shapeDirection, bool isLargeScoreContainer) {
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

int getIndexFromMobiScore(String mobiScore) {
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

IconData getIconDataFromTripMode(String mode) {
  if (mode == 'PT') {
    return Icons.directions_bus;
  } else if (mode == 'CAR') {
    return Icons.directions_car;
  } else if (mode == 'ECAR') {
    return Icons.electric_car;
  } else if (mode == 'SHARENOW') {
    return Icons.directions_car;
  } else if (mode == 'BICYCLE') {
    return Icons.pedal_bike;
  } else if (mode == 'EBICYCLE') {
    return Icons.electric_bike;
  } else if (mode == 'CAB') {
    return Icons.pedal_bike;
  } else {
    return Icons.directions_walk;
  }
}

double smallScoreContainerWidth = 40;
double largeScoreContainerWidth = 60;
double borderWidthScoreContainer = 4;
