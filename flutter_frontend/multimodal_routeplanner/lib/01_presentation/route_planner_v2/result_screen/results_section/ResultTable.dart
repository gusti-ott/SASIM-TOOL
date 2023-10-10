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
    with TickerProviderStateMixin {
  late Trip selectedTrip1;
  late Trip selectedTrip2;
  late Trip selectedTrip3;

  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late AnimationController _animationController3;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();
    selectedTrip1 = widget.listTrips[0];
    selectedTrip2 = widget.listTrips[1];
    selectedTrip3 = widget.listTrips[2];

    _animationController1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation1 =
        Tween<double>(begin: 0, end: 1).animate(_animationController1);

    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation2 =
        Tween<double>(begin: 0, end: 1).animate(_animationController2);

    _animationController3 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation3 =
        Tween<double>(begin: 0, end: 1).animate(_animationController3);

    _playAnimation1();
    _playAnimation2();
    _playAnimation3();
  }

  @override
  void dispose() {
    _animationController1.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    super.dispose();
  }

  void _playAnimation1() {
    _animationController1.forward(from: 0);
  }

  void _playAnimation2() {
    _animationController2.forward(from: 0);
  }

  void _playAnimation3() {
    _animationController3.forward(from: 0);
  }

  void onDropdown1Changed(Trip value) {
    _playAnimation1();

    setState(() {
      selectedTrip1 = value;
    });
  }

  void onDropdown2Changed(Trip value) {
    _playAnimation2();
    setState(() {
      selectedTrip2 = value;
    });
  }

  void onDropdown3Changed(Trip value) {
    _playAnimation3();
    setState(() {
      selectedTrip3 = value;
    });
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
        InternalCostsItem(
            selectedTrip: selectedTrip1,
            animation: _animation1,
            animationController: _animationController1),
        InternalCostsItem(
            selectedTrip: selectedTrip2,
            animation: _animation2,
            animationController: _animationController2),
        InternalCostsItem(
            selectedTrip: selectedTrip3,
            animation: _animation3,
            animationController: _animationController3),
      ],
    );
  }

  TableRow externalCostsRow() {
    return TableRow(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
        children: [
          const RowHeaderItem(text: 'externe\nKosten'),
          ExternalCostsItem(
              selectedTrip: selectedTrip1,
              animation: _animation1,
              animationController: _animationController1),
          ExternalCostsItem(
              selectedTrip: selectedTrip2,
              animation: _animation2,
              animationController: _animationController2),
          ExternalCostsItem(
              selectedTrip: selectedTrip3,
              animation: _animation3,
              animationController: _animationController3),
        ]);
  }

  TableRow mobiScoreRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      children: [
        const RowHeaderItem(text: 'Mobi-\nScore'),
        MobiScoreItem(
            selectedTrip: selectedTrip1,
            animation: _animation1,
            animationController: _animationController1),
        MobiScoreItem(
            selectedTrip: selectedTrip2,
            animation: _animation2,
            animationController: _animationController2),
        MobiScoreItem(
            selectedTrip: selectedTrip3,
            animation: _animation3,
            animationController: _animationController3),
      ],
    );
  }
}
