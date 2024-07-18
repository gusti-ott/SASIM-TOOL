import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/Costs.dart';

part 'cost_details_event.dart';
part 'cost_details_state.dart';

class CostDetailsBloc extends Bloc<CostDetailsEvent, CostDetailsState> {
  CostDetailsBloc() : super(CostDetailsInitial()) {
    on<CostDetailsEvent>((event, emit) {
      if (event is ShowCostDetailsEvent) {
        emit(CostDetailsLoadedState(costs: event.costs));
      }

      if (event is HideCostDetailsEvent) {
        emit(CostDetailsHiddenState());
      }
    });
  }
}
