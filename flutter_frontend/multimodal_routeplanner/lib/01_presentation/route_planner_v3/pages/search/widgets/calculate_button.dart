import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_screen_v3.dart';

Widget statefulCalculateButton(BuildContext context,
    {required ResultCubit cubit,
    required String startAddress,
    required String endAddress,
    required SelectionMode selectedMode,
    required bool isElectric,
    required bool isShared}) {
  AppLocalizations lang = AppLocalizations.of(context)!;

  return V3CustomButton(
    height: 40,
    label: lang.calculate,
    onTap: () {
      context.goNamed(
        ResultScreenV3.routeName,
        queryParameters: {
          'startAddress': startAddress,
          'endAddress': endAddress,
          'selectedMode': selectedMode.name,
          'isElectric': isElectric.toString(),
          'isShared': isShared.toString(),
        },
      );
    },
  );
}
