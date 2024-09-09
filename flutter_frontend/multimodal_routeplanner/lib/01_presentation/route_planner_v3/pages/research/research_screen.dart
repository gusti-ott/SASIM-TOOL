import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/dimensions.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/research/research_content.dart';

class ResearchScreen extends StatelessWidget {
  const ResearchScreen({super.key});

  static const String routeName = 'research';
  static const String path = 'research';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < mobileScreenWidthMinimum;

    return ResearchContent(
      isMobile: isMobile,
    );
  }
}
