import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class ResultDiagramCard extends StatelessWidget {
  final List<Trip> trips;

  const ResultDiagramCard({super.key, required this.trips});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: Center(
        child: Text(
          'wähle eine Kategorie im Dropdown-Menü um deine Routen zu vergleichen',
          textAlign: TextAlign.center,
          style:
              themeData.textTheme.headlineSmall?.copyWith(color: themeData.colorScheme.onPrimary),
        ),
      ),
    );

    /*return Padding(
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
                      color: themeData.colorScheme.onPrimaryContainer),
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
              BlocBuilder<CostDetailsBloc, CostDetailsState>(
                builder: (context, state) {
                  if (state is CostDetailsLoadedState) {
                    return CostDetails(costs: state.costs);
                  } else if (state is CostDetailsHiddenState) {
                    return const CostDetailsText();
                  } else {
                    return const CostDetailsText();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}
