import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/layer_2_detailed/costs_card_layer_2.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/layer_2_detailed/costs_details_card_layer_2.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/costs_percentage_bar.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/share/share_screen.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';

class Layer2ContentDesktop extends StatelessWidget {
  const Layer2ContentDesktop(
      {super.key,
      required this.selectedTrip,
      required this.setInfoViewTypeCallback,
      required this.setDiagramTypeCallback,
      required this.contentMaxWidth,
      required this.changeLayerCallback,
      required this.startAddress,
      this.startCoordinates,
      required this.endAddress,
      this.endCoordinates});

  final Trip selectedTrip;
  final Function(InfoViewType) setInfoViewTypeCallback;
  final Function(DiagramType) setDiagramTypeCallback;
  final Function(ContentLayer) changeLayerCallback;
  final double contentMaxWidth;
  final String startAddress;
  final String? startCoordinates;
  final String endAddress;
  final String? endCoordinates;

  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    double heightImage = 270;
    double height = 150;
    double resultColumnWidth = 460;
    double wrapSpacing = contentMaxWidth - resultColumnWidth * 2;

    void showInfoCallback(CostsType costsType) {
      setInfoViewTypeCallback(InfoViewType.diagram);
      if (costsType == CostsType.social) {
        setDiagramTypeCallback(DiagramType.detailSocial);
      } else {
        setDiagramTypeCallback(DiagramType.detailPersonal);
      }
    }

    return SizedBox(
      width: contentMaxWidth,
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: wrapSpacing,
            runSpacing: largePadding,
            children: [
              resultColumnLayer2(
                context,
                costsType: CostsType.social,
                height: height,
                width: resultColumnWidth,
                heightImage: heightImage,
                trip: selectedTrip,
                barType: CostsPercentageBarType.social,
                showInfoCallback: (value) {
                  showInfoCallback(value);
                },
              ),
              resultColumnLayer2(
                context,
                costsType: CostsType.personal,
                height: height,
                width: resultColumnWidth,
                heightImage: heightImage,
                trip: selectedTrip,
                barType: CostsPercentageBarType.personal,
                showInfoCallback: (value) {
                  showInfoCallback(value);
                },
              ),
            ],
          ),
          extraLargeVerticalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              V3CustomButton(
                label: lang.back_to_results,
                leadingIcon: Icons.arrow_back,
                color: primaryColorV3,
                textColor: primaryColorV3,
                onTap: () {
                  changeLayerCallback(ContentLayer.layer1);
                },
                reverseColors: true,
              ),
              V3CustomButton(
                  label: lang.share,
                  leadingIcon: Icons.share,
                  onTap: () {
                    context.goNamed(ShareScreen.routeName, queryParameters: {
                      'startAddress': startAddress,
                      'endAddress': endAddress,
                      'startCoordinates': startCoordinates,
                      'endCoordinates': endCoordinates
                    });
                  }),
            ],
          ),
          extraLargeVerticalSpacer
        ],
      ),
    );
  }
}

Widget resultColumnLayer2(BuildContext context,
    {required CostsType costsType,
    required double height,
    required double width,
    required heightImage,
    required Trip trip,
    required CostsPercentageBarType barType,
    required Function(CostsType) showInfoCallback}) {
  return SizedBox(
    width: width,
    child: Column(
      children: [
        costsCardLayer2(context,
            costsType: costsType,
            height: height,
            heightImage: heightImage,
            trip: trip,
            showInfoCallback: showInfoCallback),
        mediumVerticalSpacer,
        costsPercentageBar(context, selectedTrip: trip, barType: barType),
        mediumVerticalSpacer,
        costsDetailsCardLayer2(context, selectedTrip: trip, costsType: costsType),
      ],
    ),
  );
}
