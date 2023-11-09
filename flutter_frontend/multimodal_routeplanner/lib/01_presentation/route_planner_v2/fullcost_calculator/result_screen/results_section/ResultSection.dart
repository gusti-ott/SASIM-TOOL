import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/ResultTable.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/general_result_diagram/MainResultDiagram.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class ResultSection extends StatefulWidget {
  const ResultSection({
    super.key,
    required this.listTrips,
  });

  final List<Trip> listTrips;

  @override
  State<ResultSection> createState() => _ResultSectionState();
}

class _ResultSectionState extends State<ResultSection> {
  late Trip trip1;
  late Trip trip2;
  late Trip trip3;

  @override
  void initState() {
    super.initState();
    trip1 = widget.listTrips[0];
    trip2 = widget.listTrips[1];
    trip3 = widget.listTrips[2];
  }

  void updateTrip1(Trip trip) {
    setState(() {
      trip1 = trip;
    });
  }

  void updateTrip2(Trip trip) {
    setState(() {
      trip2 = trip;
    });
  }

  void updateTrip3(Trip trip) {
    setState(() {
      trip3 = trip;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        mediumVerticalSpacer,
        ResultTable(
            listTrips: widget.listTrips,
            onTrip1ChangedCallback: updateTrip1,
            onTrip2ChangedCallback: updateTrip2,
            onTrip3ChangedCallback: updateTrip3),
        extraLargeVerticalSpacer,
        MainResultDiagram(
          trip1: trip1,
          trip2: trip2,
          trip3: trip3,
        ),
        extraLargeVerticalSpacer,
      ],
    );
  }
}
