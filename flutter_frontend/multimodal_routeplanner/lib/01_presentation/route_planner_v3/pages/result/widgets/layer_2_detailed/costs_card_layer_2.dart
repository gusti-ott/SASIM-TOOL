import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';

Widget costsCardLayer2(BuildContext context,
    {required CostsType costsType,
    required double width,
    required double height,
    required heightImage,
    required Trip trip}) {
  double personalImageOffset = -10;
  double socialImageOffset = 20;
  TextTheme textTheme = Theme.of(context).textTheme;
  return SizedBox(
    width: width,
    height: height + heightImage / 2,
    child: Stack(
      children: [
        Positioned(
          top: heightImage / 2,
          left: 0,
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.all(mediumPadding),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.45),
              borderRadius: BorderRadius.circular(smallPadding),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IntrinsicWidth(
                  child: SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          costsType == CostsType.social ? 'SOCIAL COSTS' : 'PERSONAL COSTS',
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
                mediumHorizontalSpacer,
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: costsType == CostsType.social ? socialImageOffset : personalImageOffset,
          child: costsType == CostsType.social
              ? Image.asset(
                  getAssetPathFromMobiScore(trip.mobiScore),
                  height: heightImage,
                  width: heightImage,
                )
              : SizedBox(height: heightImage, width: heightImage, child: Image.asset('assets/icons/personal_null.png')),
        ),
      ],
    ),
  );
}
