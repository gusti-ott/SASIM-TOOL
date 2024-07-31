import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/question_icons.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';

Column costsResultColumn1(BuildContext context,
    {required Trip trip, required CostsType costsType, required Function() onInfoClickedCallback, isMobile = false}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  AppLocalizations lang = AppLocalizations.of(context)!;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        (costsType == CostsType.social)
            ? trip.costs.externalCosts.all.currencyString
            : trip.costs.internalCosts.all.currencyString,
        style: textTheme.headlineMedium,
      ),
      Text(
        (costsType == CostsType.social)
            ? lang.social_costs_two_line.toUpperCase()
            : lang.personal_costs_two_line.toUpperCase(),
        style: textTheme.labelLarge,
      ),
      smallVerticalSpacer,
      customQuestionIcon(
        onTap: () {
          onInfoClickedCallback();
        },
      ),
    ],
  );
}
