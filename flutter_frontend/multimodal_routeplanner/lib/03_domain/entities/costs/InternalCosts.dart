class InternalCosts {
  final double all;

  InternalCosts({required this.all});
}

extension InternalCostsExtension on InternalCosts {
  // TODO: replace by real implementation
  double get fixedCosts => 0.7 * all;

  double get variableCosts => 0.3 * all;
}

enum PersonalCostsCategory { fixed, variable }
