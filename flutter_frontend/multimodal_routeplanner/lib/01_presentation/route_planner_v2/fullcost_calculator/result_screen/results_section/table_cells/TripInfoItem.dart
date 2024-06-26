import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/mode_mapping_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/map/RouteMap.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/table_cells/CustomAnimatedTableCell.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Segment.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/logger.dart';

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
    AppLocalizations lang = AppLocalizations.of(context)!;

    ModeMappingHelper modeMappingHelper = ModeMappingHelper(AppLocalizations.of(context)!);
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
                            content: SizedBox(
                                width: 700,
                                height: 500,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(child: RouteMap(trip: selectedTrip)),
                                    SizedBox(
                                      width: 200,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ...selectedTrip.segments
                                              .map((segment) => segmentInfo(context, segment, modeMappingHelper))
                                              .toList()
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            actions: [
                              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('schließen'))
                            ],
                          ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map_outlined, color: contentColor),
                    Text(
                      lang.show_route,
                      style: textTheme.titleMedium!.copyWith(
                          color: contentColor, decoration: TextDecoration.underline, decorationColor: contentColor),
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

  Widget segmentInfo(BuildContext context, Segment segment, ModeMappingHelper modeMappingHelper) {
    Logger logger = getLogger();
    logger.i('segment mode: ${segment.mode}');
    logger.i('segment distance: ${segment.distance}');

    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    modeMappingHelper.mapModeStringToIconData(segment.mode),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(modeMappingHelper.mapModeStringToGermanString(segment.mode),
                      style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                  Text('${segment.distance.toStringAsFixed(1)} km', style: textTheme.bodyMedium),
                  Text('${segment.duration.toStringAsFixed(0)} Minuten', style: textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
        const Divider(indent: 4),
      ],
    );
  }
}
