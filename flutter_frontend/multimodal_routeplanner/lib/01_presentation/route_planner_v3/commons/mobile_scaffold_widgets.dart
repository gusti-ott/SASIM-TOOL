import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/custom_switch.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

AppBar mobileAppBar(GlobalKey<ScaffoldState> scaffoldKey) {
  return AppBar(
    leading: Padding(
        padding: EdgeInsets.all(smallPadding), child: Image.asset('assets/mobiscore_logos/logo_with_text_primary.png')),
    actions: [
      const LanguageSwitch(),
      IconButton(
        icon: Icon(Icons.menu, color: primaryColorV3),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      ),
    ],
    backgroundColor: Colors.white,
    foregroundColor: Colors.white,
  );
}
