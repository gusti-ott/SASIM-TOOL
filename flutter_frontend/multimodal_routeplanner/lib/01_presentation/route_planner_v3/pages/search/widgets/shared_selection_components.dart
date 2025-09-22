import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/typography.dart';

Widget sharedSelectionPart(BuildContext context,
    {required bool isShared, required Function(bool) onSharedChanged, required bool isMobile}) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  return IntrinsicWidth(
    child: IntrinsicHeight(
      child: Row(
        children: [
          IntrinsicHeight(
            child: sharedChip(
              context,
              label: lang.private,
              icon: Icons.person,
              isSelected: !isShared,
              isMobile: isMobile,
              onSelected: (selected) {
                if (isShared) {
                  onSharedChanged(!isShared);
                }
              },
            ),
          ),
          smallHorizontalSpacer,
          sharedChip(
            context,
            label: lang.shared,
            icon: Icons.supervised_user_circle,
            isSelected: isShared,
            isMobile: isMobile,
            onSelected: (selected) {
              if (!isShared) {
                onSharedChanged(!isShared);
              }
            },
          ),
        ],
      ),
    ),
  );
}

Widget sharedChip(
  BuildContext context, {
  required String label,
  required IconData icon,
  required bool isSelected,
  required Function(bool) onSelected,
  bool isMobile = false,
}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return IntrinsicWidth(
    child: ChoiceChip(
      avatar: Icon(icon, color: isSelected ? Colors.black : Colors.grey),
      label: FittedBox(
        fit: BoxFit.contain,
        child: Text(label,
            style: isMobile
                ? mobileChipLabelTextStyle
                : textTheme.titleSmall!.copyWith(color: isSelected ? Colors.black : Colors.grey)),
      ),
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
    ),
  );
}
