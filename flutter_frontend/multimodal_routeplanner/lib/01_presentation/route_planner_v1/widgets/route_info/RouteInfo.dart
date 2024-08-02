import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/mode_mapping_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/string_formatting_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v1/widgets/route_info/ExternalCostsDetailRow.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_info/info_dropdown_costs_cubit.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_info/info_dropdown_mobiscore_cubit.dart';
import 'package:multimodal_routeplanner/02_application/bloc/route_info/route_info_bloc.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class RouteInfo extends StatelessWidget {
  final Trip trip;
  final bool visible;

  const RouteInfo({Key? key, required this.trip, required this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    AppLocalizations lang = AppLocalizations.of(context)!;
    ModeMappingHelper stringMappingHelper = ModeMappingHelper(AppLocalizations.of(context)!);

    return Visibility(
      visible: visible,
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 300,
                child: Card(
                  color: themeData.colorScheme.onPrimary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //Header Row 1
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: stringMappingHelper.mapModeStringToIcon(trip.mode.toString()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(stringMappingHelper.mapModeStringToLocalizedString(trip.mode),
                                      style: const TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            // Header Row 2
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              Column(
                                children: [
                                  Row(children: [
                                    const Icon(Icons.timer),
                                    Text(
                                        '${StringFormattingHelper().convertSecondsToMinutesAndSeconds(totalMinutes: trip.duration)} min')
                                  ])
                                ],
                              ),
                              Column(children: [
                                Row(
                                  children: [const Icon(Icons.route), Text('${trip.distance.toStringAsFixed(2)} km')],
                                ),
                              ]),
                            ]),
                            // Mobi-Score information
                            BlocBuilder<InfoDropdownMobiscoreCubit, InfoDropdownMobiscoreState>(
                              builder: (context, state) {
                                return ExpansionTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(lang.mobi_score),
                                      SizedBox(
                                        width: 100,
                                        height: 50,
                                        child: Image(
                                          image: stringMappingHelper.mapMobiScoreStringToPath(trip.mobiScore),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onExpansionChanged: (value) {
                                    context.read<InfoDropdownMobiscoreCubit>().openOrCloseDropdown(value);
                                  },
                                  subtitle: (state is InfoDropdownMobiscoreClosed)
                                      ? const Text(
                                          'klicke hier, um mehr zu erfahren',
                                          style: TextStyle(fontSize: 12),
                                          textAlign: TextAlign.right,
                                        )
                                      : null,
                                  children: const [
                                    Column(
                                      children: [
                                        SizedBox(height: 8),
                                        Text(
                                          'Der Mobi-Score ist eine Kenngröße, die die Nachhaltigkeit einer Route im urbanen Verkehr beschreibt. Diese wird aus den externen Kosten und der Routendistanz berechnet.',
                                          textAlign: TextAlign.justify,
                                          textWidthBasis: TextWidthBasis.parent,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            // Costs information
                            BlocBuilder<InfoDropdownCostsCubit, InfoDropdownCostsState>(
                              builder: (context, state) {
                                return ExpansionTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Kosten'),
                                      Column(
                                        children: [
                                          Text('intern: ${trip.costs.internalCosts.all.toStringAsFixed(2)} €'),
                                          Text('extern: ${trip.costs.externalCosts.all.toStringAsFixed(2)} €')
                                        ],
                                      )
                                    ],
                                  ),
                                  onExpansionChanged: (value) {
                                    context.read<InfoDropdownCostsCubit>().openOrCloseDropdown(value);
                                  },
                                  subtitle: (state is InfoDropdownCostsClosed)
                                      ? const Text(
                                          'klicke hier, um mehr zu erfahren',
                                          style: TextStyle(fontSize: 12),
                                          textAlign: TextAlign.right,
                                        )
                                      : null,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Text(
                                            'Bei dieser Fahrt entstehen ${trip.costs.internalCosts.all.toStringAsFixed(2)}€ interne Kosten und ${trip.costs.externalCosts.all.toStringAsFixed(2)}€ externe Kosten. Die externen Kosten setzen sich dabei folgendermaßen zusammen:',
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        ExternalCostsDetailRow(
                                            externalCostName: 'Unfallkosten',
                                            externalCostValue: trip.costs.externalCosts.accidents,
                                            costIcon: Icons.emergency),
                                        ExternalCostsDetailRow(
                                            externalCostName: 'Klimaschäden',
                                            externalCostValue: trip.costs.externalCosts.climate,
                                            costIcon: Icons.eco),
                                        ExternalCostsDetailRow(
                                            externalCostName: 'Luftverschmutzung',
                                            externalCostValue: trip.costs.externalCosts.air,
                                            costIcon: Icons.air),
                                        ExternalCostsDetailRow(
                                            externalCostName: 'Lärmbelastung',
                                            externalCostValue: trip.costs.externalCosts.noise,
                                            costIcon: Icons.volume_up),
                                        ExternalCostsDetailRow(
                                            externalCostName: 'Fächenverbrauch',
                                            externalCostValue: trip.costs.externalCosts.space,
                                            costIcon: Icons.location_city),
                                        ExternalCostsDetailRow(
                                            externalCostName: 'Stau',
                                            externalCostValue: trip.costs.externalCosts.congestion,
                                            costIcon: Icons.traffic),
                                        ExternalCostsDetailRow(
                                            externalCostName: 'Barriereeffekte',
                                            externalCostValue: trip.costs.externalCosts.barrier,
                                            costIcon: Icons.fence),
                                        const SizedBox(height: 8),
                                      ],
                                    )
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<RouteInfoBloc>(context).add(HideRouteInfoEvent(trip: trip));
                                },
                                icon: const Icon(Icons.close))),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
