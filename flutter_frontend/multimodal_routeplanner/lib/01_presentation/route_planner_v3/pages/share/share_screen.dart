import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/mobile_scaffold_widgets.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/nav_drawer.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/share/share_content.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key, required this.startAddress, required this.endAddress});

  static const String routeName = 'share';
  static const String path = 'share';

  final String startAddress;
  final String endAddress;

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Scaffold(
        backgroundColor: backgroundColorGreyV3,
        key: scaffoldKey,
        appBar: isMobile ? mobileAppBar(scaffoldKey) : null,
        drawer: buildDrawer(context),
        body: ShareContent(
          isMobile: isMobile,
          startAddress: startAddress,
          endAddress: endAddress,
        ));
  }
}
