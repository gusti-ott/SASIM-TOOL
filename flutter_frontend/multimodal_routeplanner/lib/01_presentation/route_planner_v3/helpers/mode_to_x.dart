import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';

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

Widget getIconFromMode(String mode, {bool isOutlined = true, double? size}) {
  switch (mode) {
    case 'CAB':
    case 'SHARENOW':
      return Padding(
        padding: EdgeInsets.all((size != null) ? size / 10 : 2.4),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Icon(getIconDataFromMode(mode, isOutlined: isOutlined), size: size)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Icon(
                Icons.sync_alt,
                size: size != null ? size / 1.5 : 12,
              ),
            )
          ],
        ),
      );

    default:
      return Icon(getIconDataFromMode(mode, isOutlined: isOutlined), size: size);
  }
}

String getModeNameWithArticle(BuildContext context, String mode) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  switch (mode) {
    case 'BICYCLE':
      return lang.private_bike;
    case 'EBICYCLE':
      return lang.private_ebike;
    case 'CAB':
      return lang.shared_bike;
    case 'CAR':
      return lang.private_car;
    case 'ECAR':
      return lang.private_ecar;
    case 'SHARENOW':
      return lang.shared_car;
    case 'PT':
      return lang.public_transport;
    default:
      return lang.unknown;
  }
}
