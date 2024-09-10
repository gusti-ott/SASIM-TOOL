import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/mobile_scaffold_widgets.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/nav_drawer.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/navigation_header.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/v3_scaffold.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/values/dimensions.dart';

class MainScreenV3 extends StatelessWidget {
  const MainScreenV3({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < mobileScreenWidthMinimum;

    return V3Scaffold(
        backgroundColor: backgroundColorYellowV3,
        scaffoldKey: scaffoldKey,
        appBar: isMobile ? mobileAppBar(scaffoldKey) : null,
        drawer: buildDrawer(context, navigationShell: navigationShell),
        body: Stack(
          children: [
            navigationShell,
            if (!isMobile)
              Positioned(
                  top: 0, left: 0, right: 0, child: navigationHeaderRow(context, navigationShell: navigationShell))
          ],
        ));
  }
}
