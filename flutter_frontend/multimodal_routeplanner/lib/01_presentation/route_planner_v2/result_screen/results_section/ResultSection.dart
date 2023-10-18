import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/GeneralResultDiagram.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/ResultTable.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class ResultSection extends StatelessWidget {
  const ResultSection({
    super.key,
    required this.listTrips,
  });

  final List<Trip> listTrips;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ResultTable(listTrips: listTrips),
        GeneralResultDiagram(listTrips: listTrips),
      ],
    );
  }
}
