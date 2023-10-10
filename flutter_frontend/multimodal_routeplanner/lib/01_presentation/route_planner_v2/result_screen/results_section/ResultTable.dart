import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/CustomScrollbar.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/ModeMapingHelper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/table_cells/ExternalCostsItem.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/table_cells/HeaderItem.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/table_cells/InternalCostsItem.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/table_cells/MobiScoreItem.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/table_cells/RowHeaderItem.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/table_cells/TripInfoItem.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class ResultTable extends StatelessWidget {
  const ResultTable({super.key, required this.listTrips});

  final List<Trip> listTrips;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    ScrollController scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.all(64.0),
      child: CustomScrollbar(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        child: Container(
          width: 1200,
          color: colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ResultDataTable(
              listTrips: listTrips,
            ),
          ),
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

class _ResultDataTableState extends State<ResultDataTable>
    with SingleTickerProviderStateMixin {
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
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Table(
      border: TableBorder(
        verticalInside: BorderSide(color: colorScheme.onPrimary, width: 2),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(5),
        2: FlexColumnWidth(5),
        3: FlexColumnWidth(5),
      },
      children: [
        headerDropdownRow(),
        tripInfoRow(context),
        rowSpacer(),
        internalCostsRow(),
        rowSpacer(),
        externalCostsRow(),
        rowSpacer(),
        mobiScoreRow(),
      ],
    );
  }

  TableRow rowSpacer() {
    return const TableRow(children: [
      SizedBox(height: 8),
      SizedBox(height: 8),
      SizedBox(height: 8),
      SizedBox(height: 8),
    ]);
  }

  TableRow headerDropdownRow() {
    return TableRow(
      children: [
        const SizedBox(),
        HeaderItem(
            listTrips: widget.listTrips,
            selectedTrip: selectedTrip1,
            onChanged: (selectedTrip1) {
              onDropdown1Changed(selectedTrip1);
            }),
        HeaderItem(
            listTrips: widget.listTrips,
            selectedTrip: selectedTrip2,
            onChanged: (selectedTrip2) => onDropdown2Changed(selectedTrip2)),
        HeaderItem(
            listTrips: widget.listTrips,
            selectedTrip: selectedTrip3,
            onChanged: (selectedTrip3) => onDropdown3Changed(selectedTrip3)),
      ],
    );
  }

  TableRow tripInfoRow(BuildContext context) {
    ModeMappingHelper modeMappingHelper = ModeMappingHelper();

    return TableRow(children: [
      const SizedBox(),
      TripInfoItem(
          iconData:
              modeMappingHelper.mapModeStringToIconData(selectedTrip1.mode),
          selectedTrip: selectedTrip1),
      TripInfoItem(
          iconData:
              modeMappingHelper.mapModeStringToIconData(selectedTrip2.mode),
          selectedTrip: selectedTrip2),
      TripInfoItem(
          iconData:
              modeMappingHelper.mapModeStringToIconData(selectedTrip3.mode),
          selectedTrip: selectedTrip3),
    ]);
  }

  TableRow internalCostsRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      children: [
        const RowHeaderItem(text: 'interne\nKosten'),
        InternalCostsItem(selectedTrip: selectedTrip1),
        InternalCostsItem(selectedTrip: selectedTrip2),
        InternalCostsItem(selectedTrip: selectedTrip3),
      ],
    );
  }

  TableRow externalCostsRow() {
    return TableRow(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
        children: [
          const RowHeaderItem(text: 'externe\nKosten'),
          ExternalCostsItem(selectedTrip: selectedTrip1),
          ExternalCostsItem(selectedTrip: selectedTrip2),
          ExternalCostsItem(selectedTrip: selectedTrip3),
        ]);
  }

  TableRow mobiScoreRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      children: [
        const RowHeaderItem(text: 'Mobi-\nScore'),
        MobiScoreItem(selectedTrip: selectedTrip1),
        MobiScoreItem(selectedTrip: selectedTrip2),
        MobiScoreItem(selectedTrip: selectedTrip3),
      ],
    );
  }

  Widget customAnimatedBuilder(
      {required Animation animation, required Widget childWidget}) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Opacity(
            opacity: animation.value,
            child: childWidget,
          );
        });
  }
}
