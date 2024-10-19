import 'package:multimodal_routeplanner/01_presentation/helpers/currency_formatting_helpers.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/ExternalCosts.dart';
import 'package:multimodal_routeplanner/03_domain/entities/costs/InternalCosts.dart';

class Costs {
  final ExternalCosts externalCosts;
  final InternalCosts internalCosts;

  Costs({required this.externalCosts, required this.internalCosts});

  double getFullcosts() {
    return double.parse(externalCosts.all.toStringAsFixed(2)) + double.parse(internalCosts.all.toStringAsFixed(2));
  }
}

extension CostsExtension on double {
  String get currencyString => formatCurrency(this);
}

// there was a renaming of external --> social and internal --> personal
// in the backend we still use the old naming with internal and external costs
enum CostsType { personal, social }
