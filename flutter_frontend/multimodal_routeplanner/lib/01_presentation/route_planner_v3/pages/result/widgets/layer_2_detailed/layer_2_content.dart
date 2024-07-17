import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/costs_percentage_bar.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';

class Layer2Content extends StatelessWidget {
  const Layer2Content(
      {super.key,
      required this.selectedTrip,
      required this.isMobile,
      required this.setInfoViewTypeCallback,
      required this.setDiagramTypeCallback,
      required this.contentMaxWidth,
      required this.changeLayerCallback});

  final Trip selectedTrip;
  final bool isMobile;
  final Function(InfoViewType) setInfoViewTypeCallback;
  final Function(DiagramType) setDiagramTypeCallback;
  final Function(ContentLayer) changeLayerCallback;
  final double contentMaxWidth;

  @override
  Widget build(BuildContext context) {
    double heightImage = 240;
    double height = 150;
    double width = 380;
    return SizedBox(
      width: contentMaxWidth,
      child: Column(
        children: [
          mediumVerticalSpacer,
          v3CustomButton(
              label: 'Back to Route Results',
              onTap: () {
                changeLayerCallback(ContentLayer.layer1);
              }),
          largeVerticalSpacer,
          Wrap(
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.spaceBetween,
            spacing: largePadding,
            runSpacing: largePadding,
            children: [
              resultColumnLayer2(context,
                  costsType: CostsType.social,
                  width: width,
                  height: height,
                  heightImage: heightImage,
                  trip: selectedTrip),
              resultColumnLayer2(context,
                  costsType: CostsType.personal,
                  width: width,
                  height: height,
                  heightImage: heightImage,
                  trip: selectedTrip),
            ],
          ),
          extraLargeVerticalSpacer,
        ],
      ),
    );
  }
}

Widget costsCardLayer2(BuildContext context,
    {required CostsType costsType,
    required double width,
    required double height,
    required heightImage,
    required Trip trip}) {
  double personalImageOffset = 25;
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
          left: costsType == CostsType.social ? 0 : -personalImageOffset,
          child: costsType == CostsType.social
              ? Image.asset(getAssetPathFromMobiScore(trip.mobiScore))
              : SizedBox(height: heightImage, child: Image.asset('assets/icons/personal_null.png')),
        ),
      ],
    ),
  );
}

Widget resultColumnLayer2(BuildContext context,
    {required CostsType costsType,
    required double width,
    required double height,
    required heightImage,
    required Trip trip}) {
  return Column(
    children: [
      costsCardLayer2(context,
          costsType: costsType, width: width, height: height, heightImage: heightImage, trip: trip),
      mediumVerticalSpacer,
      costsPercentageBar(context, selectedTrip: trip, barType: CostsPercentageBarType.personal, width: width)
    ],
  );
}

enum CostsType { personal, social }
