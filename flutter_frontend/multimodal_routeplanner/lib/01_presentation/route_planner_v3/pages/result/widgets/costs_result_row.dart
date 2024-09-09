import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/costs_result_column_1.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_content.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';

Widget costResultRow(BuildContext context,
    {required Trip trip, required Function(DiagramType) setDiagramType, isMobile = false, required screenWidth}) {
  double diameter = 180;
  double width = 400;
  return SizedBox(
    width: double.infinity,
    child: Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.spaceBetween,
      spacing: largePadding,
      runSpacing: largePadding,
      children: [
        socialCostsCardLayer1(context, width: width, height: diameter, trip: trip, setDiagramType: () {
          setDiagramType(DiagramType.social);
        }, isMobile: isMobile, screenWidth: screenWidth),
        personalCostsCardLayer1(context, width: width, height: diameter, trip: trip, setDiagramType: () {
          setDiagramType(DiagramType.personal);
        }, isMobile: isMobile, screenWidth: screenWidth),
      ],
    ),
  );
}

Widget socialCostsCardLayer1(BuildContext context,
    {required double width,
    required double height,
    required Trip trip,
    required Function() setDiagramType,
    required bool isMobile,
    required double screenWidth}) {
  double responsiveSmallSize = screenWidth < 380 ? smallImageSize * screenWidth / 380 : smallImageSize;

  return SizedBox(
    width: width,
    height: height + 25,
    child: Stack(
      children: [
        Positioned.fill(
          top: 20,
          left: 40,
          bottom: 5,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.45),
              borderRadius: BorderRadius.circular(height / 2),
            ),
            padding: EdgeInsets.only(
                top: largePadding, bottom: largePadding, right: isMobile ? largePadding : largePadding * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                costsResultColumn1(context,
                    trip: trip, costsType: CostsType.social, onInfoClickedCallback: setDiagramType),
              ],
            ),
          ),
        ),
        Positioned(
          top: screenWidth < 380 ? 30 : 0,
          bottom: screenWidth < 380 ? 31 : 1,
          left: 0,
          child: Image.asset(
            fit: BoxFit.fitHeight,
            getAssetPathFromMobiScore(trip.mobiScore),
            height: isMobile ? responsiveSmallSize : largeImageSize,
          ),
        ),
      ],
    ),
  );
}

Widget personalCostsCardLayer1(BuildContext context,
    {required double width,
    required double height,
    required Trip trip,
    required Function() setDiagramType,
    required bool isMobile,
    required double screenWidth}) {
  double responsiveSmallSize = screenWidth < 380 ? smallImageSize * screenWidth / 380 : smallImageSize;

  return SizedBox(
    width: width,
    height: height + 25,
    child: Stack(
      children: [
        Positioned.fill(
          top: 20,
          left: 75,
          bottom: 5,
          child: Container(
            height: height,
            padding: EdgeInsets.only(
                top: largePadding, bottom: largePadding, right: isMobile ? largePadding : extraLargePadding),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.45),
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                costsResultColumn1(context,
                    trip: trip, costsType: CostsType.personal, onInfoClickedCallback: setDiagramType),
              ],
            ),
          ),
        ),
        Positioned(
          top: screenWidth < 380 ? 35 : 5,
          bottom: screenWidth < 380 ? 24 : -6,
          left: isMobile ? 2 : -20,
          child: Image.asset('assets/icons/personal_null.png',
              fit: BoxFit.fitHeight, height: isMobile ? responsiveSmallSize : largeImageSize),
        ),
      ],
    ),
  );
}

double smallImageSize = 130;
double largeImageSize = 220;
