import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/animations/background_loading_animation.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/progress_indicators.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/input_to_trip.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/widgets/detail_route_info/detail_route_info_section.dart';
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

  late ResultCubit cubit;

  Trip? selectedTrip;
  List<Trip>? trips;
  Color backgroundColor = Colors.white;

  SelectionMode? selectionMode;
  bool? isElectric;
  bool? isShared;

  late InfoViewType infoViewType;
  late DiagramType selectedDiagramType;
  bool showAdditionalMobileInfo = false;

  ContentLayer contentLayer = ContentLayer.layer1;

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
  late AnimationController _animationController;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();

    cubit = sl<ResultCubit>();

    selectionMode = widget.selectedMode ?? SelectionMode.bicycle;
    isElectric = widget.isElectric ?? false;
    isShared = widget.isShared ?? false;

    cubit.loadTrips(widget.startAddress, widget.endAddress);
    _startColorAnimation();

    infoViewType = InfoViewType.map;
    selectedDiagramType = DiagramType.total;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startColorAnimation() {
    // Define the duration of the entire animation cycle (forward and backward)
    const duration = Duration(seconds: 10);

    _animationController = AnimationController(
      duration: duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = backgroundLoadingAnimation(_animationController);

    _animation.addListener(() {
      setState(() {
        backgroundColor = _animation.value!;
      });
    });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;

    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 1000;

    return BlocConsumer<ResultCubit, ResultState>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        Widget child = const Center(child: Text('Waiting for something to happen ...'));
        FloatingActionButton? fab;
        if (state is ResultLoading) {
          child = Padding(
            padding: EdgeInsets.all(mediumPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/mobiscore_logos/logo_with_text_primary.png', width: 100),
                largeVerticalSpacer,
                circularProgressIndicatorWithPadding(color: primaryColorV3),
                largeVerticalSpacer,
                Text(
                  '${lang.route_is_loading} ${state.loadedTrips}/${state.totalTrips}',
                  style: textTheme.headlineMedium!.copyWith(color: primaryColorV3),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (state is ResultLoaded) {
          trips = state.trips;
          fab = isMobile && !showAdditionalMobileInfo
              ? FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      showAdditionalMobileInfo = !showAdditionalMobileInfo;
                    });
                  },
                  child: Icon(
                    Icons.map,
                    color: colorE,
                    size: 30,
                  ),
                )
              : null;
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
                  screenWidth: screenWidth,
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
                  infoViewType: infoViewType,
                  selectedDiagramType: selectedDiagramType,
                  setInfoViewTypeCallback: (InfoViewType value) {
                    setState(() {
                      infoViewType = value;
                    });
                  },
                  setDiagramTypeCallback: (DiagramType diagramType) {
                    setState(() {
                      selectedDiagramType = diagramType;
                    });
                    if (!showAdditionalMobileInfo) {
                      setState(() {
                        showAdditionalMobileInfo = true;
                      });
                    }
                  },
                  contentLayer: contentLayer,
                  changeLayerCallback: (value) {
                    setState(() {
                      contentLayer = value;
                      if (contentLayer == ContentLayer.layer1) {
                        selectedDiagramType = DiagramType.total;
                      } else if (contentLayer == ContentLayer.layer2) {
                        selectedDiagramType = DiagramType.detailSocial;
                      }
                    });
                  },
                  showAdditionalMobileInfo: showAdditionalMobileInfo,
                  hideAdditionalInfoCallback: () {
                    setState(() {
                      showAdditionalMobileInfo = false;
                    });
                  },
                  backgroundColor: backgroundColor,
                );
              }
            } else {
              child = const Center(child: Text('No trips found'));
            }
          }
        }
        return Scaffold(backgroundColor: backgroundColor, body: child, floatingActionButton: fab);
      },
    );
  }
}
