import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/costs_percentage_bar.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/layer_2_detailed/costs_card_layer_2.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/layer_2_detailed/costs_details_card_layer_2.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
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
    AppLocalizations lang = AppLocalizations.of(context)!;
    double heightImage = isMobile ? 230 : 270;
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
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.spaceBetween,
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
                isMobile: isMobile,
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
                isMobile: isMobile,
                showInfoCallback: (value) {
                  showInfoCallback(value);
                },
              ),
            ],
          ),
          extraLargeVerticalSpacer,
          Row(
            mainAxisAlignment: (isMobile) ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
            children: [
              if (!isMobile)
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
              V3CustomButton(label: lang.share, leadingIcon: Icons.share, onTap: () {}),
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
    required bool isMobile,
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
            isMobile: isMobile,
            showInfoCallback: showInfoCallback),
        mediumVerticalSpacer,
        costsPercentageBar(context, selectedTrip: trip, barType: barType),
        mediumVerticalSpacer,
        costsDetailsCardLayer2(context, selectedTrip: trip, costsType: costsType, isMobile: isMobile),
      ],
    ),
  );
}
