import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/usecases/route_usecases.dart';
import 'package:multimodal_routeplanner/logger.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit(this._routePlannerUsecases) : super(ResultInitial());

  final RoutePlannerUsecases _routePlannerUsecases;
  final Logger logger = getLogger();
  List<Trip> cachedListTrips = [];
  String cachedStartInput = '';
  String cachedEndInput = '';

  Future<void> loadTrips(String startInput, String endInput) async {
    if (cachedStartInput != startInput || cachedEndInput != endInput) {
      emit(ResultLoading());
      cachedStartInput = startInput;
      cachedEndInput = endInput;
      try {
        List<Trip> listTrips = await _routePlannerUsecases.getV3Trips(startInput: startInput, endInput: endInput);
        emit(ResultLoaded(listTrips));
      } catch (e) {
        logger.e(e.toString());
        emit(ResultError(e.toString()));
      }
    }
  }
}

@immutable
abstract class ResultState {}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class ResultLoaded extends ResultState {
  final List<Trip> trips;

  ResultLoaded(this.trips);
}

class ResultError extends ResultState {
  final String message;

  ResultError(this.message);
}
