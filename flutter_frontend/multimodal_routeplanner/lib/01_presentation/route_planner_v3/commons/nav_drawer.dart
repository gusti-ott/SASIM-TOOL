import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/about_us/about_us_screen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/research/research_screen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/search_screen_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Drawer buildDrawer(BuildContext context, {required StatefulNavigationShell navigationShell}) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  TextTheme textTheme = Theme.of(context).textTheme;

  int currentIndex = navigationShell.currentIndex;
  return Drawer(
    backgroundColor: backgroundColorGreyV3,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/mobiscore_logos/logo_with_text_primary.png', width: 70)),
        ),
        ListTile(
          title: Text(lang.calculator,
              style: textTheme.headlineLarge!
                  .copyWith(color: primaryColorV3, fontWeight: (currentIndex == 0) ? FontWeight.bold : null)),
          onTap: () {
            if (navigationShell != null) {
              navigationShell.goBranch(0);
            } else {
              // Handle the navigation to the Home page
              context.goNamed(SearchScreenV3.routeName); // Close the drawer
            }
          },
        ),
        ListTile(
          title: Text(lang.research,
              style: textTheme.headlineLarge!
                  .copyWith(color: primaryColorV3, fontWeight: (currentIndex == 1) ? FontWeight.bold : null)),
          onTap: () {
            if (navigationShell != null) {
              navigationShell.goBranch(1);
            } else {
              // Handle the navigation to the Home page
              context.goNamed(ResearchScreen.routeName);
            } // Close the drawer
          },
        ),
        ListTile(
          title: Text(lang.about_us,
              style: textTheme.headlineLarge!
                  .copyWith(color: primaryColorV3, fontWeight: (currentIndex == 2) ? FontWeight.bold : null)),
          onTap: () {
            if (navigationShell != null) {
              navigationShell.goBranch(2);
            } else {
              // Handle the navigation to the Settings page
              context.goNamed(AboutUsScreen.routeName);
            } // Close the drawer
          },
        ),
      ],
    ),
  );
}
