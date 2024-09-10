import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/about_us/about_us_content.dart';
import 'package:multimodal_routeplanner/01_presentation/values/dimensions.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  static const String routeName = 'about_us';
  static const String path = 'about-us';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < mobileScreenWidthMinimum;

    return AboutUsContent(
      isMobile: isMobile,
    );
  }
}
