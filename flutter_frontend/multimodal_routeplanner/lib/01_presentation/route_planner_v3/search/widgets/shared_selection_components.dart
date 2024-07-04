import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Widget sharedSelectionPart(BuildContext context, {required bool isShared, required Function(bool) onSharedChanged}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      sharedChip(
        context,
        label: 'Private',
        icon: Icons.person,
        isSelected: !isShared,
        onSelected: (selected) {
          if (isShared) {
            onSharedChanged(!isShared);
          }
        },
      ),
      SizedBox(width: smallPadding),
      sharedChip(
        context,
        label: 'Shared',
        icon: Icons.supervised_user_circle,
        isSelected: isShared,
        onSelected: (selected) {
          if (!isShared) {
            onSharedChanged(!isShared);
          }
        },
      ),
    ],
  );
}

Widget sharedChip(
  BuildContext context, {
  required String label,
  required IconData icon,
  required bool isSelected,
  required Function(bool) onSelected,
}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return ChoiceChip(
    avatar: Icon(icon, color: isSelected ? Colors.black : Colors.grey),
    label: Text(label, style: textTheme.titleSmall!.copyWith(color: isSelected ? Colors.black : Colors.grey)),
    showCheckmark: false,
    selected: isSelected,
    onSelected: (selected) {
      onSelected(selected);
    },
    selectedColor: secondaryColorV3,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
      side: BorderSide(color: isSelected ? secondaryColorV3 : Colors.grey),
    ),
    labelStyle: textTheme.labelMedium!.copyWith(
      color: isSelected ? Colors.black : Colors.grey,
    ),
  );
}
