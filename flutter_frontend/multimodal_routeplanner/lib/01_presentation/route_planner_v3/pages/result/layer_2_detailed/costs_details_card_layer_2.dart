import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/costs_category_to_image.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/layer_2_detailed/values.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/ExternalCosts.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/InternalCosts.dart';

Widget costsDetailsCardLayer2(BuildContext context, {required Trip selectedTrip, required CostsType costsType}) {
  String mobiScore = selectedTrip.mobiScore;
  return Container(
      decoration: BoxDecoration(
        color: detailCardColor,
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: mediumPadding, vertical: largePadding),
        child: Row(
          mainAxisAlignment:
              (costsType == CostsType.personal) ? MainAxisAlignment.spaceAround : MainAxisAlignment.spaceBetween,
          children: [
            if (costsType == CostsType.social) ...[
              costsDetailColumn(
                context,
                trip: selectedTrip,
                costsType: costsType,
                socialCostsCategory: SocialCostsCategory.time,
                mobiScore: mobiScore,
              ),
              costsDetailColumn(
                context,
                trip: selectedTrip,
                costsType: costsType,
                socialCostsCategory: SocialCostsCategory.health,
                mobiScore: mobiScore,
              ),
              costsDetailColumn(
                context,
                trip: selectedTrip,
                costsType: costsType,
                socialCostsCategory: SocialCostsCategory.environment,
                mobiScore: mobiScore,
              ),
            ] else if (costsType == CostsType.personal) ...[
              costsDetailColumn(
                context,
                trip: selectedTrip,
                costsType: costsType,
                personalCostsCategory: PersonalCostsCategory.fixed,
                mobiScore: mobiScore,
              ),
              costsDetailColumn(
                context,
                trip: selectedTrip,
                costsType: costsType,
                personalCostsCategory: PersonalCostsCategory.variable,
                mobiScore: mobiScore,
              ),
            ]
          ],
        ),
      ));
}

Widget costsDetailColumn(
  BuildContext context, {
  required Trip trip,
  required CostsType costsType,
  required String mobiScore,
  SocialCostsCategory? socialCostsCategory,
  PersonalCostsCategory? personalCostsCategory,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        getImagePathFromCostsCategoryAndMobiScore(
            costsType: costsType,
            mobiScore: mobiScore,
            socialCostsCategory: socialCostsCategory,
            personalCostsCategory: personalCostsCategory),
        height: 100,
        width: 100,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.error));
        },
      ),
      Text(
          (costsType == CostsType.social && socialCostsCategory != null)
              ? getSocialCostsCurrencyValue(
                  socialCosts: trip.costs.externalCosts, socialCostsCategory: socialCostsCategory)
              : (costsType == CostsType.personal && personalCostsCategory != null)
                  ? getPrivateCostsCurrencyValue(
                      personalCosts: trip.costs.internalCosts, personalCostsCategory: personalCostsCategory)
                  : '',
          style: Theme.of(context).textTheme.headlineMedium),
      smallVerticalSpacer,
      Text(
          (costsType == CostsType.social && socialCostsCategory != null)
              ? getSocialCostsLabel(context, socialCostsCategory: socialCostsCategory)
              : (costsType == CostsType.personal && personalCostsCategory != null)
                  ? getPersonalCostsLabel(context, personalCostsCategory: personalCostsCategory)
                  : '',
          style: Theme.of(context).textTheme.labelSmall),
    ],
  );
}

String getSocialCostsCurrencyValue(
    {required ExternalCosts socialCosts, required SocialCostsCategory socialCostsCategory}) {
  switch (socialCostsCategory) {
    case SocialCostsCategory.time:
      return socialCosts.timeCosts.currencyString;
    case SocialCostsCategory.health:
      return socialCosts.healthCosts.currencyString;
    case SocialCostsCategory.environment:
      return socialCosts.environmentCosts.currencyString;
  }
}

String getPrivateCostsCurrencyValue(
    {required InternalCosts personalCosts, required PersonalCostsCategory personalCostsCategory}) {
  switch (personalCostsCategory) {
    case PersonalCostsCategory.fixed:
      return personalCosts.fixed.currencyString;
    case PersonalCostsCategory.variable:
      return personalCosts.variable.currencyString;
  }
}

String getSocialCostsLabel(BuildContext context, {required SocialCostsCategory socialCostsCategory}) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  switch (socialCostsCategory) {
    case SocialCostsCategory.time:
      return lang.time.toUpperCase();
    case SocialCostsCategory.health:
      return lang.health.toUpperCase();
    case SocialCostsCategory.environment:
      return lang.environment.toUpperCase();
  }
}

String getPersonalCostsLabel(BuildContext context, {required PersonalCostsCategory personalCostsCategory}) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  switch (personalCostsCategory) {
    case PersonalCostsCategory.fixed:
      return lang.fixed.toUpperCase();
    case PersonalCostsCategory.variable:
      return lang.variable.toUpperCase();
  }
}

double getSocialCostsValue({required ExternalCosts socialCosts, required SocialCostsCategory socialCostsCategory}) {
  switch (socialCostsCategory) {
    case SocialCostsCategory.time:
      return socialCosts.timeCosts;
    case SocialCostsCategory.health:
      return socialCosts.healthCosts;
    case SocialCostsCategory.environment:
      return socialCosts.environmentCosts;
  }
}

double getPersonalCostsValue(
    {required InternalCosts personalCosts, required PersonalCostsCategory personalCostsCategory}) {
  switch (personalCostsCategory) {
    case PersonalCostsCategory.fixed:
      return personalCosts.fixed;
    case PersonalCostsCategory.variable:
      return personalCosts.variable;
  }
}
