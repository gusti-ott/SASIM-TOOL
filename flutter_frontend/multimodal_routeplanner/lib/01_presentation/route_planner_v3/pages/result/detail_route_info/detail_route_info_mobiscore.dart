import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/mobiscore_score_board/mobi_score_score_board.dart';

Widget detailRouteInfoMobiscore(BuildContext context, {required isMobile}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Padding(
    padding: EdgeInsets.only(left: !isMobile ? 2 * extraLargePadding : extraLargePadding, right: extraLargePadding),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: largePadding * 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Was ist der\nMobi-Score?',
            style: textTheme.headlineMedium,
            textAlign: TextAlign.left,
          ),
          Image.asset('assets/mobiscore_logos/logo_with_text_primary.png', height: 70),
        ],
      ),
      largeVerticalSpacer,
      Text(
        'Der Mobi-Score ist eine farbcodierte Bewertungsskala, die Auskunft dazu gibt, wie Nachhaltig eine Strecke mit einem Verkehrsmittel bezüglich ihrer externen Kosten ist.',
        style: textTheme.bodyLarge,
        textAlign: TextAlign.left,
      ),
      largeVerticalSpacer,
      colorfulScoreBoard(context),
      largeVerticalSpacer,
      Text(
        'Der Mobi-Score hängt von dem gewählten Verkehrsmittel sowie der zurückgelegten Distanz ab. Diese kann bei verschiedenen Verkehrsmitteln zum Teil stark variieren. '
        '\n\nWeist ein Weg vergleichsweise hohe externe Kosten auf, so erhält diese den Mobi-Score E (rot). Weist der Weg hingegen niedrige externe Kosten auf, so erhält sie den Mobi-Score A (grün).',
        style: textTheme.bodyLarge,
        textAlign: TextAlign.left,
      ),
    ]),
  );
}
