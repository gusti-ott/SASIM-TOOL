import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/mode_mapping_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/table_cells/CustomAnimatedTableCell.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class MobiScoreItem extends StatelessWidget {
  const MobiScoreItem(
      {super.key,
      required this.selectedTrip,
      required this.animationController,
      required this.animation,
      this.infoCallback});

  final Trip selectedTrip;
  final AnimationController animationController;
  final Animation animation;
  final Function? infoCallback;

  @override
  Widget build(BuildContext context) {
    ModeMappingHelper stringMappingHelper = ModeMappingHelper(AppLocalizations.of(context)!);
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return CustomAnimatedTableCell(
      animation: animation,
      animationController: animationController,
      selectedTrip: selectedTrip,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 50),
          SizedBox(
            width: 100,
            height: 50,
            child: Image(
              image: stringMappingHelper.mapMobiScoreStringToPath(selectedTrip.mobiScore),
            ),
          ),
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
