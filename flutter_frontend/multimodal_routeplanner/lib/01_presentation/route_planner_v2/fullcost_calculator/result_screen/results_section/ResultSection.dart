import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/headers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/ResultTable.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/results_section/general_result_diagram/ExternalCostsDiagram.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class ResultSection extends StatefulWidget {
  const ResultSection({
    super.key,
    required this.listTrips,
    required this.realoadCallback,
  });

  final List<Trip> listTrips;
  final Function realoadCallback;

  @override
  State<ResultSection> createState() => _ResultSectionState();
}

class _ResultSectionState extends State<ResultSection> {
  Trip? trip1;
  Trip? trip2;
  Trip? trip3;

  @override
  void initState() {
    super.initState();
    if (widget.listTrips.length >= 3) {
      trip1 = widget.listTrips[0];
      trip2 = widget.listTrips[1];
      trip3 = widget.listTrips[2];
    }
  }

  void updateTrip1(Trip trip) {
    setState(() {
      trip1 = trip;
    });
  }

  void updateTrip2(Trip trip) {
    setState(() {
      trip2 = trip;
    });
  }

  void updateTrip3(Trip trip) {
    setState(() {
      trip3 = trip;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;

    var externalCostsKey = GlobalKey();
    var mobiScoreKey = GlobalKey();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        mediumVerticalSpacer,
        if (widget.listTrips.length >= 3) ...[
          ResultTable(
            listTrips: widget.listTrips,
            onTrip1ChangedCallback: updateTrip1,
            onTrip2ChangedCallback: updateTrip2,
            onTrip3ChangedCallback: updateTrip3,
            externalCostsInfoCallback: () {
              scrollTo(externalCostsKey);
            },
            mobiscoreInfoCallbacK: () {
              scrollTo(mobiScoreKey);
            },
          ),
          extraLargeVerticalSpacer,
          TitleImage(
              key: externalCostsKey,
              imagePath: 'assets/title_image/titelbild_ubahn.png',
              titleText: lang.these_are_external_costs,
              height: 200),
          extraLargeVerticalSpacer,
          ExternalCostsDiagram(
            trip1: trip1!,
            trip2: trip2!,
            trip3: trip3!,
          ),
          extraLargeVerticalSpacer,
          TitleImage(
              key: mobiScoreKey,
              imagePath: 'assets/title_image/titelbild_ubahn.png',
              titleText: lang.what_is_mobi_score,
              height: 200),
          extraLargeVerticalSpacer,
        ] else
          //TODO: implement nice error widget
          ...[
          Center(child: Text(lang.something_went_wrong, style: textTheme.headlineLarge)),
          TextButton(
              onPressed: () {
                widget.realoadCallback();
              },
              child: Text(lang.try_again)),
        ]
      ],
    );
  }

  void scrollTo(GlobalKey<State<StatefulWidget>> externalCostsKey) {
    Scrollable.ensureVisible(externalCostsKey.currentContext!,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
