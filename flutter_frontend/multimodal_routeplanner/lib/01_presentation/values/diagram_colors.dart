import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/general_result_diagram/GeneralResultDiagram.dart';
import 'package:multimodal_routeplanner/logger.dart';

Logger logger = getLogger();

const Color congestionColor = Colors.lightBlue;
const Color airColor = Colors.greenAccent;
const Color accidentsColor = Colors.redAccent;
const Color barrierColor = Colors.blueGrey;
const Color climateColor = Colors.purpleAccent;
const Color spaceColor = Colors.pink;
const Color noiseColor = Colors.orangeAccent;
const Color internalCostsColor = Colors.yellowAccent;
const Color externalCostsColor = Colors.transparent;
const Color fullCostsColor = Colors.transparent;

Color diagramDataTypeToColor(DiagramDataType diagramDataType) {
  switch (diagramDataType) {
    case DiagramDataType.congestion:
      return congestionColor;
    case DiagramDataType.air:
      return airColor;
    case DiagramDataType.accidents:
      return accidentsColor;
    case DiagramDataType.barrier:
      return barrierColor;
    case DiagramDataType.climate:
      return climateColor;
    case DiagramDataType.space:
      return spaceColor;
    case DiagramDataType.noise:
      return noiseColor;
    case DiagramDataType.internalCosts:
      return internalCostsColor;
    case DiagramDataType.externalCosts:
      return externalCostsColor;
    case DiagramDataType.fullcosts:
      return fullCostsColor;
    default:
      logger.w(
          'diagramDataType $diagramDataType could not be mapped to a color!');
      return Colors.transparent;
  }
}
