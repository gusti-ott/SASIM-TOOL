import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/ResultTable.dart';

class ResultSection extends StatelessWidget {
  const ResultSection(
      {super.key, required this.startAddress, required this.endAddress});

  final String startAddress;
  final String endAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        routeInfoHeader(context),
        ResultTable(),
      ],
    );
  }

  Widget routeInfoHeader(BuildContext context) {
    double iconSpace = 32;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Color contentColor = colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          addressInfo(context, 'VON', startAddress, contentColor),
          SizedBox(width: iconSpace),
          Icon(
            Icons.double_arrow,
            color: contentColor,
            size: 48,
          ),
          SizedBox(width: iconSpace),
          addressInfo(context, 'NACH', endAddress, contentColor),
        ],
      ),
    );
  }

  Widget addressInfo(
      BuildContext context, String label, String address, Color contentColor) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: contentColor, fontWeight: FontWeight.bold),
        ),
        Text(
          address,
          style: textTheme.bodyLarge!.copyWith(color: contentColor),
        ),
      ],
    );
  }
}
