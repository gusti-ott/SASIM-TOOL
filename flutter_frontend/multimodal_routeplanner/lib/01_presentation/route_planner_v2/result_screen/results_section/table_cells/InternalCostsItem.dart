import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class InternalCostsItem extends StatelessWidget {
  const InternalCostsItem({super.key, required this.selectedTrip});

  final Trip selectedTrip;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Text(
        '${selectedTrip.costs.internalCosts.all.toStringAsFixed(2)} €',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
