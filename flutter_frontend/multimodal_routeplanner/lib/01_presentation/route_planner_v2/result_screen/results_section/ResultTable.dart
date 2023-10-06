import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/mockTrips.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class ResultTable extends StatefulWidget {
  const ResultTable({super.key});

  @override
  State<ResultTable> createState() => _ResultTableState();
}

class _ResultTableState extends State<ResultTable> {
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color contentColor = colorScheme.onPrimary;

    return Container(
      width: 1600,
      color: colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ResultDataTable(
          listTrips: mockListTrips,
        ),
      ),
    );
  }
}

class ResultDataTable extends StatefulWidget {
  const ResultDataTable({super.key, required this.listTrips});

  final List<Trip> listTrips;

  @override
  State<ResultDataTable> createState() => _ResultDataTableState();
}

class _ResultDataTableState extends State<ResultDataTable> {
  late Trip selectedTrip1;
  late Trip selectedTrip2;
  late Trip selectedTrip3;

  void onDropdown1Changed(Trip value) {
    setState(() {
      selectedTrip1 = value;
    });
  }

  void onDropdown2Changed(Trip value) {
    setState(() {
      selectedTrip2 = value;
    });
  }

  void onDropdown3Changed(Trip value) {
    setState(() {
      selectedTrip3 = value;
    });
  }

  //initially set values of selectedMode1 to mode of first trip
  @override
  void initState() {
    super.initState();

    //TODO: check if the trip values are available - if not enough trips, then don't show column
    selectedTrip1 = widget.listTrips[0];
    selectedTrip2 = widget.listTrips[1];
    selectedTrip3 = widget.listTrips[2];
  }

  @override
  Widget build(BuildContext context) {
    List<String> listModes = widget.listTrips.map((trip) => trip.mode).toList();

    return DataTable(
      columns: [
        const DataColumn(label: Text('')),
        DataColumn(
          label: DropdownButton<String>(
            value: selectedTrip1.mode,
            onChanged: (value) {
              onDropdown1Changed(
                  widget.listTrips.firstWhere((trip) => trip.mode == value));
            },
            items: listModes
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
        ),
        DataColumn(
          label: DropdownButton<String>(
            value: selectedTrip2.mode,
            onChanged: (value) {
              onDropdown2Changed(
                  widget.listTrips.firstWhere((trip) => trip.mode == value));
            },
            items: listModes
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
        ),
        DataColumn(
          label: DropdownButton<String>(
            value: selectedTrip3.mode,
            onChanged: (value) {
              onDropdown3Changed(
                  widget.listTrips.firstWhere((trip) => trip.mode == value));
            },
            items: listModes
                .map((String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList(),
          ),
        ),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text('interne Kosten')),
          DataCell(Text(selectedTrip1.costs.internalCosts.all.toString())),
          DataCell(Text(selectedTrip2.costs.internalCosts.all.toString())),
          DataCell(Text(selectedTrip3.costs.internalCosts.all.toString())),
        ]),
        DataRow(cells: [
          const DataCell(Text('externe Kosten')),
          DataCell(Text(selectedTrip1.costs.externalCosts.all.toString())),
          DataCell(Text(selectedTrip2.costs.externalCosts.all.toString())),
          DataCell(Text(selectedTrip3.costs.externalCosts.all.toString())),
        ])
      ],
    );
  }
}
