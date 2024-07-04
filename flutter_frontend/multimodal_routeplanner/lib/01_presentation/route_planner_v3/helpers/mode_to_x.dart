import 'package:flutter/material.dart';

IconData getIconDataFromMode(String mode, {bool isOutlined = true}) {
  switch (mode) {
    case 'WALK':
      return isOutlined ? Icons.directions_walk_outlined : Icons.directions_walk;

    case 'CAR':
    case 'SHARENOW':
      return isOutlined ? Icons.directions_car_outlined : Icons.directions_car;

    case 'ECAR':
      return isOutlined ? Icons.electric_car_outlined : Icons.electric_car;
    case 'CAB':
    case 'BICYCLE':
      return isOutlined ? Icons.pedal_bike_outlined : Icons.pedal_bike;
    case 'EBICYCLE':
      return isOutlined ? Icons.electric_bike_outlined : Icons.electric_bike;
    case 'PT':
      return isOutlined ? Icons.directions_bus_outlined : Icons.directions_bus;
    default:
      return isOutlined ? Icons.directions_walk_outlined : Icons.directions_walk;
  }
}
