import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/02_application/bloc/app_cubit.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit appCubit = context.read<AppCubit>();
    AppLocalizations lang = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;

    bool isEnglish = Localizations.localeOf(context).languageCode == 'en';

    const kPadding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);
    const kBorderRadius = BorderRadius.all(Radius.circular(20.0));

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryColorV3),
        borderRadius: BorderRadius.circular(20.0),
        color: primaryColorV3.withOpacity(0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              appCubit.changeLocale(const Locale('en'));
            },
            child: Container(
              padding: kPadding,
              decoration: BoxDecoration(
                color: isEnglish ? primaryColorV3 : Colors.transparent,
                borderRadius: kBorderRadius,
              ),
              child: Text(
                lang.en.toUpperCase(),
                style: textTheme.labelSmall!.copyWith(
                  color: isEnglish ? Colors.white : primaryColorV3,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              appCubit.changeLocale(const Locale('de'));
            },
            child: Container(
              padding: kPadding,
              decoration: BoxDecoration(
                color: !isEnglish ? primaryColorV3 : Colors.transparent,
                borderRadius: kBorderRadius,
              ),
              child: Text(
                lang.de.toUpperCase(),
                style: textTheme.labelSmall!.copyWith(
                  color: !isEnglish ? Colors.white : primaryColorV3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
