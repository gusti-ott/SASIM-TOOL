import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class TripInfoItem extends StatelessWidget {
  const TripInfoItem(
      {super.key, required this.iconData, required this.selectedTrip});

  final IconData iconData;
  final Trip selectedTrip;

  @override
  Widget build(BuildContext context) {
    Color contentColor = Theme.of(context).colorScheme.onPrimary;
    TextTheme textTheme = Theme.of(context).textTheme;

    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(iconData, size: 32, color: contentColor),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.timer_outlined, color: contentColor),
                  Text(
                    "${selectedTrip.duration.toStringAsFixed(0)}'",
                    style: textTheme.titleMedium!.copyWith(color: contentColor),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.route_outlined, color: contentColor),
                  Text(
                    '${selectedTrip.distance.toStringAsFixed(1)} km',
                    style: textTheme.titleMedium!.copyWith(color: contentColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
