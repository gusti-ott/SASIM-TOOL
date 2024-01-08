import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/color_schemes.g.dart';
import 'package:multimodal_routeplanner/02_application/bloc/address_picker/address_picker_bloc.dart';
import 'package:multimodal_routeplanner/02_application/bloc/cost_details/cost_details_bloc.dart';
import 'package:multimodal_routeplanner/02_application/bloc/diagram_type/diagram_type_bloc.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_info/info_dropdown_costs_cubit.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_info/info_dropdown_mobiscore_cubit.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_planner/advanced_route_planner_bloc.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_planner_bloc.dart';
import 'package:multimodal_routeplanner/02_application/bloc/sasim_2/trips_cubit.dart';
import 'package:multimodal_routeplanner/config/go_router.dart';

import '02_application/bloc/route_info/route_info_bloc.dart';
import '02_application/bloc/visualization/visualization_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
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
          BlocProvider(
            create: (BuildContext context) => AddressPickerBloc(),
          ),
          BlocProvider(create: (BuildContext context) => TripsCubit()),
        ],
        child: MaterialApp.router(
          title: 'Route Planner',
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme:
              ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          routerConfig: vmrpRouter,
        ));
  }
}
