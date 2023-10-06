import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/ResultSection.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/title_image/TitleImage.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key, required this.startAddress, required this.endAddress});

  final String startAddress;
  final String endAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TitleImage(),
          ResultSection(startAddress: startAddress, endAddress: endAddress),
        ],
      ),
    );
  }
}
