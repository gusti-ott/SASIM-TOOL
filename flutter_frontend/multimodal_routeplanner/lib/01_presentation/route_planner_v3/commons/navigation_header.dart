import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/logos.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/colors_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/custom_switch.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Widget navigationHeaderRow(BuildContext context, {required StatefulNavigationShell navigationShell}) {
  AppLocalizations lang = AppLocalizations.of(context)!;

  int currentIndex = navigationShell.currentIndex;
  bool isSeachPage = currentIndex == 0;

  return Container(
    color: !isSeachPage ? backgroundColorYellowV3.darken(0.1) : Colors.transparent,
    height: 100,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: smallPadding, horizontal: 2 * extraLargePadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.all(smallPadding),
              child: mobiScoreWithMcubeLogo(context, navigationShell: navigationShell)),
          Row(
            children: [
              headerButton(context, label: lang.calculator, currentIndex: currentIndex, thisIndex: 0, onPressed: () {
                navigationShell.goBranch(0);
              }),
              largeHorizontalSpacer,
              headerButton(context, label: lang.research, currentIndex: currentIndex, thisIndex: 1, onPressed: () {
                navigationShell.goBranch(1);
              }),
              largeHorizontalSpacer,
              headerButton(context, label: lang.about_us, currentIndex: currentIndex, thisIndex: 2, onPressed: () {
                navigationShell.goBranch(2);
              }),
              largeHorizontalSpacer,
              const LanguageSwitch(),
            ],
          )
        ],
      ),
    ),
  );
}

Widget headerButton(
  BuildContext context, {
  required String label,
  required int currentIndex,
  required int thisIndex,
  required Function onPressed,
}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Container(
    decoration: (currentIndex == thisIndex)
        ?
        // only border on bottom
        BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: primaryColorV3,
                width: 1.0,
              ),
            ),
          )
        : null,
    child: Padding(
      padding: EdgeInsets.all(smallPadding),
      child: InkWell(
          onTap: () {
            onPressed.call();
          },
          child: Text(
            label,
            style: textTheme.labelLarge!
                .copyWith(color: primaryColorV3, fontWeight: currentIndex == thisIndex ? FontWeight.bold : null),
          )),
    ),
  );
}
