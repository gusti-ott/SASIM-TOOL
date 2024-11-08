import 'dart:html' as html;

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/animations/background_loading_animation.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/decorations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/progress_indicators.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/v3_scaffold.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/input_to_trip.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/mobiscore_to_x.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/detail_route_info/detail_route_info_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_content.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/search_screen_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/values/dimensions.dart';
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
      this.isShared,
      this.startCoordinates,
      this.endCoordinates});

  final String startAddress;
  final String endAddress;
  final SelectionMode? selectedMode;
  final bool? isElectric;
  final bool? isShared;
  final String? startCoordinates;
  final String? endCoordinates;

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
  Color backgroundColor = backgroundColorGreyV3;

  SelectionMode? selectionMode;
  bool? isElectric;
  bool? isShared;

  bool tripNotAvailable = false;
  String? notAvailableMode;

  late InfoViewType infoViewType;
  late DiagramType selectedDiagramType;
  bool showAdditionalMobileInfo = false;

  ContentLayer contentLayer = ContentLayer.layer1;

  bool updateSelectedTrip({SelectionMode? updatedSelectionMode, bool? updatedIsElectric, bool? updatedIsShared}) {
    logger.i(
        'updating selected trip to mode: $updatedSelectionMode, electric: $updatedIsElectric, shared: $updatedIsShared');
    updatedSelectionMode ??= selectionMode;
    updatedIsElectric ??= isElectric;
    updatedIsShared ??= isShared;
    String? tripMode = getTripModeFromInput(
        mode: updatedSelectionMode, isElectric: updatedIsElectric, isShared: updatedIsShared, trips: trips);
    Trip? trip;
    if (trips != null) {
      trip = trips!.firstWhereOrNull((trip) => trip.mode == tripMode);
      if (trip != null) {
        setState(() {
          selectedTrip = trip;
          notAvailableMode = null;
          tripNotAvailable = false;
        });
        return true;
      } else {
        setState(() {
          tripNotAvailable = true;
          notAvailableMode = tripMode;
        });
        // log error with selection mode, electric and sharing information
        logger.e('trip not available for mode: $tripMode, electric: $updatedIsElectric, shared: $updatedIsShared');
      }
    } else {
      setState(() {
        tripNotAvailable = true;
        notAvailableMode = tripMode;
      });
      logger.e('trips is null');
    }
    return false;
  }

  // states for the loading animation here
  late AnimationController _animationController;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();

    cubit = sl<ResultCubit>();
    cubit.loadTrips(widget.startAddress, widget.endAddress, widget.startCoordinates, widget.endCoordinates);

    selectionMode = widget.selectedMode ?? SelectionMode.bicycle;
    isElectric = widget.isElectric ?? false;
    isShared = widget.isShared ?? false;

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
    bool isMobile = screenWidth < mobileScreenWidthMinimum;

    return BlocConsumer<ResultCubit, ResultState>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        Widget child = resultErrorWidget(context);
        FloatingActionButton? fab;
        if (state is ResultLoading) {
          child = buildLoadingWidget(lang, state, textTheme);
        } else if (state is ResultLoaded) {
          trips = state.trips;
          fab = isMobile && !showAdditionalMobileInfo
              ? FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      showAdditionalMobileInfo = !showAdditionalMobileInfo;
                      infoViewType = InfoViewType.map;
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
                  trips: trips,
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
                    bool successful = updateSelectedTrip(updatedSelectionMode: mode);
                    if (successful) {
                      setState(() {
                        selectionMode = mode;
                      });
                    }
                  },
                  onElectricChanged: (electric) {
                    bool successful = updateSelectedTrip(updatedIsElectric: electric);
                    if (successful) {
                      setState(() {
                        isElectric = electric;
                      });
                    }
                  },
                  onSharedChanged: (shared) {
                    bool successful = updateSelectedTrip(updatedIsShared: shared);
                    if (successful) {
                      setState(() {
                        isShared = shared;
                      });
                    }
                  },
                  infoViewType: infoViewType,
                  selectedDiagramType: selectedDiagramType,
                  setInfoViewTypeCallback: (InfoViewType value) {
                    setState(() {
                      infoViewType = value;
                    });
                    if (!showAdditionalMobileInfo) {
                      setState(() {
                        showAdditionalMobileInfo = true;
                      });
                    }
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
                      } else if (contentLayer == ContentLayer.layer2details) {
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
                  startAddress: widget.startAddress,
                  startCoordinates: widget.startCoordinates,
                  endAddress: widget.endAddress,
                  endCoordinates: widget.endCoordinates,
                  onMobiscoreLogoPressed: () {
                    if (!showAdditionalMobileInfo) {
                      setState(() {
                        showAdditionalMobileInfo = true;
                      });
                    }
                    setState(() {
                      infoViewType = InfoViewType.mobiscore;
                    });
                  },
                  tripNotAvailable: tripNotAvailable,
                  notAvailableMode: notAvailableMode,
                  setTripAvailableCallback: (value) {
                    setState(() {
                      tripNotAvailable = value;
                    });
                  },
                );
              }
            } else {
              child = resultErrorWidget(context);
            }
          }
        }
        return V3Scaffold(
          backgroundColor: backgroundColor,
          body: child,
          floatingActionButton: fab,
        );
      },
    );
  }

  Padding buildLoadingWidget(AppLocalizations lang, ResultLoading state, TextTheme textTheme) {
    return Padding(
      padding: EdgeInsets.all(mediumPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 80),
          Column(
            children: [
              circularProgressIndicatorWithPadding(color: primaryColorV3),
              largeVerticalSpacer,
              Text(
                '${lang.route_is_loading} ${state.loadedTrips}/${state.totalTrips}',
                style: textTheme.headlineMedium!.copyWith(color: primaryColorV3),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: extraLargePadding),
            child: Image.asset('assets/mobiscore_logos/logo_with_text_primary.png', width: 100),
          ),
        ],
      ),
    );
  }
}

Widget resultErrorWidget(BuildContext context) {
  TextTheme textTheme = Theme.of(context).textTheme;
  AppLocalizations lang = AppLocalizations.of(context)!;
  return Padding(
    padding: EdgeInsets.all(mediumPadding),
    child: Center(
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Container(
            decoration: customBoxDecorationWithShadow(backgroundColor: backgroundColorGreyV3),
            child: Padding(
              padding: EdgeInsets.all(largePadding),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.u_turn_right, size: 70, color: colorE),
                    largeVerticalSpacer,
                    Text(lang.something_went_wrong, style: textTheme.displayMedium, textAlign: TextAlign.center),
                    smallVerticalSpacer,
                    Text(lang.please_try_again, style: textTheme.headlineSmall, textAlign: TextAlign.center),
                    largeVerticalSpacer,
                    Wrap(alignment: WrapAlignment.center, runSpacing: smallPadding, spacing: smallPadding, children: [
                      V3CustomButton(
                          label: lang.new_route,
                          leadingIcon: Icons.arrow_back,
                          reverseColors: true,
                          color: primaryColorV3,
                          textColor: primaryColorV3,
                          onTap: () {
                            context.goNamed(SearchScreenV3.routeName);
                          }),
                      V3CustomButton(
                        leadingIcon: Icons.refresh_rounded,
                        label: lang.reload,
                        onTap: () {
                          if (kIsWeb) {
                            html.window.location.reload();
                          }
                        },
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
