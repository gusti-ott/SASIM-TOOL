import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/mode_mapping_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/general_result_diagram/ExternalCostsDiagram.dart';
import 'package:multimodal_routeplanner/01_presentation/values/desription_texts.dart';
import 'package:multimodal_routeplanner/01_presentation/values/diagram_colors.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/ExternalCosts.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/InternalCosts.dart';

Container buildDiagramContainer(
    BuildContext context,
    double resultDiagramHeight,
    DiagramDataType currentDiagramDataType,
    Trip trip1,
    Trip trip2,
    Trip trip3,
    Function(FlTouchEvent event, BarTouchResponse? barTouchResponse) touchCallback,
    int touchedBar,
    int touchedStack) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  return Container(
    height: resultDiagramHeight,
    decoration: BoxDecoration(
      color: colorScheme.onPrimary,
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const barsSpace = 32.0;
                const barsWidth = 124.0;
                return BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: calculateInterval(currentDiagramDataType, trip1, trip2, trip3) * 6,
                    barTouchData:
                        barTouchData(context, currentDiagramDataType, touchedBar, touchedStack, touchCallback),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 64,
                            getTitlesWidget: (value, meta) {
                              return bottomTitles(value, meta, trip1, trip2, trip3, context);
                            }),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                            //set "showTitles" to true, if left die titles are needed
                            showTitles: false,
                            reservedSize: 64,
                            interval: calculateInterval(currentDiagramDataType, trip1, trip2, trip3),
                            getTitlesWidget: (value, meta) {
                              return leftTitles(value, meta);
                            }),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    groupsSpace: barsSpace,
                    barGroups: getData(barsWidth, barsSpace, currentDiagramDataType, trip1, trip2, trip3),
                  ),
                );
              },
            ),
          ),
        ),
        if (currentDiagramDataType == DiagramDataType.fullcosts ||
            currentDiagramDataType == DiagramDataType.externalCosts)
          legendColumn(context, currentDiagramDataType)
      ],
    ),
  );
}

SizedBox legendColumn(BuildContext context, DiagramDataType currentDiagramDataType) {
  if (currentDiagramDataType == DiagramDataType.fullcosts) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          largeVerticalSpacer,
          legendItem(context, DiagramDataType.internalCosts),
          smallVerticalSpacer,
          legendItem(context, DiagramDataType.externalCosts),
        ],
      ),
    );
  } else if (currentDiagramDataType == DiagramDataType.externalCosts) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          largeVerticalSpacer,
          legendItem(context, DiagramDataType.space),
          smallVerticalSpacer,
          legendItem(context, DiagramDataType.noise),
          smallVerticalSpacer,
          legendItem(context, DiagramDataType.congestion),
          smallVerticalSpacer,
          legendItem(context, DiagramDataType.climate),
          smallVerticalSpacer,
          legendItem(context, DiagramDataType.barrier),
          smallVerticalSpacer,
          legendItem(context, DiagramDataType.air),
          smallVerticalSpacer,
          legendItem(context, DiagramDataType.accidents),
        ],
      ),
    );
  }
  return const SizedBox();
}

Widget legendItem(BuildContext context, DiagramDataType diagramDataType) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  String legendText = titleFromDiagramDataType(lang, diagramDataType);
  Color legendColor = diagramDataTypeToColor(diagramDataType);

  return Row(
    children: [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(color: legendColor),
      ),
      largeHorizontalSpacer,
      Text(legendText)
    ],
  );
}

Widget bottomTitles(double value, TitleMeta meta, Trip trip1, Trip trip2, Trip trip3, BuildContext context) {
  final lang = AppLocalizations.of(context)!;
  ModeMappingHelper modeMappingHelper = ModeMappingHelper(lang);
  const style = TextStyle(fontSize: 24);
  String text = 'kein Titel';
  switch (value.toInt()) {
    case 0:
      text = modeMappingHelper.mapModeStringToLocalizedString(trip1.mode);
      break;
    case 1:
      text = modeMappingHelper.mapModeStringToLocalizedString(trip2.mode);
      break;
    case 2:
      text = modeMappingHelper.mapModeStringToLocalizedString(trip3.mode);
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(text, style: style),
  );
}

Widget leftTitles(double value, TitleMeta meta) {
  if (value == meta.max) {
    return Container();
  }
  const style = TextStyle(
    fontSize: 18,
  );
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: Text(
      '${meta.formattedValue} €',
      style: style,
    ),
  );
}

List<BarChartGroupData> getData(
    double barsWidth, double barsSpace, DiagramDataType diagramDataType, Trip trip1, Trip trip2, Trip trip3) {
  return [
    BarChartGroupData(
      x: 0,
      barsSpace: barsSpace,
      barRods: [
        barChartRodData(diagramDataType, trip1),
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barsSpace: barsSpace,
      barRods: [
        barChartRodData(diagramDataType, trip2),
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barsSpace: barsSpace,
      barRods: [
        barChartRodData(diagramDataType, trip3),
      ],
      showingTooltipIndicators: [0],
    )
  ];
}

BarTouchData barTouchData(BuildContext context, DiagramDataType currentDiagramDataType, int touchedBar,
    int touchedStack, Function(FlTouchEvent event, BarTouchResponse? barTouchResponse) touchCallback) {
  ColorScheme colorScheme = Theme.of(context).colorScheme;
  TextTheme textTheme = Theme.of(context).textTheme;

  return BarTouchData(
      enabled: true,
      touchTooltipData: BarTouchTooltipData(
        maxContentWidth: double.infinity,
        tooltipBgColor: colorScheme.primaryContainer,
        tooltipPadding: const EdgeInsets.all(8),
        tooltipMargin: 8,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          String barToolTipValue = roundNumber(rod.toY);
          String? barToolTipSubtitle =
              getSubvalue(context, currentDiagramDataType, touchedBar, touchedStack, groupIndex, roundNumber, rod);

          return BarTooltipItem('$barToolTipValue €', textTheme.bodyLarge!, children: [
            TextSpan(text: barToolTipSubtitle != null ? '\n $barToolTipSubtitle' : null, style: textTheme.bodyMedium)
          ]);
        },
      ),
      touchCallback: (FlTouchEvent event, BarTouchResponse? barTouchResponse) {
        touchCallback(event, barTouchResponse);
      });
}

String? getSubvalue(BuildContext context, DiagramDataType diagramDataType, int touchedBar, int touchedStack,
    int groupIndex, String Function(double value) roundNumber, BarChartRodData rod) {
  String? subvalue;
  AppLocalizations lang = AppLocalizations.of(context)!;

  if (diagramDataType == DiagramDataType.fullcosts) {
    subvalue = getSubvalueWhenStackTouched(touchedBar, touchedStack, groupIndex, subvalue, rod);

    if (subvalue != null) {
      String leadingString = touchedStack == 0
          ? titleFromDiagramDataType(lang, DiagramDataType.externalCosts)
          : titleFromDiagramDataType(lang, DiagramDataType.internalCosts);

      subvalue = '$leadingString: $subvalue €';
    }
  } else if (diagramDataType == DiagramDataType.externalCosts) {
    subvalue = getSubvalueWhenStackTouched(touchedBar, touchedStack, groupIndex, subvalue, rod);

    if (subvalue != null) {
      String leadingString = getLeadingStringExternalCosts(context, touchedStack);
      subvalue = '$leadingString: $subvalue €';
    }
  }
  return subvalue;
}

String getLeadingStringExternalCosts(BuildContext context, int touchedStack) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  switch (touchedStack) {
    case 0:
      return titleFromDiagramDataType(lang, DiagramDataType.accidents);
    case 1:
      return titleFromDiagramDataType(lang, DiagramDataType.air);
    case 2:
      return titleFromDiagramDataType(lang, DiagramDataType.barrier);
    case 3:
      return titleFromDiagramDataType(lang, DiagramDataType.climate);
    case 4:
      return titleFromDiagramDataType(lang, DiagramDataType.congestion);
    case 5:
      return titleFromDiagramDataType(lang, DiagramDataType.noise);
    case 6:
      return titleFromDiagramDataType(lang, DiagramDataType.space);
    default:
      return 'Kategorie unbekannt';
  }
}

String? getSubvalueWhenStackTouched(
    int touchedBar, int touchedStack, int groupIndex, String? subvalue, BarChartRodData rod) {
  if (touchedBar != -1 && touchedStack != -1 && touchedBar == groupIndex) {
    subvalue = roundNumber(rod.rodStackItems[touchedStack].toY - rod.rodStackItems[touchedStack].fromY);
  }
  return subvalue;
}

BarChartRodData barChartRodData(DiagramDataType diagramDataType, Trip trip) {
  double barsWidth = 124.0;

  if (diagramDataType == DiagramDataType.fullcosts) {
    return BarChartRodData(
      toY: (trip.costs.externalCosts.all + trip.costs.internalCosts.all),
      rodStackItems: rodStackFullcosts(trip.costs),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.externalCosts) {
    ExternalCosts externalCosts = trip.costs.externalCosts;

    return BarChartRodData(
      toY: externalCosts.all,
      rodStackItems: rodStackExternalCosts(externalCosts),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.internalCosts) {
    return BarChartRodData(
      toY: trip.costs.internalCosts.all,
      rodStackItems: rodStackSingleCosts(trip.costs.internalCosts.all, internalCostsColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.space) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.space,
      rodStackItems: rodStackSingleCosts(trip.costs.externalCosts.space, spaceColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.accidents) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.accidents,
      rodStackItems: rodStackSingleCosts(trip.costs.externalCosts.accidents, accidentsColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.noise) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.noise,
      rodStackItems: rodStackSingleCosts(trip.costs.externalCosts.noise, noiseColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.congestion) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.congestion,
      rodStackItems: rodStackSingleCosts(trip.costs.externalCosts.congestion, congestionColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.climate) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.climate,
      rodStackItems: rodStackSingleCosts(trip.costs.externalCosts.climate, climateColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.barrier) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.barrier,
      rodStackItems: rodStackSingleCosts(trip.costs.externalCosts.barrier, barrierColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.air) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.air,
      rodStackItems: rodStackSingleCosts(
        trip.costs.externalCosts.air,
        airColor,
      ),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else {
    return BarChartRodData(
      toY: trip.costs.externalCosts.all + trip.costs.internalCosts.all,
      rodStackItems: rodStackFullcosts(trip.costs),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  }
}

List<BarChartRodStackItem> rodStackSingleCosts(double value, Color color) {
  return [
    BarChartRodStackItem(0, value, color),
  ];
}

List<BarChartRodStackItem> rodStackFullcosts(Costs costs) {
  ExternalCosts externalCosts = costs.externalCosts;
  InternalCosts internalCosts = costs.internalCosts;

  return [
    BarChartRodStackItem(0, externalCosts.all, externalCostsColor),
    BarChartRodStackItem(externalCosts.all, externalCosts.all + internalCosts.all, internalCostsColor)
  ];
}

List<BarChartRodStackItem> rodStackExternalCosts(ExternalCosts externalCosts) {
  return [
    BarChartRodStackItem(0, externalCosts.accidents, accidentsColor),
    BarChartRodStackItem(externalCosts.accidents, externalCosts.accidents + externalCosts.air, airColor),
    BarChartRodStackItem(externalCosts.accidents + externalCosts.air,
        externalCosts.accidents + externalCosts.air + externalCosts.barrier, barrierColor),
    BarChartRodStackItem(externalCosts.accidents + externalCosts.air + externalCosts.barrier,
        externalCosts.accidents + externalCosts.air + externalCosts.barrier + externalCosts.climate, climateColor),
    BarChartRodStackItem(
        externalCosts.accidents + externalCosts.air + externalCosts.barrier + externalCosts.climate,
        externalCosts.accidents +
            externalCosts.air +
            externalCosts.barrier +
            externalCosts.climate +
            externalCosts.congestion,
        congestionColor),
    BarChartRodStackItem(
        externalCosts.accidents +
            externalCosts.air +
            externalCosts.barrier +
            externalCosts.climate +
            externalCosts.congestion,
        externalCosts.accidents +
            externalCosts.air +
            externalCosts.barrier +
            externalCosts.climate +
            externalCosts.congestion +
            externalCosts.noise,
        noiseColor),
    BarChartRodStackItem(
        externalCosts.accidents +
            externalCosts.air +
            externalCosts.barrier +
            externalCosts.climate +
            externalCosts.congestion +
            externalCosts.noise,
        externalCosts.accidents +
            externalCosts.air +
            externalCosts.barrier +
            externalCosts.climate +
            externalCosts.congestion +
            externalCosts.noise +
            externalCosts.space,
        spaceColor),
  ];
}

double calculateInterval(DiagramDataType diagramDataType, Trip trip1, Trip trip2, Trip trip3) {
  double maxValue = 0.1;
  int segments = 5;
  double interval = maxValue / segments;

  if (diagramDataType == DiagramDataType.fullcosts) {
    maxValue = [
      trip1.costs.externalCosts.all + trip1.costs.internalCosts.all,
      trip2.costs.externalCosts.all + trip2.costs.internalCosts.all,
      trip3.costs.externalCosts.all + trip3.costs.internalCosts.all
    ].reduce(max);
  } else if (diagramDataType == DiagramDataType.externalCosts) {
    maxValue =
        [trip1.costs.externalCosts.all, trip2.costs.externalCosts.all, trip3.costs.externalCosts.all].reduce(max);
  } else if (diagramDataType == DiagramDataType.internalCosts) {
    maxValue =
        [trip1.costs.internalCosts.all, trip2.costs.internalCosts.all, trip3.costs.internalCosts.all].reduce(max);
  } else if (diagramDataType == DiagramDataType.space) {
    maxValue =
        [trip1.costs.externalCosts.space, trip2.costs.externalCosts.space, trip3.costs.externalCosts.space].reduce(max);
  } else if (diagramDataType == DiagramDataType.accidents) {
    maxValue = [
      trip1.costs.externalCosts.accidents,
      trip2.costs.externalCosts.accidents,
      trip3.costs.externalCosts.accidents
    ].reduce(max);
  } else if (diagramDataType == DiagramDataType.noise) {
    maxValue =
        [trip1.costs.externalCosts.noise, trip2.costs.externalCosts.noise, trip3.costs.externalCosts.noise].reduce(max);
  } else if (diagramDataType == DiagramDataType.congestion) {
    maxValue = [
      trip1.costs.externalCosts.congestion,
      trip2.costs.externalCosts.congestion,
      trip3.costs.externalCosts.congestion
    ].reduce(max);
  } else if (diagramDataType == DiagramDataType.climate) {
    maxValue = [trip1.costs.externalCosts.climate, trip2.costs.externalCosts.climate, trip3.costs.externalCosts.climate]
        .reduce(max);
  } else if (diagramDataType == DiagramDataType.barrier) {
    maxValue = [trip1.costs.externalCosts.barrier, trip2.costs.externalCosts.barrier, trip3.costs.externalCosts.barrier]
        .reduce(max);
  } else if (diagramDataType == DiagramDataType.air) {
    maxValue =
        [trip1.costs.externalCosts.air, trip2.costs.externalCosts.air, trip3.costs.externalCosts.air].reduce(max);
  }
  if (maxValue > 0.02) {
    interval = maxValue / segments;
  }

  return interval;
}

String roundNumber(double value) {
  const double threshold = 0.01;

  if (value.abs() < threshold && value > 0) {
    return '< 0.01';
  } else {
    return value.toStringAsFixed(2);
  }
}
