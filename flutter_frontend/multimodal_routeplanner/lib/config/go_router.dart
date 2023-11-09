import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v1/RoutePlannerScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/MainScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/faq_section/FaqScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/ResultScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/search_screen/SearchScreen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorCalculatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellCalculator');
final _shellNavigatorInfoKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellInfo');

final GoRouter vmrpRouter = GoRouter(
  initialLocation: '/search',
  routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
              navigatorKey: _shellNavigatorCalculatorKey,
              routes: [
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
                      final String? startInput =
                          state.uri.queryParameters['startInput'];
                      final String? endInput =
                          state.uri.queryParameters['endInput'];

                      if (startInput != null || endInput != null) {
                        return ResultScreen(
                            startAddress: startInput!, endAddress: endInput!);

                        /* AdvancedRoutePlannerBloc routeBlocProvider =
                BlocProvider.of<AdvancedRoutePlannerBloc>(context);

            routeBlocProvider.add(RouteFirstTripEvent(startInput!, endInput!,
                MobilityMode(mode: MobilityModeEnum.mvg)));

            return const RoutePlannerScreen();*/
                      } else {
                        //TODO: add error screen or sth
                        return const SearchScreen();
                      }
                      //TODO: check for format - if not right show error screen
                    }),
              ]),
          StatefulShellBranch(navigatorKey: _shellNavigatorInfoKey, routes: [
            GoRoute(
                name: 'faq-screen',
                path: '/faq',
                builder: (context, state) {
                  return const FaqScreen();
                }),
          ]),
        ]),
    GoRoute(
        name: 'result-old',
        path: '/result_old',
        builder: (context, state) {
          return const RoutePlannerScreen();
        }),
    /*GoRoute(
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
            return ResultScreen(
                startAddress: startInput!, endAddress: endInput!);

            */ /* AdvancedRoutePlannerBloc routeBlocProvider =
                BlocProvider.of<AdvancedRoutePlannerBloc>(context);

            routeBlocProvider.add(RouteFirstTripEvent(startInput!, endInput!,
                MobilityMode(mode: MobilityModeEnum.mvg)));

            return const RoutePlannerScreen();*/ /*
          } else {
            //TODO: add error screen or sth
            return const SearchScreen();
          }
          //TODO: check for format - if not right show error screen
        }),*/
    GoRoute(
        name: 'route-planner-screen',
        path: '/routeplanner',
        builder: (context, state) {
          return const RoutePlannerScreen();
        })
  ],
);
