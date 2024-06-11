import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/commons/mcube_logo.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/search_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/custom_switch.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/search_input_container.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

class SearchContent extends StatelessWidget {
  const SearchContent(this.state, {super.key, required this.isMobile, required this.scrollController});

  final bool isMobile;
  final ScrollController scrollController;
  final SearchState state;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
        controller: scrollController,
        child: searchContent(
          context,
          state,
          screenHeight: screenHeight,
          screenWidth: screenWidth,
        ));
  }

  Widget searchContent(BuildContext context, SearchState state,
      {required double screenHeight, required double screenWidth}) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        screenHeader(context, isMobile: isMobile),
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
                SearchInputContent(state, isMobile: isMobile),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget screenHeader(BuildContext context, {required bool isMobile}) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;

    if (isMobile) {
      return headerImage();
    } else {
      return Stack(
        children: [
          headerImage(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: largePadding, horizontal: 2 * extraLargePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/mobiscore_logos/logo_with_text_primary.png', width: 70),
                    smallHorizontalSpacer,
                    Text('by', style: textTheme.labelLarge!.copyWith(color: primaryColorV3)),
                    smallHorizontalSpacer,
                    mcubeLogo(),
                  ],
                ),
                Row(
                  children: [
                    headerButton(context, label: lang.research, onPressed: () {}),
                    largeHorizontalSpacer,
                    headerButton(context, label: lang.about_us, onPressed: () {}),
                    largeHorizontalSpacer,
                    const CustomSwitch(),
                  ],
                )
              ],
            ),
          )
        ],
      );
    }
  }

  Widget headerButton(BuildContext context, {required String label, required Function onPressed}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
        onTap: () {
          onPressed.call();
        },
        child: Text(label, style: textTheme.labelLarge!.copyWith(color: primaryColorV3)));
  }

  Widget headerImage() {
    return SizedBox(
        width: double.infinity,
        child: Image.asset(
          'assets/title_image/mobiscore_header_1.png',
          fit: BoxFit.fitWidth,
        ));
  }
}
