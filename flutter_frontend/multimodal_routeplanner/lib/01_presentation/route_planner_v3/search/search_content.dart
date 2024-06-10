import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/search_input_container.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

class SearchContent extends StatelessWidget {
  const SearchContent({super.key, required this.isMobile, required this.scrollController});

  final bool isMobile;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(child: desktopContent(context, screenHeight: screenHeight, screenWidth: screenWidth));
  }

  Widget desktopContent(BuildContext context, {required double screenHeight, required double screenWidth}) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: screenWidth,
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/title_image/mobiscore_header_1.png',
                fit: BoxFit.fitWidth,
              )),
          smallVerticalSpacer,
          SizedBox(
            width: 1000,
            child: Padding(
              padding: EdgeInsets.all((isMobile) ? mediumPadding : 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Learn about the real costs of mobility',
                      style: textTheme.displayMedium!.copyWith(color: primaryColorV3)),
                  mediumVerticalSpacer,
                  SearchInputContent(isMobile: isMobile),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
