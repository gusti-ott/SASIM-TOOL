import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/dimensions.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/general_result_diagram/general_result_diagram_methods.dart';
import 'package:multimodal_routeplanner/01_presentation/values/desription_texts.dart';
import 'package:multimodal_routeplanner/01_presentation/values/diagram_colors.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class GeneralResultDiagram extends StatefulWidget {
  const GeneralResultDiagram(
      {super.key,
      required this.trip1,
      required this.trip2,
      required this.trip3});

  final Trip trip1;
  final Trip trip2;
  final Trip trip3;

  @override
  State<GeneralResultDiagram> createState() => _GeneralResultDiagramState();
}

class _GeneralResultDiagramState extends State<GeneralResultDiagram> {
  DiagramDataType currentDiagramDataType = DiagramDataType.fullcosts;

  void changeDiagramType(DiagramDataType diagramDataType) {
    setState(() {
      currentDiagramDataType = diagramDataType;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              child: Container(
                height: resultDiagramHeight,
                child: Column(
                  children: [
                    buildDiagramContainer(
                        context,
                        resultDiagramHeight / 3 * 2,
                        currentDiagramDataType,
                        widget.trip1,
                        widget.trip2,
                        widget.trip3),
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
            Container(
              height: resultDiagramHeight,
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  mainCategoryButton(context, DiagramDataType.fullcosts),
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
                        style: textTheme.titleMedium!
                            .copyWith(color: colorScheme.onPrimary),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  smallVerticalSpacer,
                  Container(
                    height: resultDiagramHeight / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              externalCostsButton(
                                  context, DiagramDataType.accidents),
                              smallVerticalSpacer,
                              externalCostsButton(context, DiagramDataType.air),
                              smallVerticalSpacer,
                              externalCostsButton(
                                  context, DiagramDataType.noise),
                              smallVerticalSpacer,
                              externalCostsButton(
                                  context, DiagramDataType.climate),
                            ],
                          ),
                        ),
                        smallHorizontalSpacer,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              externalCostsButton(
                                  context, DiagramDataType.barrier),
                              smallVerticalSpacer,
                              externalCostsButton(
                                  context, DiagramDataType.space),
                              smallVerticalSpacer,
                              externalCostsButton(
                                  context, DiagramDataType.congestion),
                              smallVerticalSpacer,
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container diagramDescriptionBox() {
    TextTheme textTheme = Theme.of(context).textTheme;

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
                titleFromDiagramDataType(currentDiagramDataType),
                style: textTheme.titleLarge,
              ),
              mediumVerticalSpacer,
              Text(
                descriptionTextFromDiagramDataType(currentDiagramDataType),
                style: textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainCategoryButton(
      BuildContext context, DiagramDataType diagramDataType) {
    return Expanded(child: legendItemButton(context, diagramDataType));
  }

  Widget externalCostsButton(
      BuildContext context, DiagramDataType diagramDataType) {
    return Expanded(
        child: SizedBox(child: legendItemButton(context, diagramDataType)));
  }

  Widget legendItemButton(
      BuildContext context, DiagramDataType diagramDataType) {
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
                  titleFromDiagramDataType(diagramDataType),
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
