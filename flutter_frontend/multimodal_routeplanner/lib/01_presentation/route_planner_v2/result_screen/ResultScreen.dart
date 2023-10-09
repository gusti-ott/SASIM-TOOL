import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/results_section/ResultSection.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/result_screen/title_image/TitleImage.dart';
import 'package:multimodal_routeplanner/02_application/bloc/sasim_2/trips_cubit.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key, required this.startAddress, required this.endAddress});

  final String startAddress;
  final String endAddress;

  @override
  Widget build(BuildContext context) {
    context.read<TripsCubit>().loadTrips(startAddress, endAddress);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TitleImage(),
            ResultSection(startAddress: startAddress, endAddress: endAddress),
          ],
        ),
      ),
    );
  }
}
