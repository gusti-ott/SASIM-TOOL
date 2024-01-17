import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/general_result_diagram/ExternalCostsDiagram.dart';
import 'package:multimodal_routeplanner/logger.dart';

Logger logger = getLogger();

String titleFromDiagramDataType(AppLocalizations lang, DiagramDataType dataType) {
  switch (dataType) {
    case DiagramDataType.congestion:
      return lang.congestion;
    case DiagramDataType.air:
      return lang.air_pollution;
    case DiagramDataType.accidents:
      return lang.accidents;
    case DiagramDataType.barrier:
      return lang.barrier_effects;
    case DiagramDataType.climate:
      return lang.environmental_damages;
    case DiagramDataType.space:
      return lang.space_use;
    case DiagramDataType.noise:
      return lang.noise;
    case DiagramDataType.internalCosts:
      return lang.internal_costs;
    case DiagramDataType.externalCosts:
      return lang.external_costs;
    case DiagramDataType.fullcosts:
      return lang.fullcosts;
    default:
      logger.w('diagramDataType $dataType could not be mapped to a title for the diagram!');
      return "unbekannter Titel";
  }
}

String descriptionTextFromDiagramDataType(AppLocalizations lang, DiagramDataType dataType) {
  switch (dataType) {
    case DiagramDataType.congestion:
      return lang.description_congestion;
    case DiagramDataType.air:
      return lang.description_air;
    case DiagramDataType.accidents:
      return lang.descripton_accidents;
    case DiagramDataType.barrier:
      return lang.description_barrier;
    case DiagramDataType.climate:
      return lang.description_environment;
    case DiagramDataType.space:
      return lang.description_space;
    case DiagramDataType.noise:
      return lang.description_noise;
    case DiagramDataType.internalCosts:
      return lang.description_internal_costs;
    case DiagramDataType.externalCosts:
      return lang.description_external_costs;
    case DiagramDataType.fullcosts:
      return 'Vollkosten bla bla';
    default:
      logger.w('diagramDataType $dataType could not be mapped to a description for the diagram!');
      return "unbekannte Beschreibung";
  }
}
