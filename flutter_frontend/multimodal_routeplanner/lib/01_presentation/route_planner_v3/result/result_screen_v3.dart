import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/progress_indicators.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/input_to_trip.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_color.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/result_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/result_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/config/setup_dependencies.dart';
import 'package:multimodal_routeplanner/logger.dart';

class ResultScreenV3 extends StatefulWidget {
  const ResultScreenV3(
      {super.key,
      required this.startAddress,
      required this.endAddress,
      this.selectedMode,
      this.isElectric,
      this.isShared});

  final String startAddress;
  final String endAddress;
  final SelectionMode? selectedMode;
  final bool? isElectric;
  final bool? isShared;

  static const String routeName = 'v3-result';
  static const String path = 'result';

  @override
  State<ResultScreenV3> createState() => _ResultScreenV3State();
}

class _ResultScreenV3State extends State<ResultScreenV3> with SingleTickerProviderStateMixin {
  Logger logger = getLogger();

  Trip? selectedTrip;
  List<Trip>? trips;
  Color backgroundColor = Colors.white;

  SelectionMode? selectionMode;
  bool? isElectric;
  bool? isShared;

  void updateSelectedTrip() {
    logger.i('updating selected trip');
    String? tripMode = getTripModeFromInput(mode: selectionMode, isElectric: isElectric, isShared: isShared);
    Trip? trip;
    if (trips != null) {
      trip = trips!.firstWhereOrNull((trip) => trip.mode == tripMode);
      if (trip != null) {
        setState(() {
          selectedTrip = trip;
        });
      } else {
        logger.e('trip not found');
      }
    } else {
      logger.e('trips is null');
    }
  }

  // states for the loading animation here
  late AnimationController _controller;
  late Animation<Color?> _animation;

  final List<Color> _animationColors = [
    lightColorA,
    lightColorB,
    lightColorC,
    lightColorD,
    lightColorE,
  ];

  ResultCubit cubit = sl<ResultCubit>();

  @override
  void initState() {
    super.initState();

    selectionMode = widget.selectedMode ?? SelectionMode.bicycle;
    isElectric = widget.isElectric ?? false;
    isShared = widget.isShared ?? false;

    cubit.loadTrips(widget.startAddress, widget.endAddress);
    _startColorAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startColorAnimation() {
    // Define the duration of the entire animation cycle (forward and backward)
    const duration = Duration(seconds: 10);

    _controller = AnimationController(
      duration: duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(begin: _animationColors[0], end: _animationColors[1]),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(begin: _animationColors[1], end: _animationColors[2]),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(begin: _animationColors[2], end: _animationColors[3]),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(begin: _animationColors[3], end: _animationColors[4]),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(begin: _animationColors[4], end: _animationColors[3]),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(begin: _animationColors[3], end: _animationColors[2]),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(begin: _animationColors[2], end: _animationColors[1]),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(begin: _animationColors[1], end: _animationColors[0]),
        ),
      ],
    ).animate(_controller);

    _animation.addListener(() {
      setState(() {
        backgroundColor = _animation.value!;
      });
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return BlocConsumer<ResultCubit, ResultState>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        Widget child = const SizedBox();
        if (state is ResultLoading) {
          // The background color will animate when in SearchLoading state
          child = circularProgressIndicatorWithPadding();
        } else if (state is ResultLoaded) {
          trips = state.trips;
          if (trips != null) {
            if (trips!.isNotEmpty) {
              if (selectedTrip == null) {
                String? tripMode = getTripModeFromInput(
                  mode: selectionMode!,
                  isElectric: isElectric!,
                  isShared: isShared!,
                );
                selectedTrip = state.trips.firstWhereOrNull((trip) => trip.mode == tripMode);
              }
              if (selectedTrip != null && selectionMode != null && isElectric != null && isShared != null) {
                String mobiScore = selectedTrip!.mobiScore;
                backgroundColor = getColorFromMobiScore(mobiScore, isLight: true);
                child = ResultContent(
                  isMobile: isMobile,
                  trips: state.trips,
                  selectedTrip: selectedTrip!,
                  selectionMode: selectionMode!,
                  isElectric: isElectric!,
                  isShared: isShared!,
                  onSelectionModeChanged: (mode) {
                    setState(() {
                      selectionMode = mode;
                    });
                    updateSelectedTrip();
                  },
                  onElectricChanged: (electric) {
                    setState(() {
                      isElectric = electric;
                    });
                    updateSelectedTrip();
                  },
                  onSharedChanged: (shared) {
                    setState(() {
                      isShared = shared;
                    });
                    updateSelectedTrip();
                  },
                );
              }
            } else {
              child = const Center(child: Text('No trips found'));
            }
          }
        }
        return Scaffold(backgroundColor: backgroundColor, body: child);
      },
    );
  }
}
