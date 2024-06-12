import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

Widget electricSelectionPart(BuildContext context,
    {required bool isElectric, required Function(bool) onElectricChanged}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  AppLocalizations lang = AppLocalizations.of(context)!;
  return Row(
    children: [
      Text(lang.electric, style: textTheme.titleSmall!.copyWith(color: Colors.black)),
      Switch(
        value: isElectric,
        onChanged: (value) {
          onElectricChanged(value);
        },
        activeColor: secondaryColorV3,
        inactiveThumbColor: Colors.grey,
      ),
    ],
  );
}
