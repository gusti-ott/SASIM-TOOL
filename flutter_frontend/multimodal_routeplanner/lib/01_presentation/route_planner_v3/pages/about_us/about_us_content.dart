import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

class AboutUsContent extends StatelessWidget {
  const AboutUsContent({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(mediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            lang.about_us,
            style: textTheme.headlineMedium!.copyWith(color: primaryColorV3),
          ),
          smallVerticalSpacer,
          Text(
            lang.about_us_content,
            style: textTheme.bodyLarge!.copyWith(color: primaryColorV3),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
