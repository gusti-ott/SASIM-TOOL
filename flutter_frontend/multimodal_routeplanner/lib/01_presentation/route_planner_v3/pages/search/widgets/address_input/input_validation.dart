import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String? validateInput(BuildContext context, String? value) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  if (value == null || value.isEmpty) {
    return lang.field_empty_alert;
  } else if (value.length <= 2) {
    return lang.input_short_alert;
  }
  return null;
}
