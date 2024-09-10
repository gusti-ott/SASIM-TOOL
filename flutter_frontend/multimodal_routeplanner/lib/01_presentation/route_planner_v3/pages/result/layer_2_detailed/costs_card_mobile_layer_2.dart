import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/costs_category_to_image.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/layer_2_detailed/costs_details_card_layer_2.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/layer_2_detailed/values.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_content.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/ExternalCosts.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/InternalCosts.dart';

Widget costsCardMobileLayer2(BuildContext context,
    {required Trip trip,
    required CostsType costsType,
    SocialCostsCategory? socialCostsCategory,
    PersonalCostsCategory? personalCostsCategory,
    required Function(DiagramType) showInfoCallback,
    AlignmentGeometry? alignment}) {
  TextTheme textTheme = Theme.of(context).textTheme;

  String costsLabel = (socialCostsCategory != null)
      ? getSocialCostsLabel(context, socialCostsCategory: socialCostsCategory)
      : (personalCostsCategory != null)
          ? getPersonalCostsLabel(context, personalCostsCategory: personalCostsCategory)
          : '';

  double costsValue = (socialCostsCategory != null)
      ? getSocialCostsValue(socialCosts: trip.costs.externalCosts, socialCostsCategory: socialCostsCategory)
      : (personalCostsCategory != null)
          ? getPersonalCostsValue(personalCosts: trip.costs.internalCosts, personalCostsCategory: personalCostsCategory)
          : 0;

  return Align(
    alignment: alignment ?? Alignment.center,
    child: Stack(
      children: [
        Container(
          height: 120,
          width: 250,
          decoration: BoxDecoration(
            color: detailCardColor,
            borderRadius: BorderRadius.circular(cardBorderRadius),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: largePadding, vertical: mediumPadding),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                getImagePathFromCostsCategoryAndMobiScore(
                    costsType: costsType,
                    socialCostsCategory: socialCostsCategory,
                    personalCostsCategory: personalCostsCategory,
                    mobiScore: trip.mobiScore),
                fit: BoxFit.fitHeight,
              ),
              mediumHorizontalSpacer,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(costsValue.currencyString, style: textTheme.headlineSmall),
                  Text(costsLabel, style: textTheme.labelSmall),
                ],
              )
            ]),
          ),
        ),

        // info button not needed here, but might be useful in the future

        /*Positioned(
          top: 0,
          right: 0,
          child: customQuestionIcon(onTap: () {
            DiagramType diagramType = (costsType == CostsType.social) ? DiagramType.social : DiagramType.personal;
            if (costsType == CostsType.social) {
              showInfoCallback(diagramType);
            }
          }),
        ),*/
      ],
    ),
  );
}
