import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/costs_percentage_bar.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/costs_result_column_1.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/layer_2_detailed/costs_card_mobile_layer_2.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/ExternalCosts.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/InternalCosts.dart';

class Layer2ContentMobile extends StatelessWidget {
  const Layer2ContentMobile(
      {super.key,
      required this.selectedTrip,
      required this.setInfoViewTypeCallback,
      required this.setDiagramTypeCallback,
      required this.changeLayerCallback});

  final Trip selectedTrip;
  final Function(InfoViewType) setInfoViewTypeCallback;
  final Function(DiagramType) setDiagramTypeCallback;
  final Function(ContentLayer) changeLayerCallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        costsRowMobile(context, costsType: CostsType.social),
        costsPercentageBar(context, selectedTrip: selectedTrip, barType: CostsPercentageBarType.social),
        mediumVerticalSpacer,
        ...socialCostsCards(context,
            selectedTrip: selectedTrip,
            setInfoViewTypeCallback: setInfoViewTypeCallback,
            setDiagramTypeCallback: setDiagramTypeCallback),
        largeVerticalSpacer,
        costsRowMobile(context, costsType: CostsType.personal),
        costsPercentageBar(context, selectedTrip: selectedTrip, barType: CostsPercentageBarType.personal),
        mediumVerticalSpacer,
        ...personalCostsCards(context,
            selectedTrip: selectedTrip,
            setInfoViewTypeCallback: setInfoViewTypeCallback,
            setDiagramTypeCallback: setDiagramTypeCallback),
      ],
    );
  }

  SizedBox costsRowMobile(BuildContext context, {required CostsType costsType}) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            costsType == CostsType.social
                ? getAssetPathFromMobiScore(selectedTrip.mobiScore)
                : 'assets/icons/personal_null.png',
            fit: BoxFit.fitWidth,
            width: 180,
          ),
          Padding(
            padding: EdgeInsets.only(right: mediumPadding),
            child: costsResultColumn1(context, trip: selectedTrip, costsType: costsType, onInfoClickedCallback: () {
              setInfoViewTypeCallback(InfoViewType.diagram);

              setDiagramTypeCallback(
                  costsType == CostsType.social ? DiagramType.detailSocial : DiagramType.detailPersonal);
            }),
          ),
        ],
      ),
    );
  }
}

List<Widget> socialCostsCards(BuildContext context,
    {required Trip selectedTrip,
    required Function(InfoViewType) setInfoViewTypeCallback,
    required Function(DiagramType) setDiagramTypeCallback}) {
  return [
    costsCardMobileLayer2(context,
        trip: selectedTrip,
        costsType: CostsType.social,
        socialCostsCategory: SocialCostsCategory.time,
        alignment: Alignment.centerLeft, showInfoCallback: (value) {
      setInfoViewTypeCallback(InfoViewType.diagram);
      setDiagramTypeCallback(value);
    }),
    smallVerticalSpacer,
    costsCardMobileLayer2(context,
        trip: selectedTrip,
        costsType: CostsType.social,
        socialCostsCategory: SocialCostsCategory.health,
        alignment: Alignment.centerRight, showInfoCallback: (value) {
      setInfoViewTypeCallback(InfoViewType.diagram);
      setDiagramTypeCallback(value);
    }),
    smallVerticalSpacer,
    costsCardMobileLayer2(context,
        trip: selectedTrip,
        costsType: CostsType.social,
        socialCostsCategory: SocialCostsCategory.environment,
        alignment: Alignment.centerLeft, showInfoCallback: (value) {
      setInfoViewTypeCallback(InfoViewType.diagram);
      setDiagramTypeCallback(value);
    })
  ];
}

List<Widget> personalCostsCards(BuildContext context,
    {required Trip selectedTrip,
    required Function(InfoViewType) setInfoViewTypeCallback,
    required Function(DiagramType) setDiagramTypeCallback}) {
  return [
    costsCardMobileLayer2(context,
        trip: selectedTrip,
        costsType: CostsType.personal,
        personalCostsCategory: PersonalCostsCategory.fixed,
        alignment: Alignment.centerLeft, showInfoCallback: (value) {
      setInfoViewTypeCallback(InfoViewType.diagram);
      setDiagramTypeCallback(value);
    }),
    smallVerticalSpacer,
    costsCardMobileLayer2(context,
        trip: selectedTrip,
        costsType: CostsType.personal,
        personalCostsCategory: PersonalCostsCategory.variable,
        alignment: Alignment.centerRight, showInfoCallback: (value) {
      setInfoViewTypeCallback(InfoViewType.diagram);
      setDiagramTypeCallback(value);
    }),
  ];
}
