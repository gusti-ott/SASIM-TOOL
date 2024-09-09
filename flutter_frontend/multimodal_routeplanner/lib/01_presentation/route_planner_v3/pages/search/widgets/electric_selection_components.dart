import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Widget electricSelectionPart(BuildContext context,
    {required bool isElectric,
    required Function(bool)? onElectricChanged, // Change to nullable to handle disabled state
    required bool isMobile,
    required bool isDisabled}) {
  // New parameter to control grey styling
  TextTheme textTheme = Theme.of(context).textTheme;
  AppLocalizations lang = AppLocalizations.of(context)!;

  // Determine the color based on the disabled state
  Color textColor = isDisabled ? Colors.grey[400]! : (isMobile ? Colors.black : Colors.black);
  Color activeTrackColor = isDisabled ? Colors.grey[300]! : secondaryColorV3;
  Color inactiveTrackColor = isDisabled ? Colors.grey[200]! : backgroundColorGreyV3;
  Color thumbColor = isDisabled ? Colors.grey[400]! : (isElectric ? Colors.white : customGrey);
  Color iconColor = isDisabled ? Colors.grey : customBlack;

  return IntrinsicWidth(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          lang.electric,
          style: textTheme.titleSmall!.copyWith(color: textColor), // Apply grey text if disabled
        ),
        smallHorizontalSpacer,
        Expanded(
          child: Switch(
            thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
              return Icon(
                Icons.electric_bolt,
                color: iconColor,
              );
            }),
            activeTrackColor: activeTrackColor, // Change track color based on disabled state
            inactiveTrackColor: inactiveTrackColor,
            activeColor: Colors.white,
            inactiveThumbColor: thumbColor, // Apply grey thumb if disabled
            value: isElectric,
            onChanged: onElectricChanged, // Disable if null
          ),
        ),
      ],
    ),
  );
}
