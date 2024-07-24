import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_diagram.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_section.dart';

class DiagramTypeSelection extends StatelessWidget {
  const DiagramTypeSelection({super.key, required this.setDiagramType, required this.selectedDiagramType, this.height});

  final double? height;
  final Function(DiagramType) setDiagramType;
  final DiagramType selectedDiagramType;

  @override
  Widget build(BuildContext context) {
    final height = this.height ?? 80;
    return Center(
      child: SizedBox(
        width: 170,
        height: height,
        child: Column(
          children: [
            if (isGeneralView(selectedDiagramType)) ...[
              diagramTypeSelectionButton(context,
                  diagramType: DiagramType.total, selectedDiagramType: selectedDiagramType, onPressed: (value) {
                setDiagramType(value);
              }),
              smallVerticalSpacer,
              diagramTypeSelectionButton(context,
                  diagramType: DiagramType.social, selectedDiagramType: selectedDiagramType, onPressed: (value) {
                setDiagramType(value);
              }),
              smallVerticalSpacer,
              diagramTypeSelectionButton(context,
                  diagramType: DiagramType.personal, selectedDiagramType: selectedDiagramType, onPressed: (value) {
                setDiagramType(value);
              }),
            ] else if (isSocialView(selectedDiagramType)) ...[
              diagramTypeSelectionButton(context,
                  diagramType: DiagramType.detailSocial, selectedDiagramType: selectedDiagramType, onPressed: (value) {
                setDiagramType(value);
              }),
              diagramTypeSelectionButton(context,
                  diagramType: DiagramType.detailSocialTime,
                  selectedDiagramType: selectedDiagramType, onPressed: (value) {
                setDiagramType(value);
              }),
              diagramTypeSelectionButton(context,
                  diagramType: DiagramType.detailSocialHealth,
                  selectedDiagramType: selectedDiagramType, onPressed: (value) {
                setDiagramType(value);
              }),
              diagramTypeSelectionButton(context,
                  diagramType: DiagramType.detailSocialEnvironment,
                  selectedDiagramType: selectedDiagramType, onPressed: (value) {
                setDiagramType(value);
              }),
            ] else if (isPersonalView(selectedDiagramType)) ...[
              diagramTypeSelectionButton(context,
                  diagramType: DiagramType.detailPersonal,
                  selectedDiagramType: selectedDiagramType, onPressed: (value) {
                setDiagramType(value);
              }),
              diagramTypeSelectionButton(context,
                  diagramType: DiagramType.detailPersonalFixed,
                  selectedDiagramType: selectedDiagramType, onPressed: (value) {
                setDiagramType(value);
              }),
              diagramTypeSelectionButton(context,
                  diagramType: DiagramType.detailPersonalVariable,
                  selectedDiagramType: selectedDiagramType, onPressed: (value) {
                setDiagramType(value);
              }),
            ]
          ],
        ),
      ),
    );
  }
}

Widget diagramTypeSelectionButton(BuildContext context,
    {required DiagramType diagramType,
    required DiagramType selectedDiagramType,
    required Function(DiagramType) onPressed}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  String label = getSelectionButtonLabel(context, diagramType);
  return InkWell(
    onTap: () {
      onPressed(diagramType);
    },
    child: Container(
      decoration: BoxDecoration(
        color: selectedDiagramType == diagramType ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      height: 20,
      width: double.infinity,
      child: Center(
        child: Text(
          label,
          style: textTheme.labelMedium,
        ),
      ),
    ),
  );
}
