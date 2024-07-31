import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/typography.dart';

Widget electricSelectionPart(BuildContext context,
    {required bool isElectric, required Function(bool) onElectricChanged, required bool isMobile}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  AppLocalizations lang = AppLocalizations.of(context)!;
  return IntrinsicWidth(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(lang.electric,
            style: isMobile ? mobileElectricSwitchLabelTextStyle : textTheme.titleSmall!.copyWith(color: Colors.black)),
        smallHorizontalSpacer,
        Expanded(
          child: Switch(
            thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
              return Icon(
                Icons.electric_bolt,
                color: customBlack,
              ); // All other states will use the default thumbIcon.
            }),
            activeTrackColor: secondaryColorV3,
            inactiveTrackColor: backgroundColorGreyV3,
            value: isElectric,
            onChanged: (value) {
              onElectricChanged(value);
            },
            activeColor: Colors.white,
            inactiveThumbColor: customGrey,
          ),
        ),
      ],
    ),
  );
}
