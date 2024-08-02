import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v1/RoutePlannerScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/faq_section/FaqScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/ResultScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/search_screen/SearchScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/main_screen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/about_us/about_us_screen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/research/research_screen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_screen_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/search_screen_v3.dart';

// final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorCalculatorKey = GlobalKey<NavigatorState>(debugLabel: 'shellCalculator');
final _shellNavigatorInfoKey = GlobalKey<NavigatorState>(debugLabel: 'shellInfo');

final GoRouter vmrpRouter = GoRouter(
  initialLocation: '/search',
  routes: [
    GoRoute(
      path: '/v2',
      redirect: (context, state) {
        if (state.fullPath == '/v2') {
          return '/v2/search';
        }
        return null;
      },
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
    GoRoute(
        path: '/',
        redirect: (context, state) {
          return null;
        },
        routes: [
          GoRoute(
            name: SearchScreenV3.routeName,
            path: SearchScreenV3.path,
            builder: (context, state) {
              return const SearchScreenV3();
            },
          ),
          GoRoute(
            name: ResultScreenV3.routeName,
            path: ResultScreenV3.path,
            builder: (context, state) {
              final String? startInput = state.uri.queryParameters['startAddress'];
              final String? endInput = state.uri.queryParameters['endAddress'];
              final String? selectedMode = state.uri.queryParameters['selectedMode'];
              final String? isElectric = state.uri.queryParameters['isElectric'];
              final String? isShared = state.uri.queryParameters['isShared'];

              if (startInput != null && endInput != null) {
                return ResultScreenV3(
                    startAddress: startInput,
                    endAddress: endInput,
                    selectedMode: parseStringToSelectionMode(selectedMode),
                    isElectric: isElectric == 'true',
                    isShared: isShared == 'true');
              } else {
                return const Scaffold(
                    body: Center(
                  child: Text('Error: parameters in url missing'),
                ));
              }
            },
          ),
          GoRoute(
            name: AboutUsScreen.routeName,
            path: AboutUsScreen.path,
            builder: (context, state) {
              return const AboutUsScreen();
            },
          ),
          GoRoute(
            name: ResearchScreen.routeName,
            path: ResearchScreen.path,
            builder: (context, state) {
              return const ResearchScreen();
            },
          )
        ])
  ],
);
