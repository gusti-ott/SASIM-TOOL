import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/result_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/costs_percentage_bar.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/costs_result_row.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/detail_route_info/detail_route_info_section.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/widgets/question_icons.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';

class Layer1Content extends StatelessWidget {
  const Layer1Content(
      {super.key,
      required this.selectedTrip,
      required this.setInfoViewTypeCallback,
      required this.setDiagramTypeCallback,
      required this.isMobile,
      required this.contentMaxWidth,
      required this.changeLayerCallback});

  final Trip selectedTrip;
  final Function(InfoViewType) setInfoViewTypeCallback;
  final Function(DiagramType) setDiagramTypeCallback;
  final bool isMobile;
  final double contentMaxWidth;
  final Function(ContentLayer) changeLayerCallback;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: contentMaxWidth,
      child: Column(
        children: [
          layer1Header(textTheme),
          extraLargeVerticalSpacer,
          costsPercentageBar(context, selectedTrip: selectedTrip),
          extraLargeVerticalSpacer,
          costResultRow(context, trip: selectedTrip, setDiagramType: (value) {
            setInfoViewTypeCallback(InfoViewType.diagram);
            setDiagramTypeCallback(value);
          }, isMobile: isMobile),
          extraLargeVerticalSpacer,
          customButton(
              label: 'Show detailed route information',
              onTap: () {
                changeLayerCallback(ContentLayer.layer2);
              }),
          extraLargeVerticalSpacer,
        ],
      ),
    );
  }

  SizedBox layer1Header(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: mediumPadding,
        runSpacing: mediumPadding,
        // TODO: change text to custom text
        children: [
          SizedBox(
              width: 500,
              child: Text('These are the real costs of mobility with a private car', style: textTheme.displayMedium)),
          SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  selectedTrip.costs.getFullcosts().currencyString,
                  style: textTheme.displayLarge,
                ),
                Row(
                  mainAxisAlignment: isMobile ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    Text('Full costs of the trip', style: textTheme.labelLarge),
                    smallHorizontalSpacer,
                    customQuestionIcon(onTap: () {
                      setInfoViewTypeCallback(InfoViewType.diagram);
                      setDiagramTypeCallback(DiagramType.total);
                    })
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
