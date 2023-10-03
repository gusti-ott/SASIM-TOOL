import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multimodal_routeplanner/03_domain/enums/DiagramTypeEnum.dart';

import '../../../../../02_application/bloc/diagram_type/diagram_type_bloc.dart';
import '../../../../../03_domain/entities/Trip.dart';
import 'ResultDiagramBar.dart';
import 'TitleDropdown.dart';

class ResultDiagramCard extends StatelessWidget {
  final List<Trip> trips;
  const ResultDiagramCard({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Card(
          color: themeData.colorScheme.onPrimary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'wähle eine Kategorie im Dropdown-Menü um deine Routen zu vergleichen',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: themeData.colorScheme.onSecondary),
                ),
              ),
              const TitleDropdown(),
              Expanded(
                child: BlocBuilder<DiagramTypeBloc, DiagramTypeState>(
                  builder: (context, state) {
                    if (state is DiagramTypeSelected) {
                      return ResultDiagramBarWidget(
                          trips: trips, animate: true, diagramType: state.type);
                    } else {
                      return ResultDiagramBarWidget(
                          trips: trips,
                          animate: true,
                          diagramType: DiagramTypeEnum.externalCosts);
                    }
                  },
                ),
              ),
              /*BlocBuilder<CostDetailsBloc, CostDetailsState>(
                builder: (context, state) {
                  if (state is CostDetailsLoadedState) {
                    return CostDetails(costs: state.costs);
                  } else if (state is CostDetailsHiddenState) {
                    return const CostDetailsText();
                  } else {
                    return const CostDetailsText();
                  }
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
