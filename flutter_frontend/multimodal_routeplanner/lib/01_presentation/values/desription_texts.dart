import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/general_result_diagram/ExternalCostsDiagram.dart';
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
String descriptionAccidents =
    "Unfallkosten sind die Kosten, die durch bei Unfällen entstehende Personenschäden entstehen. da Sachschäden an Autos und Infrastruktur überwiegend von der Kfz-Versicherung abgedeckt oder von den Parteien, die den Schaden verursacht haben, selbst getragen werden, werden sie hier nicht berücksichtigt.";
String descriptionAir =
    "Die Berechnung der Kosten durch Luftverschmutzung umfasst verschiedene Aspekte. Dazu gehören Sachschäden, Ernteausfälle, Verlust der Biodiversität und Gesundheitsschäden.";
String descriptionNoise =
    "Die Auswirkungen von Lärm sind in verschiedenen Lebensbereichen spürbar. So verursacht Verkehrslärm Kosten für eine Volkswirtschaft in vielerlei Hinsicht.";
String descriptionSpace =
    "Der Verkehr nutzt Land in zwei verschiedenen Verkehrssituationen. Land wird für die Bewegung von Verkehr über Straßen oder Schienensysteme genutzt. Gleichzeitig beanspruchen Fahrzeuge, die nicht in Bewegung sind, Platz für das Parken.";
String descriptionCongestion =
    "Staus sind h hauptsächlich als blockierte Straßen durch Autos und andere Straßennutzer bekannt. Es gibt jedoch auch viele überlastete öffentliche Verkehrsnetze, die zu Verzögerungen führen. In beiden Fällen geht Zeit verloren, und somit entstehen Kosten.";
String descriptionBarrier =
    "Der Barriereneffekt beschreibt die Zeitverzögerung, die der motorisierte Verkehr auf aktive Formen der Mobilität ausübt. Dies kann in Form von großen Straßen sein, die Fußgänger überqueren oder umgehen müssen, um ihr Ziel zu erreichen.";
String descriptionEnvironment =
    "Kosten durch Umweltschäden Kosten durch alle Schäden, die heute und in der Zukunft durch den Klimawandel verursacht werden, und die mit Unsicherheiten verbunden sind. Sie sind abhängig vom Antriebstyp des Fahrzeugs und beinhaltet Kosten aus dem Betrieb des Fahrzeugs sowie der Herstellung von Kraftstoff und Energie";

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
      return descriptionFullcosts;
    default:
      logger.w('diagramDataType $dataType could not be mapped to a description for the diagram!');
      return "unbekannte Beschreibung";
  }
}
