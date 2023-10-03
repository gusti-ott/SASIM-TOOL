import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v1/RoutePlannerScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/ResultScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/search_screen/SearchScreen.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_planner/advanced_route_planner_bloc.dart';
import 'package:multimodal_routeplanner/03_domain/entities/MobilityMode.dart';
import 'package:multimodal_routeplanner/03_domain/enums/MobilityModeEnum.dart';

final GoRouter vmrpRouter = GoRouter(
  initialLocation: '/search',
  routes: [
    GoRoute(
        name: 'result-old',
        path: '/result_old',
        builder: (context, state) {
          return const RoutePlannerScreen();
        }),
    GoRoute(
        name: 'search-screen',
        path: '/search',
        builder: (context, state) {
          return const SearchScreen();
        }),
    GoRoute(
        name: 'result-screen',
        path: '/result',
        builder: (context, state) {
          final String? startInput = state.uri.queryParameters['startInput'];
          final String? endInput = state.uri.queryParameters['endInput'];

          //TODO: check for format

          if (startInput != null || endInput != null) {
            AdvancedRoutePlannerBloc routeBlocProvider =
                BlocProvider.of<AdvancedRoutePlannerBloc>(context);

            routeBlocProvider.add(RouteFirstTripEvent(startInput!, endInput!,
                MobilityMode(mode: MobilityModeEnum.mvg)));

            return const RoutePlannerScreen();
          }

          //TODO: check for format - if not right show error screen
          return const ResultScreen();
        }),
    GoRoute(
        name: 'route-planner-screen',
        path: '/routeplanner',
        builder: (context, state) {
          return const RoutePlannerScreen();
        })
  ],
);
