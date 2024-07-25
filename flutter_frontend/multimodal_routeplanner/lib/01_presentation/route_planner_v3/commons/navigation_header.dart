import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/logos.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/about_us/about_us_screen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/research/research_screen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/custom_switch.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Widget navigationHeaderRow(BuildContext context) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: largePadding, horizontal: 2 * extraLargePadding),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        mobiScoreWithMcubeLogo(context),
        Row(
          children: [
            headerButton(context, label: lang.research, onPressed: () {
              context.goNamed(ResearchScreen.routeName);
            }),
            largeHorizontalSpacer,
            headerButton(context, label: lang.about_us, onPressed: () {
              context.goNamed(AboutUsScreen.routeName);
            }),
            largeHorizontalSpacer,
            const CustomSwitch(),
          ],
        )
      ],
    ),
  );
}

Widget headerButton(BuildContext context, {required String label, required Function onPressed}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return InkWell(
      onTap: () {
        onPressed.call();
      },
      child: Text(label, style: textTheme.labelLarge!.copyWith(color: primaryColorV3)));
}
