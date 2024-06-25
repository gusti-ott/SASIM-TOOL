import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/decorations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/electric_selection_components.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/shared_selection_components.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Widget modeSelectionRow(BuildContext context,
    {required bool isElectric,
    required Function(bool) onElectricChanged,
    required SelectionMode selectionMode,
    required Function(SelectionMode) onSelectionModeChanged,
    required bool isShared,
    required Function(bool) onSharedChanged}) {
  return Container(
    decoration: boxDecorationWithShadow(),
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        modeSelectionPart(selectionMode: selectionMode, onSelectionModeChanged: onSelectionModeChanged),
        sharedSelectionPart(context, isShared: isShared, onSharedChanged: onSharedChanged),
        electricSelectionPart(context, isElectric: isElectric, onElectricChanged: onElectricChanged),
      ],
    ),
  );
}

Widget modeSelectionPart(
    {required SelectionMode selectionMode, required Function(SelectionMode) onSelectionModeChanged}) {
  return Row(
    children: [
      modeIconButton(
        icon: Icons.pedal_bike_outlined,
        isSelected: selectionMode == SelectionMode.bicycle,
        onPressed: () {
          onSelectionModeChanged(SelectionMode.bicycle);
        },
      ),
      modeIconButton(
        icon: Icons.directions_car_outlined,
        isSelected: selectionMode == SelectionMode.car,
        onPressed: () {
          onSelectionModeChanged(SelectionMode.car);
        },
      ),
      modeIconButton(
        icon: Icons.directions_bus_outlined,
        isSelected: selectionMode == SelectionMode.publicTransport,
        onPressed: () {
          onSelectionModeChanged(SelectionMode.publicTransport);
        },
      ),
    ],
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
