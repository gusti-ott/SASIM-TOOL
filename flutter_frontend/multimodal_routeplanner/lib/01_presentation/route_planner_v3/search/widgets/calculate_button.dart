import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/progress_indicators.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/search_cubit.dart';

Widget statefulCalculateButton(BuildContext context, SearchState state,
    {required SearchCubit cubit, required String startAddress, required String endAddress}) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  if (state is SearchLoading) {
    return circularProgressIndicatorWithPadding();
  } else {
    return IntrinsicWidth(
      child: customButton(
        label: lang.calculate,
        onTap: () {
          cubit.loadTrips(startAddress, endAddress);
        },
      ),
    );
  }
}
