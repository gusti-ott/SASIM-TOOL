import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/mode_mapping_helper.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';

class StartMarker extends StatelessWidget {
  const StartMarker({super.key, required this.mode});

  final String mode;

  @override
  Widget build(BuildContext context) {
    ModeMappingHelper modeMappingHelper = ModeMappingHelper(AppLocalizations.of(context)!);

    return Container(
        decoration: BoxDecoration(
          color: Colors.green.shade400,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Center(child: Icon(modeMappingHelper.mapModeStringToIconData(mode))));
  }
}
