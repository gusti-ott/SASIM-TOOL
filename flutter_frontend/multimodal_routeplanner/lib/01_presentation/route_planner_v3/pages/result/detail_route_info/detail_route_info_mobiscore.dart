import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/mobiscore_score_board/mobi_score_score_board.dart';

Widget detailRouteInfoMobiScore(BuildContext context, {required isMobile}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  AppLocalizations lang = AppLocalizations.of(context)!;
  return SingleChildScrollView(
    child: SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: !isMobile ? 2 * extraLargePadding : extraLargePadding, right: extraLargePadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: largePadding * 3),
          Text(
            lang.what_is_mobi_score,
            style: textTheme.headlineMedium,
            textAlign: TextAlign.left,
          ),
          largeVerticalSpacer,
          Text(
            lang.mobi_score_description_1,
            style: textTheme.bodyLarge,
            textAlign: TextAlign.left,
          ),
          largeVerticalSpacer,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/mobiscore_logos/logo_with_text_primary.png', height: 55),
              mediumHorizontalSpacer,
              Expanded(child: colorfulScoreBoard(context)),
            ],
          ),
          largeVerticalSpacer,
          Text(
            '${lang.mobi_score_description_2}\n\n${lang.mobi_score_description_3}',
            style: textTheme.bodyLarge,
            textAlign: TextAlign.left,
          ),
          largeVerticalSpacer,
        ]),
      ),
    ),
  );
}
