import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/layer_2_detailed/values.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/question_icons.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';

Widget costsCardLayer2(BuildContext context,
    {required CostsType costsType,
    required double height,
    required heightImage,
    required Trip trip,
    required Function(CostsType) showInfoCallback}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  AppLocalizations lang = AppLocalizations.of(context)!;

  double sectionHeight = 310;
  double blankSpaceHeight = 135;

  return SizedBox(
    height: sectionHeight,
    child: Stack(
      children: [
        Positioned.fill(
          top: blankSpaceHeight,
          left: 0,
          child: Container(
            height: sectionHeight - blankSpaceHeight,
            padding: EdgeInsets.all(mediumPadding),
            decoration: BoxDecoration(
              color: detailCardColor,
              borderRadius: BorderRadius.circular(cardBorderRadius),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 140,
                child: Row(
                  children: [
                    IntrinsicWidth(
                      child: SizedBox(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              costsType == CostsType.social
                                  ? lang.social_costs_two_line.toUpperCase()
                                  : lang.personal_costs_two_line.toUpperCase(),
                              style: textTheme.labelLarge,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                            Text(
                              costsType == CostsType.social
                                  ? trip.costs.externalCosts.all.currencyString
                                  : trip.costs.internalCosts.all.currencyString,
                              style: textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20)
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: costsType == CostsType.social ? 20 : 2,
          left: costsType == CostsType.social ? 25 : 10,
          child: costsType == CostsType.social
              ? Image.asset(getAssetPathFromMobiScore(trip.mobiScore), height: 250, width: 250, fit: BoxFit.fitWidth)
              : SizedBox(
                  height: 270,
                  width: 270,
                  child: Image.asset(
                    'assets/icons/personal_null.png',
                    fit: BoxFit.fitWidth,
                  )),
        ),
        Positioned(
          right: 0,
          top: blankSpaceHeight,
          child: customQuestionIcon(onTap: () {
            showInfoCallback(costsType);
          }),
        ),
      ],
    ),
  );
}
