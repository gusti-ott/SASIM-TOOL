import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/color_schemes.g.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/typography.dart';
import 'package:multimodal_routeplanner/02_application/bloc/app_cubit.dart';
import 'package:multimodal_routeplanner/02_application/bloc/cost_details/cost_details_bloc.dart';
import 'package:multimodal_routeplanner/02_application/bloc/diagram_type/diagram_type_bloc.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_info/info_dropdown_costs_cubit.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_info/info_dropdown_mobiscore_cubit.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_planner/advanced_route_planner_bloc.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_planner_bloc.dart';
import 'package:multimodal_routeplanner/02_application/bloc/sasim_2/trips_cubit.dart';
import 'package:multimodal_routeplanner/config/go_router.dart';
import 'package:multimodal_routeplanner/config/setup_dependencies.dart';

import '02_application/bloc/route_info/route_info_bloc.dart';
import '02_application/bloc/visualization/visualization_bloc.dart';

void main() async {
  setupDependencies();
  runApp(const VmrpApp());
}

class VmrpApp extends StatefulWidget {
  const VmrpApp({Key? key}) : super(key: key);

  @override
  State<VmrpApp> createState() => _VmrpAppState();
}

class _VmrpAppState extends State<VmrpApp> {
  late Locale _currentLocale;

  @override
  void initState() {
    _currentLocale = const Locale('de');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => RoutePlannerBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => VisualizationBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => CostDetailsBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => DiagramTypeBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => RouteInfoBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => AdvancedRoutePlannerBloc(),
          ),
          BlocProvider(
            create: (BuildContext context) => InfoDropdownMobiscoreCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => InfoDropdownCostsCubit(),
          ),
          BlocProvider(create: (BuildContext context) => TripsCubit()),
          BlocProvider(create: (BuildContext context) => AppCubit())
        ],
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            if (state is LocaleChanged) {
              if (_currentLocale == const Locale('en')) {
                _currentLocale = const Locale('de');
              } else {
                _currentLocale = const Locale('en');
              }
            }

            return MaterialApp.router(
              title: 'mobiscore',
              theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme, textTheme: textTheme),
              darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme, textTheme: textTheme),
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('de'), // German
                Locale('en'), // English
              ],
              locale: _currentLocale,
              routerConfig: vmrpRouter,
            );
          },
        ));
  }
}
