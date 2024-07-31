import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/costs_rates.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mode_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/stacked_diagram_bar.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/ExternalCosts.dart';

class DetailRouteInfoDiagram extends StatelessWidget {
  const DetailRouteInfoDiagram(
      {super.key,
      required this.selectedDiagramType,
      this.currentCarTrip,
      this.currentBicycleTrip,
      this.currentPublicTransportTrip});

  final Trip? currentCarTrip;
  final Trip? currentBicycleTrip;
  final Trip? currentPublicTransportTrip;
  final DiagramType selectedDiagramType;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations lang = AppLocalizations.of(context)!;

    double maxCosts = getMaxCostsValue(
        currentCarTrip: currentCarTrip,
        currentBicycleTrip: currentBicycleTrip,
        currentPublicTransportTrip: currentPublicTransportTrip,
        diagramType: selectedDiagramType);

    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: 270,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentCarTrip != null)
                  stackedDiagramBar(context,
                      trip: currentCarTrip!, diagramType: selectedDiagramType, maxValue: maxCosts),
                if (currentBicycleTrip != null)
                  stackedDiagramBar(context,
                      trip: currentBicycleTrip!, diagramType: selectedDiagramType, maxValue: maxCosts),
                if (currentPublicTransportTrip != null)
                  stackedDiagramBar(context,
                      trip: currentPublicTransportTrip!, diagramType: selectedDiagramType, maxValue: maxCosts),
              ],
            ),
          ),
          const Divider(),
          Text('${getDiagramDescription(context, selectedDiagramType)} ${lang.by_mode.toUpperCase()}',
              style: textTheme.labelLarge, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

Widget diagramBar(BuildContext context,
    {required Trip trip, required DiagramType diagramType, required double maxValue}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  double width = 32;

  // indicates the height of the whole bar - highest is the fullcosts of the most expensive trip
  final int globalPercentage = getGlobalPercentage(diagramType, trip, maxValue);
  print('globalPercentage for ${trip.mode}: $globalPercentage');

  // indicates the height of the colored bar, the rest ist grey
  final int internalPercentage = getInternalPercentage(trip, diagramType);
  print('internalPercentage for ${trip.mode}: $internalPercentage');

  // costs value as string
  final String costsValue = getDiagramCostsValue(diagramType, trip.costs);

  return Column(
    children: [
      Expanded(flex: 100 - globalPercentage, child: const SizedBox()),
      Expanded(
        flex: globalPercentage,
        child: Container(
          height: double.infinity,
          width: width,
          decoration: BoxDecoration(
            color: customLightGrey,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Expanded(flex: 100 - internalPercentage, child: const SizedBox()),
              Container(
                height: width,
                decoration: BoxDecoration(
                  color: getColorFromMobiScore(trip.mobiScore),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child:
                      CircleAvatar(backgroundColor: Colors.white, radius: width / 2, child: getIconFromMode(trip.mode)),
                ),
              ),
              Expanded(
                flex: internalPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: getColorFromMobiScore(trip.mobiScore),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      smallVerticalSpacer,
      Text(costsValue, style: textTheme.labelMedium),
    ],
  );
}

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
    case DiagramType.social:
    case DiagramType.personal:
      return lang.total_costs.toUpperCase();

    case DiagramType.detailSocial:
    case DiagramType.detailSocialTime:
    case DiagramType.detailSocialHealth:
    case DiagramType.detailSocialEnvironment:
      return lang.social_costs.toUpperCase();

    case DiagramType.detailPersonal:
    case DiagramType.detailPersonalFixed:
    case DiagramType.detailPersonalVariable:
      return lang.personal_costs.toUpperCase();

    default:
      return lang.unknown.toUpperCase();
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
