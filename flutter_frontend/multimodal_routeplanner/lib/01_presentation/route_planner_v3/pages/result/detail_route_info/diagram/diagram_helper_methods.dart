import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/costs_rates.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_content.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/ExternalCosts.dart';

int getGlobalPercentage(DiagramType type, Trip trip, double maxValue) {
  int globalPercentage = 0;
  if (isGeneralView(type)) {
    globalPercentage = (trip.costs.getFullcosts() / maxValue * 100).round();
  } else if (isSocialView(type)) {
    globalPercentage = (trip.costs.externalCosts.all / maxValue * 100).round();
  } else if (isPersonalView(type)) {
    globalPercentage = (trip.costs.internalCosts.all / maxValue * 100).round();
  }
  return globalPercentage;
}

int getInternalPercentage(Trip trip, DiagramType type) {
  int percentage = 0;
  if (isGeneralView(type)) {
    if (type == DiagramType.total) {
      percentage = 100;
    } else {
      int socialCostsPercentage = getSocialCostsPercentage(trip);

      if (type == DiagramType.personal) {
        percentage = 100 - socialCostsPercentage;
      } else {
        percentage = socialCostsPercentage;
      }
    }
  } else if (isSocialView(type)) {
    if (type == DiagramType.detailSocial) {
      percentage = 100;
    } else if (type == DiagramType.detailSocialTime) {
      percentage = getSocialTimeCostsPercentage(trip);
    } else if (type == DiagramType.detailSocialEnvironment) {
      percentage = getSocialEnvironmentalCostsPercentage(trip);
    } else if (type == DiagramType.detailSocialHealth) {
      percentage = getSocialHealthCostsPercentage(trip);
    }
  } else if (isPersonalView(type)) {
    if (type == DiagramType.detailPersonal) {
      percentage = 100;
    } else if (type == DiagramType.detailPersonalFixed) {
      percentage = getPrivateFixedCostsPercentage(trip);
    } else if (type == DiagramType.detailPersonalVariable) {
      percentage = getPrivateVariableCostsPercentage(trip);
    }
  }
  return percentage;
}

String getDiagramCostsValue(DiagramType type, Costs costs) {
  double costsValue = 0;

  switch (type) {
    case DiagramType.total:
      costsValue = costs.getFullcosts();
      break;
    case DiagramType.social:
    case DiagramType.detailSocial:
      costsValue = costs.externalCosts.all;
      break;
    case DiagramType.personal:
    case DiagramType.detailPersonal:
      costsValue = costs.internalCosts.all;
      break;
    case DiagramType.detailSocialTime:
      costsValue = costs.externalCosts.timeCosts;
      break;
    case DiagramType.detailSocialEnvironment:
      costsValue = costs.externalCosts.environmentCosts;
      break;
    case DiagramType.detailSocialHealth:
      costsValue = costs.externalCosts.healthCosts;
      break;
    case DiagramType.detailPersonalFixed:
      costsValue = costs.internalCosts.fixed;
      break;
    case DiagramType.detailPersonalVariable:
      costsValue = costs.internalCosts.variable;
      break;
    default:
      costsValue = 0.0;
  }

  return costsValue.currencyString;
}

double getMaxCostsValue(
    {Trip? currentCarTrip,
    Trip? currentBicycleTrip,
    Trip? currentPublicTransportTrip,
    required DiagramType diagramType}) {
  double? carValue;
  double? bicycleValue;
  double? publicTransportValue;

  if (isGeneralView(diagramType)) {
    carValue = currentCarTrip?.costs.getFullcosts();
    bicycleValue = currentBicycleTrip?.costs.getFullcosts();
    publicTransportValue = currentPublicTransportTrip?.costs.getFullcosts();
  } else if (isSocialView(diagramType)) {
    carValue = currentCarTrip?.costs.externalCosts.all;
    bicycleValue = currentBicycleTrip?.costs.externalCosts.all;
    publicTransportValue = currentPublicTransportTrip?.costs.externalCosts.all;
  } else if (isPersonalView(diagramType)) {
    carValue = currentCarTrip?.costs.internalCosts.all;
    bicycleValue = currentBicycleTrip?.costs.internalCosts.all;
    publicTransportValue = currentPublicTransportTrip?.costs.internalCosts.all;
  }

  List costs = [
    if (carValue != null) carValue,
    if (bicycleValue != null) bicycleValue,
    if (publicTransportValue != null) publicTransportValue,
  ];

  double maxValue = costs.reduce((value, element) => max(value as double, element as double));

  return maxValue;
}

String getDiagramTitle(BuildContext context, DiagramType diagramType) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  switch (diagramType) {
    case DiagramType.total:
      return lang.total_costs;
    case DiagramType.social:
      return lang.social_costs;
    case DiagramType.personal:
      return lang.personal_costs;

    case DiagramType.detailSocial:
      return lang.social_costs;
    case DiagramType.detailSocialTime:
      return lang.time_costs;
    case DiagramType.detailSocialHealth:
      return lang.health_costs;
    case DiagramType.detailSocialEnvironment:
      return lang.environment_costs;

    case DiagramType.detailPersonal:
      return lang.personal_costs;
    case DiagramType.detailPersonalFixed:
      return lang.fixed_costs;
    case DiagramType.detailPersonalVariable:
      return lang.variable_costs;

    default:
      return lang.unknown;
  }
}

String getDiagramDescription(BuildContext context, DiagramType diagramType) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  switch (diagramType) {
    case DiagramType.total:
      return lang.total_costs.toUpperCase();
    case DiagramType.social:
    case DiagramType.detailSocial:
      return lang.social_costs.toUpperCase();
    case DiagramType.personal:
    case DiagramType.detailPersonal:
      return lang.personal_costs.toUpperCase();
    case DiagramType.detailSocialTime:
      return lang.time_costs.toUpperCase();
    case DiagramType.detailSocialHealth:
      return lang.health_costs.toUpperCase();
    case DiagramType.detailSocialEnvironment:
      return lang.environment_costs.toUpperCase();
    case DiagramType.detailPersonalFixed:
      return lang.fixed_costs.toUpperCase();
    case DiagramType.detailPersonalVariable:
      return lang.variable_costs.toUpperCase();
    default:
      return lang.unknown.toUpperCase();
  }
}

String getSelectionButtonLabel(BuildContext context, DiagramType diagramType) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  switch (diagramType) {
    case DiagramType.total:
      return lang.total_costs.toUpperCase();
    case DiagramType.social:
      return lang.social.toUpperCase();
    case DiagramType.detailSocial:
      return lang.overall.toUpperCase();
    case DiagramType.personal:
      return lang.personal.toUpperCase();
    case DiagramType.detailPersonal:
      return lang.overall.toUpperCase();
    case DiagramType.detailSocialTime:
      return lang.time.toUpperCase();
    case DiagramType.detailSocialHealth:
      return lang.health.toUpperCase();
    case DiagramType.detailSocialEnvironment:
      return lang.environment.toUpperCase();
    case DiagramType.detailPersonalFixed:
      return lang.fixed.toUpperCase();
    case DiagramType.detailPersonalVariable:
      return lang.variable.toUpperCase();
    default:
      return lang.unknown.toUpperCase();
  }
}

bool isGeneralView(DiagramType selectedDiagramType) {
  return selectedDiagramType == DiagramType.total ||
      selectedDiagramType == DiagramType.social ||
      selectedDiagramType == DiagramType.personal;
}

bool isSocialView(DiagramType selectedDiagramType) {
  return selectedDiagramType == DiagramType.detailSocial ||
      selectedDiagramType == DiagramType.detailSocialTime ||
      selectedDiagramType == DiagramType.detailSocialEnvironment ||
      selectedDiagramType == DiagramType.detailSocialHealth;
}

bool isPersonalView(DiagramType selectedDiagramType) {
  return selectedDiagramType == DiagramType.detailPersonal ||
      selectedDiagramType == DiagramType.detailPersonalFixed ||
      selectedDiagramType == DiagramType.detailPersonalVariable;
}
