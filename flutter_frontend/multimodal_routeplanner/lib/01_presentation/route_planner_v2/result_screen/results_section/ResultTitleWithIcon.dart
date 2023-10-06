import 'package:flutter/material.dart';

Widget resultTitleWithIcon(
    BuildContext context,
    IconData icon,
    double duration,
    double distance,
    Color contentColor,
    String selectedMode,
    VoidCallback onDropdownChanged) {
  TextTheme textTheme = Theme.of(context).textTheme;

  return Column(children: [
    DropdownButton<String>(
      value: selectedMode,
      onChanged: (value) {
        onDropdownChanged();
      },
      items: ['PKW', 'ÖPNV', 'Fahrrad']
          .map((String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
    ),
    Icon(icon, size: 32, color: contentColor),
    const SizedBox(height: 16),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.timer_outlined,
            color: Theme.of(context).colorScheme.primary),
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
    )
  ]);
}

List<String> listModes = ['PKW', 'ÖPNV', 'Fahrrad'];
