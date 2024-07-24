import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/03_domain/entities/MobilityMode.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/enums/MobilityModeEnum.dart';
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
      emit(ResultLoading(0, 7));
      cachedStartInput = startInput;
      cachedEndInput = endInput;
      List<Trip> listTrips = [];
      List<MobilityMode> tripModes = [
        MobilityMode(mode: MobilityModeEnum.bike),
        MobilityMode(mode: MobilityModeEnum.ebike),
        MobilityMode(mode: MobilityModeEnum.cab),
        MobilityMode(mode: MobilityModeEnum.car),
        MobilityMode(mode: MobilityModeEnum.ecar),
        MobilityMode(mode: MobilityModeEnum.sharenow),
        MobilityMode(mode: MobilityModeEnum.mvg)
      ];

      for (int i = 0; i < tripModes.length; i++) {
        try {
          Trip trip =
              await _routePlannerUsecases.getTrip(startInput: startInput, endInput: endInput, mode: tripModes[i]);
          listTrips.add(trip);
          emit(ResultLoading(i + 1, tripModes.length));
        } catch (e) {
          logger.e('Error loading trip for ${tripModes[i].mode}: $e');
        }
      }

      if (listTrips.isNotEmpty) {
        emit(ResultLoaded(listTrips));
      } else {
        emit(ResultError('No trips could be loaded.'));
      }
    }
  }
}

@immutable
abstract class ResultState {}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {
  final int loadedTrips;
  final int totalTrips;

  ResultLoading(this.loadedTrips, this.totalTrips);
}

class ResultLoaded extends ResultState {
  final List<Trip> trips;

  ResultLoaded(this.trips);
}

class ResultError extends ResultState {
  final String message;

  ResultError(this.message);
}
