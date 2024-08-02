import 'package:multimodal_routeplanner/03_domain/entities/costs/InternalCosts.dart';

class InternalCostsModel extends InternalCosts {
  InternalCostsModel({required double all, required double fixed, required double variable})
      : super(all: all, fixed: fixed, variable: variable);

  factory InternalCostsModel.fromJson(Map<String, dynamic> json) {
    return InternalCostsModel(all: json['all'], fixed: json['fixed'], variable: json['variable']);
  }
}
