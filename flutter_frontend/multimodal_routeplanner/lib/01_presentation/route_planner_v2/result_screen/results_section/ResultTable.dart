import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/CustomScrollbar.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/ModeMapingHelper.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class ResultTable extends StatefulWidget {
  const ResultTable({super.key, required this.listTrips});

  final List<Trip> listTrips;

  @override
  State<ResultTable> createState() => _ResultTableState();
}

class _ResultTableState extends State<ResultTable> {
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
              listTrips: widget.listTrips,
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
        headerItem(selectedTrip1, (selectedTrip1) {
          onDropdown1Changed(selectedTrip1);
        }),
        headerItem(selectedTrip2,
            (selectedTrip2) => onDropdown2Changed(selectedTrip2)),
        headerItem(selectedTrip3,
            (selectedTrip3) => onDropdown3Changed(selectedTrip3)),
      ],
    );
  }

  TableRow tripInfoRow(BuildContext context) {
    ModeMappingHelper modeMappingHelper = ModeMappingHelper();

    return TableRow(children: [
      const SizedBox(),
      tripInfoItem(
          modeMappingHelper.mapModeStringToIconData(selectedTrip1.mode),
          selectedTrip1),
      tripInfoItem(
          modeMappingHelper.mapModeStringToIconData(selectedTrip2.mode),
          selectedTrip2),
      tripInfoItem(
          modeMappingHelper.mapModeStringToIconData(selectedTrip3.mode),
          selectedTrip3),
    ]);
  }

  TableRow internalCostsRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      children: [
        rowHeaderItem('interne\nKosten'),
        internalCostsItem(selectedTrip1),
        internalCostsItem(selectedTrip2),
        internalCostsItem(selectedTrip3),
      ],
    );
  }

  TableRow externalCostsRow() {
    return TableRow(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
        children: [
          rowHeaderItem('externe\nKosten'),
          externalCostsItem(selectedTrip1),
          externalCostsItem(selectedTrip2),
          externalCostsItem(selectedTrip3),
        ]);
  }

  mobiScoreRow() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      children: [
        rowHeaderItem('Mobi-\nScore'),
        mobiScoreItem(selectedTrip1),
        mobiScoreItem(selectedTrip2),
        mobiScoreItem(selectedTrip3),
      ],
    );
  }

  Widget headerItem(Trip selectedTrip, void Function(Trip) onChanged) {
    ModeMappingHelper modeMappingHelper = ModeMappingHelper();
    List<String> listModes = widget.listTrips.map((trip) => trip.mode).toList();

    return TableCell(
      child: Center(
        child: DropdownButton<String>(
          alignment: Alignment.center,
          dropdownColor: Theme.of(context).colorScheme.secondary,
          value: selectedTrip.mode,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          onChanged: (value) {
            onChanged(
                widget.listTrips.firstWhere((trip) => trip.mode == value));
          },
          iconSize: 32,
          iconEnabledColor: Theme.of(context).colorScheme.onPrimary,
          items: listModes
              .map((String value) => DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: value,
                    child: Text(
                        modeMappingHelper.mapModeStringToGermanString(value)),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget tripInfoItem(IconData icon, Trip selectedTrip) {
    Color contentColor = Theme.of(context).colorScheme.onPrimary;
    TextTheme textTheme = Theme.of(context).textTheme;

    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: contentColor),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timer_outlined, color: contentColor),
                  Text(
                    "${selectedTrip.duration.toStringAsFixed(0)}'",
                    style: textTheme.titleMedium!.copyWith(color: contentColor),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.route_outlined, color: contentColor),
                  Text(
                    '${selectedTrip.distance.toStringAsFixed(1)} km',
                    style: textTheme.titleMedium!.copyWith(color: contentColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget internalCostsItem(Trip selectedTrip) {
    return TableCell(
      child: Text(
          '${selectedTrip.costs.internalCosts.all.toStringAsFixed(2)} €',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
    );
  }

  Widget externalCostsItem(Trip selectedTrip) {
    return TableCell(
      child: Text(
          '${selectedTrip.costs.externalCosts.all.toStringAsFixed(2)} €',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
    );
  }

  mobiScoreItem(Trip selectedTrip) {
    ModeMappingHelper stringMappingHelper = ModeMappingHelper();

    return TableCell(
      child: SizedBox(
        width: 100,
        height: 50,
        child: Image(
          image: stringMappingHelper
              .mapMobiScoreStringToPath(selectedTrip.mobiScore),
        ),
      ),
    );
  }

  Widget rowHeaderItem(String text) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TableCell(
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(right: BorderSide(color: colorScheme.onPrimary, width: 2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RotatedBox(
            quarterTurns: 3,
            child: Text(text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          ),
        ),
      ),
    );
  }
}
