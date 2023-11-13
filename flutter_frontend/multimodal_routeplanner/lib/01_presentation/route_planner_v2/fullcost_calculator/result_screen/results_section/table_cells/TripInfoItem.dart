import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/ModeMapingHelper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/map/RouteMap.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/table_cells/CustomAnimatedTableCell.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class TripInfoItem extends StatelessWidget {
  const TripInfoItem(
      {super.key, required this.selectedTrip, required this.animationController, required this.animation});

  final Trip selectedTrip;
  final AnimationController animationController;
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    Color contentColor = Theme.of(context).colorScheme.onPrimary;
    TextTheme textTheme = Theme.of(context).textTheme;

    ModeMappingHelper modeMappingHelper = ModeMappingHelper();
    IconData iconData = modeMappingHelper.mapModeStringToIconData(selectedTrip.mode);

    return CustomAnimatedTableCell(
      selectedTrip: selectedTrip,
      animationController: animationController,
      animation: animation,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(iconData, size: 32, color: contentColor),
              mediumVerticalSpacer,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timer_outlined, color: contentColor),
                  Text(
                    "${selectedTrip.duration.toStringAsFixed(0)}'",
                    style: textTheme.titleMedium!.copyWith(color: contentColor),
                  ),
                  mediumHorizontalSpacer,
                  Icon(Icons.route_outlined, color: contentColor),
                  Text(
                    '${selectedTrip.distance.toStringAsFixed(1)} km',
                    style: textTheme.titleMedium!.copyWith(color: contentColor),
                  ),
                  mediumHorizontalSpacer,
                ],
              ),
              mediumVerticalSpacer,
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            content: SizedBox(width: 500, height: 500, child: RouteMap(trip: selectedTrip)),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(), child: Text('schließen'))
                            ],
                          ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map_outlined, color: contentColor),
                    Text(
                      'Route anzeigen',
                      style: textTheme.titleMedium!.copyWith(
                          color: contentColor,
                          decoration: TextDecoration.underline,
                          decorationColor: contentColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
