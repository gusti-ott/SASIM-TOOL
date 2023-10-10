import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/table_cells/CustomAnimatedTableCell.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class ExternalCostsItem extends StatelessWidget {
  const ExternalCostsItem(
      {super.key,
      required this.selectedTrip,
      required this.animationController,
      required this.animation});

  final Trip selectedTrip;
  final AnimationController animationController;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return CustomAnimatedTableCell(
      animationController: animationController,
      animation: animation,
      selectedTrip: selectedTrip,
      child: Text(
          '${selectedTrip.costs.externalCosts.all.toStringAsFixed(2)} €',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
    );
  }
}
