import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/01_presentation/dimensions.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/general_result_diagram/build_main_result_diagram.dart';
import 'package:multimodal_routeplanner/01_presentation/values/desription_texts.dart';
import 'package:multimodal_routeplanner/01_presentation/values/diagram_colors.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/logger.dart';

class ExternalCostsDiagram extends StatefulWidget {
  const ExternalCostsDiagram(
      {super.key, required this.trip1, required this.trip2, required this.trip3});

  final Trip trip1;
  final Trip trip2;
  final Trip trip3;

  @override
  State<ExternalCostsDiagram> createState() => _ExternalCostsDiagramState();
}

class _ExternalCostsDiagramState extends State<ExternalCostsDiagram> {
  DiagramDataType currentDiagramDataType = DiagramDataType.externalCosts;
  int touchedBar = -1;
  int touchedStack = -1;

  void changeDiagramType(DiagramDataType diagramDataType) {
    setState(() {
      currentDiagramDataType = diagramDataType;
    });
  }

  @override
  Widget build(BuildContext context) {
    Logger logger = getLogger();

    double resultDiagramHeight = 600;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: resultTablewidth,
      decoration: BoxDecoration(
        color: colorScheme.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: resultDiagramHeight,
                child: Column(
                  children: [
                    buildDiagramContainer(
                      context,
                      resultDiagramHeight / 3 * 2,
                      currentDiagramDataType,
                      widget.trip1,
                      widget.trip2,
                      widget.trip3,
                      (FlTouchEvent event, BarTouchResponse? barTouchResponse) {
                        triggerStackTouchResonse(event, barTouchResponse, logger);
                      },
                      touchedBar,
                      touchedStack,
                    ),
                    smallVerticalSpacer,
                    Expanded(
                      child: SizedBox(
                        width: resultTablewidth,
                        child: diagramDescriptionBox(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              height: resultDiagramHeight,
              width: 400,
              child: mainDiagramButtonsColumn(context, textTheme, colorScheme, resultDiagramHeight),
            )
          ],
        ),
      ),
    );
  }

  Column mainDiagramButtonsColumn(BuildContext context, TextTheme textTheme,
      ColorScheme colorScheme, double resultDiagramHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /*mainCategoryButton(context, DiagramDataType.fullcosts),
        smallVerticalSpacer,
        mainCategoryButton(context, DiagramDataType.internalCosts),
        smallVerticalSpacer,
        mainCategoryButton(context, DiagramDataType.externalCosts),
        smallVerticalSpacer,
        Row(
          children: [
            const Expanded(child: Divider()),
            Text(
              'Einzelkategorien externe Kosten',
              style:
                  textTheme.titleMedium!.copyWith(color: colorScheme.onPrimary),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        smallVerticalSpacer,*/
        SizedBox(
          height: resultDiagramHeight / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    externalCostsButton(context, DiagramDataType.externalCosts),
                    smallVerticalSpacer,
                    externalCostsButton(context, DiagramDataType.accidents),
                    smallVerticalSpacer,
                    externalCostsButton(context, DiagramDataType.air),
                    smallVerticalSpacer,
                    externalCostsButton(context, DiagramDataType.noise),
                    smallVerticalSpacer,
                  ],
                ),
              ),
              smallHorizontalSpacer,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    externalCostsButton(context, DiagramDataType.barrier),
                    smallVerticalSpacer,
                    externalCostsButton(context, DiagramDataType.space),
                    smallVerticalSpacer,
                    externalCostsButton(context, DiagramDataType.congestion),
                    smallVerticalSpacer,
                    externalCostsButton(context, DiagramDataType.climate),
                    smallVerticalSpacer,
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void triggerStackTouchResonse(
      FlTouchEvent event, BarTouchResponse? barTouchResponse, Logger logger) {
    setState(() {
      if (!event.isInterestedForInteractions ||
          barTouchResponse == null ||
          barTouchResponse.spot == null) {
        touchedBar = -1;
        touchedStack = -1;
        return;
      }
      logger.i('Set state called '
          '\n* Bar: ${barTouchResponse.spot!.touchedBarGroupIndex}'
          '\n* Rod: ${barTouchResponse.spot!.touchedRodDataIndex}'
          '\n* Stack: ${barTouchResponse.spot!.touchedStackItemIndex}');
      touchedBar = barTouchResponse.spot!.touchedBarGroupIndex;
      touchedStack = barTouchResponse.spot!.touchedStackItemIndex;
    });
  }

  Container diagramDescriptionBox() {
    TextTheme textTheme = Theme.of(context).textTheme;
    AppLocalizations lang = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                titleFromDiagramDataType(lang, currentDiagramDataType),
                style: textTheme.titleLarge,
              ),
              mediumVerticalSpacer,
              SelectableText(
                descriptionTextFromDiagramDataType(lang, currentDiagramDataType),
                style: textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainCategoryButton(BuildContext context, DiagramDataType diagramDataType) {
    return Expanded(child: legendItemButton(context, diagramDataType));
  }

  Widget externalCostsButton(BuildContext context, DiagramDataType diagramDataType) {
    return Expanded(child: SizedBox(child: legendItemButton(context, diagramDataType)));
  }

  Widget legendItemButton(BuildContext context, DiagramDataType diagramDataType) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        changeDiagramType(diagramDataType);
      },
      child: Container(
        decoration: BoxDecoration(
          color: currentDiagramDataType == diagramDataType
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              decoration: BoxDecoration(
                color: diagramDataTypeToColor(diagramDataType),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  titleFromDiagramDataType(lang, diagramDataType),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum DiagramDataType {
  externalCosts,
  internalCosts,
  fullcosts,
  accidents,
  air,
  barrier,
  climate,
  congestion,
  noise,
  space,
}
