import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/table_cells/CustomAnimatedTableCell.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class CostsItem extends StatelessWidget {
  const CostsItem(
      {super.key,
      required this.selectedTrip,
      required this.costsValue,
      required this.animationController,
      required this.animation,
      this.infoCallback});

  final Trip selectedTrip;
  final double costsValue;
  final AnimationController animationController;
  final Animation animation;
  final Function? infoCallback;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return CustomAnimatedTableCell(
      selectedTrip: selectedTrip,
      animationController: animationController,
      animation: animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (infoCallback != null)
            const SizedBox(
              width: 50,
            ),
          SizedBox(
            width: 100,
            child: Text(
              '${costsValue.toStringAsFixed(2)} €',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          if (infoCallback != null)
            SizedBox(
              width: 50,
              child: IconButton(
                icon: Icon(
                  Icons.info,
                  color: colorScheme.onPrimary,
                ),
                onPressed: () {
                  infoCallback!();
                },
              ),
            )
        ],
      ),
    );
  }
}
