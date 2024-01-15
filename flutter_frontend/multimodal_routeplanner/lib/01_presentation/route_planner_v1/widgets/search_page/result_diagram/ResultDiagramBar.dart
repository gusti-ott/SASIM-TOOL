/*
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/enums/DiagramTypeEnum.dart';

import 'DiagramHelper.dart';

class ResultDiagramBarWidget extends StatelessWidget {
  final List<Trip> trips;
  final bool animate;
  final DiagramTypeEnum diagramType;

  final DiagramHelper diagramHelper = DiagramHelper();

  ResultDiagramBarWidget(
      {Key? key,
      required this.trips,
      this.animate = false,
      required this.diagramType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      diagramHelper.createDiagramDataBar(
          trips: trips, diagramType: diagramType),
      animate: animate,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis:
          const charts.OrdinalAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
  }
}
*/
