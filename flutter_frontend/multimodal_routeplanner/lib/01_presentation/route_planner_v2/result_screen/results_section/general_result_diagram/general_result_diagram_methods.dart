import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/ModeMapingHelper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/general_result_diagram/GeneralResultDiagram.dart';
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
    Trip trip3) {
  ModeMappingHelper modeMappingHelper = ModeMappingHelper();

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 24);
    String text = 'kein Titel';
    switch (value.toInt()) {
      case 0:
        text = modeMappingHelper.mapModeStringToGermanString(trip1.mode);
        break;
      case 1:
        text = modeMappingHelper.mapModeStringToGermanString(trip2.mode);
        break;
      case 2:
        text = modeMappingHelper.mapModeStringToGermanString(trip3.mode);
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
      double barsWidth, double barsSpace, DiagramDataType diagramDataType) {
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

  String roundNumber(double value) {
    const double threshold = 0.01;

    if (value.abs() < threshold && value > 0) {
      return '< 0.01';
    } else {
      return value.toStringAsFixed(2);
    }
  }

  BarTouchData barTouchData() {
    return BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.transparent,
        tooltipPadding: EdgeInsets.zero,
        tooltipMargin: 8,
        getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
        ) {
          return BarTooltipItem('${roundNumber(rod.toY)} €',
              Theme.of(context).textTheme.headlineMedium!);
        },
      ),
    );
  }

  return Container(
    height: resultDiagramHeight,
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const barsSpace = 32.0;
          const barsWidth = 124.0;
          return BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: calculateInterval(
                      currentDiagramDataType, trip1, trip2, trip3) *
                  6,
              barTouchData: barTouchData(),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 64,
                    getTitlesWidget: bottomTitles,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                      //set "showTitles" to true, if left die titles are needed
                      showTitles: false,
                      reservedSize: 64,
                      interval: calculateInterval(
                          currentDiagramDataType, trip1, trip2, trip3),
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
              barGroups: getData(barsWidth, barsSpace, currentDiagramDataType),
            ),
          );
        },
      ),
    ),
  );
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
      rodStackItems:
          rodStackSingleCosts(trip.costs.internalCosts.all, internalCostsColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.space) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.space,
      rodStackItems:
          rodStackSingleCosts(trip.costs.externalCosts.space, spaceColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.accidents) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.accidents,
      rodStackItems: rodStackSingleCosts(
          trip.costs.externalCosts.accidents, accidentsColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.noise) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.noise,
      rodStackItems:
          rodStackSingleCosts(trip.costs.externalCosts.noise, noiseColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.congestion) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.congestion,
      rodStackItems: rodStackSingleCosts(
          trip.costs.externalCosts.congestion, congestionColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.climate) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.climate,
      rodStackItems:
          rodStackSingleCosts(trip.costs.externalCosts.climate, climateColor),
      borderRadius: BorderRadius.zero,
      width: barsWidth,
    );
  } else if (diagramDataType == DiagramDataType.barrier) {
    return BarChartRodData(
      toY: trip.costs.externalCosts.barrier,
      rodStackItems:
          rodStackSingleCosts(trip.costs.externalCosts.barrier, barrierColor),
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
    ...rodStackExternalCosts(externalCosts),
    BarChartRodStackItem(externalCosts.all,
        externalCosts.all + internalCosts.all, internalCostsColor)
  ];
}

List<BarChartRodStackItem> rodStackExternalCosts(ExternalCosts externalCosts) {
  return [
    BarChartRodStackItem(0, externalCosts.accidents, accidentsColor),
    BarChartRodStackItem(externalCosts.accidents,
        externalCosts.accidents + externalCosts.air, airColor),
    BarChartRodStackItem(
        externalCosts.accidents + externalCosts.air,
        externalCosts.accidents + externalCosts.air + externalCosts.barrier,
        barrierColor),
    BarChartRodStackItem(
        externalCosts.accidents + externalCosts.air + externalCosts.barrier,
        externalCosts.accidents +
            externalCosts.air +
            externalCosts.barrier +
            externalCosts.climate,
        climateColor),
    BarChartRodStackItem(
        externalCosts.accidents +
            externalCosts.air +
            externalCosts.barrier +
            externalCosts.climate,
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

double calculateInterval(
    DiagramDataType diagramDataType, Trip trip1, Trip trip2, Trip trip3) {
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
    maxValue = [
      trip1.costs.externalCosts.all,
      trip2.costs.externalCosts.all,
      trip3.costs.externalCosts.all
    ].reduce(max);
  } else if (diagramDataType == DiagramDataType.internalCosts) {
    maxValue = [
      trip1.costs.internalCosts.all,
      trip2.costs.internalCosts.all,
      trip3.costs.internalCosts.all
    ].reduce(max);
  } else if (diagramDataType == DiagramDataType.space) {
    maxValue = [
      trip1.costs.externalCosts.space,
      trip2.costs.externalCosts.space,
      trip3.costs.externalCosts.space
    ].reduce(max);
  } else if (diagramDataType == DiagramDataType.accidents) {
    maxValue = [
      trip1.costs.externalCosts.accidents,
      trip2.costs.externalCosts.accidents,
      trip3.costs.externalCosts.accidents
    ].reduce(max);
  } else if (diagramDataType == DiagramDataType.noise) {
    maxValue = [
      trip1.costs.externalCosts.noise,
      trip2.costs.externalCosts.noise,
      trip3.costs.externalCosts.noise
    ].reduce(max);
  } else if (diagramDataType == DiagramDataType.congestion) {
    maxValue = [
      trip1.costs.externalCosts.congestion,
      trip2.costs.externalCosts.congestion,
      trip3.costs.externalCosts.congestion
    ].reduce(max);
  } else if (diagramDataType == DiagramDataType.climate) {
    maxValue = [
      trip1.costs.externalCosts.climate,
      trip2.costs.externalCosts.climate,
      trip3.costs.externalCosts.climate
    ].reduce(max);
  } else if (diagramDataType == DiagramDataType.barrier) {
    maxValue = [
      trip1.costs.externalCosts.barrier,
      trip2.costs.externalCosts.barrier,
      trip3.costs.externalCosts.barrier
    ].reduce(max);
  } else if (diagramDataType == DiagramDataType.air) {
    maxValue = [
      trip1.costs.externalCosts.air,
      trip2.costs.externalCosts.air,
      trip3.costs.externalCosts.air
    ].reduce(max);
  }
  if (maxValue > 0.02) {
    interval = maxValue / segments;
  }

  return interval;
}
