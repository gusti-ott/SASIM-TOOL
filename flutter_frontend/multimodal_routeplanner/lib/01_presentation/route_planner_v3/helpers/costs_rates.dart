import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/ExternalCosts.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/InternalCosts.dart';

int calculatePercentageFromRate(double rate) {
  return (rate * 100).round();
}

int getSocialCostsPercentage(Trip trip) {
  int percentage = calculatePercentageFromRate(trip.costs.externalCosts.all / trip.costs.getFullcosts());
  return percentage;
}

int getSocialTimeCostsPercentage(Trip trip) {
  int percentage = calculatePercentageFromRate(trip.costs.externalCosts.timeCosts / trip.costs.externalCosts.all);
  return percentage;
}

int getSocialHealthCostsPercentage(Trip trip) {
  int percentage = calculatePercentageFromRate(trip.costs.externalCosts.healthCosts / trip.costs.externalCosts.all);
  return percentage;
}

int getSocialEnvironmentalCostsPercentage(Trip trip) {
  int percentage =
      calculatePercentageFromRate(trip.costs.externalCosts.environmentCosts / trip.costs.externalCosts.all);
  return percentage;
}

int getPrivateFixedCostsPercentage(Trip trip) {
  int percentage = calculatePercentageFromRate(trip.costs.internalCosts.fixedCosts / trip.costs.internalCosts.all);
  return percentage;
}

int getPrivateVariableCostsPercentage(Trip trip) {
  int percentage = calculatePercentageFromRate(trip.costs.internalCosts.variableCosts / trip.costs.internalCosts.all);
  return percentage;
}
