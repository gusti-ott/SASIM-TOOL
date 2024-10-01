import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/values.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/search_input_container.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/typography.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({super.key, required this.isMobile});

  final bool isMobile;

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
  final GlobalKey _searchInputContentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return searchContent(
      context,
      isMobile: widget.isMobile,
      screenHeight: screenHeight,
      screenWidth: screenWidth,
    );
  }

  Widget searchContent(BuildContext context,
      {required double screenHeight, required bool isMobile, required double screenWidth}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations lang = AppLocalizations.of(context)!;

    return Column(
      children: [
        headerImage(context),
        smallVerticalSpacer,
        Center(
          child: SizedBox(
            width: 1000,
            child: Padding(
              padding: EdgeInsets.all((widget.isMobile) ? mediumPadding : largePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: (!isMobile) ? heightSearchBar / 2 : 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.learn_about,
                          style: isMobile
                              ? mobileSearchHeaderTextStyle.copyWith(color: primaryColorV3)
                              : textTheme.displayMedium!.copyWith(color: primaryColorV3),
                          textAlign: TextAlign.start,
                        ),
                        smallVerticalSpacer,
                        Text(
                          lang.input_instructions,
                          style: isMobile
                              ? mobileSearchSubtitleTextStyle.copyWith(color: customBlack)
                              : textTheme.titleLarge!.copyWith(color: customBlack),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  smallVerticalSpacer,
                  SearchInputContent(key: _searchInputContentKey, isMobile: widget.isMobile),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget headerImage(BuildContext context) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  return Semantics(
    label: lang.header_image_label,
    child: Image.asset(
      'assets/title_image/mobiscore_header_1.png',
      fit: BoxFit.fitWidth,
    ),
  );
}
