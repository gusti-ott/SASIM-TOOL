import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/decorations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/electric_selection_components.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/shared_selection_components.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Widget modeSelectionRow(BuildContext context,
    {required bool isElectric,
    required Function(bool) onElectricChanged,
    required SelectionMode selectionMode,
    required Function(SelectionMode) onSelectionModeChanged,
    required bool isShared,
    required Function(bool) onSharedChanged,
    double? width,
    double? height,
    bool makePartlyTransparent = false,
    Color? backgroundColor = Colors.white}) {
  return Container(
    width: width ?? double.infinity,
    height: null,
    decoration: customBoxDecorationWithShadow(backgroundColor: backgroundColor),
    padding: EdgeInsets.all(smallPadding),
    child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        children: listSelectionElements(
            context, selectionMode, onSelectionModeChanged, isElectric, onElectricChanged, isShared, onSharedChanged)),
  );
}

List<Widget> listSelectionElements(
    BuildContext context,
    SelectionMode selectionMode,
    Function(SelectionMode) onSelectionModeChanged,
    bool isElectric,
    Function(bool) onElectricChanged,
    bool isShared,
    Function(bool) onSharedChanged) {
  return [
    modeSelectionPart(selectedMode: selectionMode, onSelectionModeChanged: onSelectionModeChanged),
    sharedSelectionPart(context, isShared: isShared, onSharedChanged: onSharedChanged, isMobile: false),
    electricSelectionPart(
      context,
      isElectric: isElectric,
      onElectricChanged: isShared ? null : onElectricChanged, // Disable switch when isShared is true
      isMobile: false,
      isDisabled: isShared, // Add an isDisabled parameter to control the grey styling
    )
  ];
}

Widget modeSelectionPart(
    {required SelectionMode selectedMode, required Function(SelectionMode) onSelectionModeChanged}) {
  return IntrinsicWidth(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        modeIconButton(
          icon: Icons.pedal_bike_outlined,
          isSelected: selectedMode == SelectionMode.bicycle,
          onPressed: () {
            onSelectionModeChanged(SelectionMode.bicycle);
          },
        ),
        modeIconButton(
          icon: Icons.directions_car_outlined,
          isSelected: selectedMode == SelectionMode.car,
          onPressed: () {
            onSelectionModeChanged(SelectionMode.car);
          },
        ),
        modeIconButton(
          icon: Icons.directions_bus_outlined,
          isSelected: selectedMode == SelectionMode.publicTransport,
          onPressed: () {
            onSelectionModeChanged(SelectionMode.publicTransport);
          },
        ),
      ],
    ),
  );
}

Widget modeIconButton({
  required IconData icon,
  required bool isSelected,
  required VoidCallback onPressed,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: extraSmallPadding),
    decoration: isSelected
        ? BoxDecoration(
            color: secondaryColorV3,
            shape: BoxShape.circle,
          )
        : null,
    child: IconButton(
      icon: Icon(icon),
      color: isSelected ? Colors.black : Colors.grey,
      onPressed: onPressed,
    ),
  );
}

Widget mobileModeSelectionContainer(BuildContext context,
    {required SelectionMode selectedMode,
    required Function(SelectionMode) onSelectionModeChanged,
    required bool isElectric,
    required Function(bool) onElectricChanged,
    required bool isShared,
    required Function(bool) onSharedChanged,
    bool disableBorder = false}) {
  return Container(
    width: double.infinity,
    decoration: (!disableBorder) ? customBoxDecorationWithShadow() : null,
    padding: EdgeInsets.all(smallPadding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        modeSelectionPart(selectedMode: selectedMode, onSelectionModeChanged: onSelectionModeChanged),
        smallVerticalSpacer,
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            sharedSelectionPart(context, isShared: isShared, onSharedChanged: onSharedChanged, isMobile: true),
            smallHorizontalSpacer,
            electricSelectionPart(
              context,
              isElectric: isElectric,
              onElectricChanged: isShared ? null : onElectricChanged, // Disable switch when isShared is true
              isMobile: false,
              isDisabled: isShared, // Add an isDisabled parameter to control the grey styling
            ),
          ],
        )
      ],
    ),
  );
}
