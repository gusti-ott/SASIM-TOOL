import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/McubeLogo.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/search_screen/SearchScreen.dart';
import 'package:multimodal_routeplanner/02_application/bloc/app_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  /*ButtonStyle _getButtonStyle(BuildContext context, int index) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return navigationShell.currentIndex == index
        ? TextButton.styleFrom(backgroundColor: colorScheme.primaryContainer)
        : TextButton.styleFrom(backgroundColor: null);
  }*/

  TextStyle? _getTextStyle(BuildContext context, int index) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextStyle? buttonTextStyle =
        Theme.of(context).textTheme.headlineSmall?.copyWith(color: colorScheme.onPrimary);

    TextStyle? buttonTextStyleSelected = Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: colorScheme.onPrimary,
        decoration: TextDecoration.underline,
        decorationColor: Colors.white,
        decorationThickness: 2);

    return navigationShell.currentIndex == index ? buttonTextStyleSelected : buttonTextStyle;
  }

  Color _getBackgroundColor(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return navigationShell.currentIndex == 0 ? colorScheme.primary : colorScheme.background;
  }

  Color _getAppBarColor(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return navigationShell.currentIndex == 0 ? Colors.transparent : colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _getBackgroundColor(context),
      appBar: AppBar(
        toolbarHeight: 100,
        title: navigationRow(context),
        elevation: 0,
        backgroundColor: _getAppBarColor(context),
      ),
      extendBodyBehindAppBar: true,
      body: navigationShell,
    );
  }

  Widget navigationRow(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton(
              //style: _getButtonStyle(context, 0),
              onPressed: () {
                context.goNamed(SearchScreen.routeName);
              },
              child: Text(lang.calculator, style: _getTextStyle(context, 0))),
          TextButton(
              //style: _getButtonStyle(context, 1),
              onPressed: () {
                context.goNamed('faq-screen');
              },
              child: Text(lang.information, style: _getTextStyle(context, 1))),
          TextButton(
              //style: _getButtonStyle(context, 2),
              onPressed: () {},
              child: Text(lang.about_us, style: _getTextStyle(context, 2))),
          mcubeLogo(),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset('assets/flags/flag_de.png',
                    height: 30, width: 40, fit: BoxFit.fill),
              ),
              onTap: () {
                context.read<AppCubit>().changeLocale(const Locale('de'));
              },
            ),
            smallHorizontalSpacer,
            InkWell(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset('assets/flags/flag_us.png',
                      height: 30, width: 40, fit: BoxFit.fill)),
              onTap: () {
                context.read<AppCubit>().changeLocale(const Locale('en'));
              },
            ),
          ],
        )
      ],
    );
  }
}

enum ContentType { calculator, info, aboutUs }
