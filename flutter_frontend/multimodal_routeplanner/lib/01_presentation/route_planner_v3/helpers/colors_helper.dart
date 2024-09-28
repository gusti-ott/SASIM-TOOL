import 'package:flutter/material.dart';

extension ColorsExtenison on Color {
  Color lighten(double rate) {
    assert(rate >= 0 && rate <= 1, 'Amount should be between 0 and 1');
    return Color.lerp(this, Colors.white, rate) ?? this;
  }

  Color darken(double rate) {
    assert(rate >= 0 && rate <= 1, 'Amount should be between 0 and 1');
    return Color.lerp(this, Colors.black, rate) ?? this;
  }
}
