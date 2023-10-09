import 'package:flutter/material.dart';

Widget resultTitleWithIcon(
    BuildContext context, IconData icon, double duration, double distance) {
  TextTheme textTheme = Theme.of(context).textTheme;
  ColorScheme colorScheme = Theme.of(context).colorScheme;

  Color contentColor = colorScheme.onPrimary;

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(icon, size: 32, color: contentColor),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.timer_outlined, color: contentColor),
          Text(
            "${duration.toStringAsFixed(0)}'",
            style: textTheme.titleMedium!.copyWith(color: contentColor),
          ),
          const SizedBox(width: 16),
          Icon(Icons.route_outlined,
              color: Theme.of(context).colorScheme.primary),
          Text(
            '${distance.toStringAsFixed(1)} km',
            style: textTheme.titleMedium!.copyWith(color: contentColor),
          ),
        ],
      ),
    ],
  );
}
