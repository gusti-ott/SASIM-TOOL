import 'package:flutter/material.dart';

class RowHeaderItem extends StatelessWidget {
  const RowHeaderItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TableCell(
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(right: BorderSide(color: colorScheme.onPrimary, width: 2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RotatedBox(
            quarterTurns: 3,
            child: Text(text,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          ),
        ),
      ),
    );
  }
}
