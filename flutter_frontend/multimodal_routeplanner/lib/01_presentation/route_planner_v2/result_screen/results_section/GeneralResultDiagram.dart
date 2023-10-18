import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/ExternalCosts.dart';

class GeneralResultDiagram extends StatefulWidget {
  const GeneralResultDiagram({super.key, required this.listTrips});

  final List<Trip> listTrips;

  //TODO: make reusable
  final Color congestionColor = Colors.lightBlue;
  final Color airColor = Colors.greenAccent;
  final Color accidentsColor = Colors.redAccent;
  final Color barrierColor = Colors.blueGrey;
  final Color climateColor = Colors.purpleAccent;
  final Color spaceColor = Colors.pink;
  final Color noiseColor = Colors.orangeAccent;

  @override
  State<GeneralResultDiagram> createState() => _GeneralResultDiagramState();
}

class _GeneralResultDiagramState extends State<GeneralResultDiagram> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: AspectRatio(
        aspectRatio: 1.66,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barsSpace = 4.0 * constraints.maxWidth / 400;
              final barsWidth = 8.0 * constraints.maxWidth / 400;
              return BarChart(
                BarChartData(
                  alignment: BarChartAlignment.center,
                  barTouchData: BarTouchData(
                    enabled: false,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: bottomTitles,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    checkToShowHorizontalLine: (value) => value % 10 == 0,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.black.withOpacity(0.1),
                      strokeWidth: 1,
                    ),
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  groupsSpace: barsSpace,
                  barGroups: getData(barsWidth, barsSpace),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<Trip> listTrips = widget.listTrips;

    const style = TextStyle(fontSize: 10);
    String text = 'kein Titel';
    switch (value.toInt()) {
      case 0:
        text = listTrips[0].mode;
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
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    final ExternalCosts externalCosts1 =
        widget.listTrips[0].costs.externalCosts;
    final ExternalCosts externalCosts2 =
        widget.listTrips[1].costs.externalCosts;
    final ExternalCosts externalCosts3 =
        widget.listTrips[2].costs.externalCosts;

    return [
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: externalCosts1.all,
            rodStackItems: [
              BarChartRodStackItem(
                  0, externalCosts1.accidents, widget.accidentsColor),
              BarChartRodStackItem(
                  externalCosts1.accidents,
                  externalCosts1.accidents + externalCosts1.air,
                  widget.airColor),
              BarChartRodStackItem(
                  externalCosts1.accidents + externalCosts1.air,
                  externalCosts1.accidents +
                      externalCosts1.air +
                      externalCosts1.barrier,
                  widget.barrierColor),
              BarChartRodStackItem(
                  externalCosts1.accidents +
                      externalCosts1.air +
                      externalCosts1.barrier,
                  externalCosts1.accidents +
                      externalCosts1.air +
                      externalCosts1.barrier +
                      externalCosts1.climate,
                  widget.climateColor),
              BarChartRodStackItem(
                  externalCosts1.accidents +
                      externalCosts1.air +
                      externalCosts1.barrier +
                      externalCosts1.climate,
                  externalCosts1.accidents +
                      externalCosts1.air +
                      externalCosts1.barrier +
                      externalCosts1.climate +
                      externalCosts1.congestion,
                  widget.congestionColor),
              BarChartRodStackItem(
                  externalCosts1.accidents +
                      externalCosts1.air +
                      externalCosts1.barrier +
                      externalCosts1.climate +
                      externalCosts1.congestion,
                  externalCosts1.accidents +
                      externalCosts1.air +
                      externalCosts1.barrier +
                      externalCosts1.climate +
                      externalCosts1.congestion +
                      externalCosts1.noise,
                  widget.noiseColor),
              BarChartRodStackItem(
                  externalCosts1.accidents +
                      externalCosts1.air +
                      externalCosts1.barrier +
                      externalCosts1.climate +
                      externalCosts1.congestion +
                      externalCosts1.noise,
                  externalCosts1.accidents +
                      externalCosts1.air +
                      externalCosts1.barrier +
                      externalCosts1.climate +
                      externalCosts1.congestion +
                      externalCosts1.noise +
                      externalCosts1.space,
                  widget.spaceColor),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
    ];
  }
}
