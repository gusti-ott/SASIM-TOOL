part of 'trips_cubit.dart';

@immutable
abstract class TripsState {}

class TripsInitial extends TripsState {}

class TripsLoading extends TripsState {}

class TripsLoaded extends TripsState {
  final List<Trip> trips;

  TripsLoaded(this.trips);
}

class TripsError extends TripsState {
  final String message;

  TripsError(this.message);
}
