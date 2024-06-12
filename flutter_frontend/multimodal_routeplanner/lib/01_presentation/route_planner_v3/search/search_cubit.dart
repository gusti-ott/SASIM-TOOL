import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/usecases/route_usecases.dart';
import 'package:multimodal_routeplanner/logger.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._routePlannerUsecases) : super(SearchInitial());

  final RoutePlannerUsecases _routePlannerUsecases;
  final Logger logger = getLogger();
  List<Trip> cachedListTrips = [];
  String cachedStartInput = '';
  String cachedEndInput = '';

  Future<void> loadTrips(String startInput, String endInput) async {
    if (cachedStartInput != startInput || cachedEndInput != endInput) {
      emit(SearchLoading());
      cachedStartInput = startInput;
      cachedEndInput = endInput;
      try {
        List<Trip> listTrips = await _routePlannerUsecases.getAllTrips(startInput: startInput, endInput: endInput);
        emit(SearchLoaded(listTrips));
      } catch (e) {
        logger.e(e.toString());
        emit(SearchError(e.toString()));
      }
    }
  }
}

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Trip> trips;

  SearchLoaded(this.trips);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
