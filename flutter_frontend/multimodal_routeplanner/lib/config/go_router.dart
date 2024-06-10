import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v1/RoutePlannerScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/MainScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/faq_section/FaqScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/ResultScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/search_screen/SearchScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/search_screen.dart';

// final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorCalculatorKey = GlobalKey<NavigatorState>(debugLabel: 'shellCalculator');
final _shellNavigatorInfoKey = GlobalKey<NavigatorState>(debugLabel: 'shellInfo');

final GoRouter vmrpRouter = GoRouter(
  initialLocation: '/v2/search',
  routes: [
    GoRoute(
      path: '/v2',
      redirect: (context, state) => '/v2/search',
      routes: [
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) {
              return MainScreen(
                navigationShell: navigationShell,
              );
            },
            branches: [
              StatefulShellBranch(navigatorKey: _shellNavigatorCalculatorKey, routes: [
                GoRoute(
                    name: SearchScreen.routeName,
                    path: 'search',
                    builder: (context, state) {
                      return const SearchScreen();
                    }),
                GoRoute(
                    name: ResultScreen.routeName,
                    path: 'result',
                    builder: (context, state) {
                      final String? startInput = state.uri.queryParameters['startInput'];
                      final String? endInput = state.uri.queryParameters['endInput'];

                      if (startInput != null || endInput != null) {
                        return ResultScreen(startAddress: startInput!, endAddress: endInput!);
                      } else {
                        //TODO: add error screen or sth
                        return const SearchScreen();
                      }
                      // TODO: check for format - if not right show error screen
                    }),
              ]),
              StatefulShellBranch(navigatorKey: _shellNavigatorInfoKey, routes: [
                GoRoute(
                    name: 'faq-screen',
                    path: 'faq',
                    builder: (context, state) {
                      return const FaqScreen();
                    }),
              ]),
            ]),
      ],
    ),
    GoRoute(
        name: 'result-old',
        path: '/result_old',
        builder: (context, state) {
          return const RoutePlannerScreen();
        }),
    GoRoute(
        name: 'route-planner-screen',
        path: '/v1',
        builder: (context, state) {
          return const RoutePlannerScreen();
        }),
    GoRoute(path: '/v3', redirect: (context, state) => '/v3/search', routes: [
      GoRoute(
        name: SearchScreenV3.routeName,
        path: SearchScreenV3.path,
        builder: (context, state) {
          return const SearchScreenV3();
        },
      )
    ])
  ],
);
