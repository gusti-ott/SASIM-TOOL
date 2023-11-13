import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/ModeMapingHelper.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class HeaderItem extends StatelessWidget {
  const HeaderItem({super.key, required this.listTrips, required this.onChanged, required this.selectedTrip});

  final List<Trip> listTrips;
  final void Function(Trip) onChanged;
  final Trip selectedTrip;

  @override
  Widget build(BuildContext context) {
    ModeMappingHelper modeMappingHelper = ModeMappingHelper();
    List<String> listModes = listTrips.map((trip) => trip.mode).toList();

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
            onChanged(listTrips.firstWhere((trip) => trip.mode == value));
          },
          icon: const Icon(Icons.compare_arrows),
          iconSize: 32,
          iconEnabledColor: Theme.of(context).colorScheme.onPrimary,
          items: listModes
              .map((String value) => DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: value,
                    child: Text(modeMappingHelper.mapModeStringToGermanString(value)),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
