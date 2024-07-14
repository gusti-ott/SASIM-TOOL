import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

double calculateExternalCostsRate(Trip trip) {
  return trip.costs.externalCosts.all / trip.costs.getFullcosts();
}

int calculateExternalCostsPercantage(Trip trip) {
  double externalCostsRate = calculateExternalCostsRate(trip);
  return (externalCostsRate * 100).toInt();
}
