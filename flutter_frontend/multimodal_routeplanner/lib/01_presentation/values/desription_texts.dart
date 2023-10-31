import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/general_result_diagram/GeneralResultDiagram.dart';
import 'package:multimodal_routeplanner/logger.dart';

Logger logger = getLogger();

String titleFullcosts = "Vollkosten";
String titleExternalCosts = "Externe Kosten";
String titleInternalCosts = "Interne Kosten";
String titleAccidents = "Unfälle";
String titleAir = "Luftverschmutzung";
String titleNoise = "Lärm";
String titleSpace = "Flächenverbrauch";
String titleCongestion = "Stau";
String titleBarrier = "Barriereeffekte";
String titleEnvironment = "Umweltschäden";

String descriptionFullcosts =
    "Die Gesamtkosten, die bei der Nutzung eines Verkehrsmittels entstehen, einschließlich direkter und indirekter Kosten wie Treibstoff, Wartung, Versicherung und Umweltauswirkungen.";
String descriptionExternalCosts =
    "Kosten, die durch die Nutzung eines Verkehrsmittels entstehen, aber nicht direkt von den Benutzern getragen werden. Dazu gehören Umweltschäden, Gesundheitsprobleme und soziale Kosten.";
String descriptionInternalCosts =
    "Die direkten Kosten, die von den Benutzern eines Verkehrsmittels getragen werden, wie Treibstoffkosten, Wartung und Versicherung.";
String descriptionAccidents = "Beschreibung Unfälle ...";
String descriptionAir = "Beschreibung Luftverschmutzung ...";
String descriptionNoise = "Beschreibung Lärm ...";
String descriptionSpace = "Beschreibung Flächenverbrauch ...";
String descriptionCongestion = "Beschreibung Stau ...";
String descriptionBarrier = "Beschreibung Barriereeffekte ...";
String descriptionEnvironment = "Beschreibung Umweltschäden ...";

String titleFromDiagramDataType(DiagramDataType dataType) {
  switch (dataType) {
    case DiagramDataType.congestion:
      return titleCongestion;
    case DiagramDataType.air:
      return titleAir;
    case DiagramDataType.accidents:
      return titleAccidents;
    case DiagramDataType.barrier:
      return titleBarrier;
    case DiagramDataType.climate:
      return titleEnvironment;
    case DiagramDataType.space:
      return titleSpace;
    case DiagramDataType.noise:
      return titleNoise;
    case DiagramDataType.internalCosts:
      return titleInternalCosts;
    case DiagramDataType.externalCosts:
      return titleExternalCosts;
    case DiagramDataType.fullcosts:
      return titleFullcosts;
    default:
      logger.w(
          'diagramDataType $dataType could not be mapped to a title for the diagram!');
      return "unbekannter Titel";
  }
}

String descriptionTextFromDiagramDataType(DiagramDataType dataType) {
  switch (dataType) {
    case DiagramDataType.congestion:
      return descriptionCongestion;
    case DiagramDataType.air:
      return descriptionAir;
    case DiagramDataType.accidents:
      return descriptionAccidents;
    case DiagramDataType.barrier:
      return descriptionBarrier;
    case DiagramDataType.climate:
      return descriptionEnvironment;
    case DiagramDataType.space:
      return descriptionSpace;
    case DiagramDataType.noise:
      return descriptionNoise;
    case DiagramDataType.internalCosts:
      return descriptionInternalCosts;
    case DiagramDataType.externalCosts:
      return descriptionExternalCosts;
    case DiagramDataType.fullcosts:
      return descriptionFullcosts;
    default:
      logger.w(
          'diagramDataType $dataType could not be mapped to a description for the diagram!');
      return "unbekannte Beschreibung";
  }
}
