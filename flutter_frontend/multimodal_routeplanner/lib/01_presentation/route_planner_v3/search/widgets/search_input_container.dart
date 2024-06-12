import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/decorations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/search_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/address_input_components.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/electric_selection_components.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/mode_selection_components.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/shared_selection_components.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';

class SearchInputContent extends StatefulWidget {
  const SearchInputContent(
    this.state, {
    super.key,
    required this.isMobile,
  });

  final bool isMobile;
  final SearchState state;

  @override
  State<SearchInputContent> createState() => _SearchInputContentState();
}

class _SearchInputContentState extends State<SearchInputContent> {
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  String startAddress = '';
  String endAddress = '';
  SelectionMode selectionMode = SelectionMode.bicycle;
  bool isElectric = false;
  bool isShared = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.isMobile)
        ? buildMobileContent(context, widget.state,
            isElectric: isElectric,
            onElectricChanged: (value) {
              setState(() {
                isElectric = !isElectric;
              });
            },
            isShared: isShared,
            onSharedChanged: (value) {
              setState(() {
                isShared = value;
              });
            },
            startController: startController,
            endController: endController,
            onStartChanged: (value) {
              setState(() {
                startAddress = value;
              });
            },
            onEndChanged: (value) {
              setState(() {
                endAddress = value;
              });
            },
            swapInputs: swapInputs)
        : buildDesktopContent(context, widget.state,
            isElectric: isElectric,
            onElectricChanged: (value) {
              setState(() {
                isElectric = !isElectric;
              });
            },
            selectionMode: selectionMode,
            onSelectionModeChanged: (mode) {
              setState(() {
                selectionMode = mode;
              });
            },
            isShared: isShared,
            onSharedChanged: (value) {
              setState(() {
                isShared = value;
              });
            },
            startController: startController,
            endController: endController,
            onStartChanged: (value) {
              setState(() {
                startAddress = value;
              });
            },
            onEndChanged: (value) {
              setState(() {
                endAddress = value;
              });
            },
            swapInputs: swapInputs);
  }

  Widget buildDesktopContent(
    BuildContext context,
    SearchState state, {
    required bool isElectric,
    required Function(bool) onElectricChanged,
    required SelectionMode selectionMode,
    required Function(SelectionMode) onSelectionModeChanged,
    required bool isShared,
    required Function(bool) onSharedChanged,
    required TextEditingController startController,
    required TextEditingController endController,
    required Function onStartChanged,
    required Function onEndChanged,
    required Function swapInputs,
  }) {
    return Column(
      children: [
        extraLargeVerticalSpacer,
        modeSelectionRow(
          context,
          isElectric: isElectric,
          onElectricChanged: onElectricChanged,
          selectionMode: selectionMode,
          onSelectionModeChanged: onSelectionModeChanged,
          isShared: isShared,
          onSharedChanged: onSharedChanged,
        ),
        largeVerticalSpacer,
        addressInputRow(
          context,
          state,
          isMobile: false,
          startController: startController,
          endController: endController,
          onStartChanged: onStartChanged,
          onEndChanged: onEndChanged,
          swapInputs: swapInputs,
        ),
        routeErrorWidget(state),
      ],
    );
  }

  Widget buildMobileContent(
    BuildContext context,
    SearchState state, {
    required bool isElectric,
    required Function(bool) onElectricChanged,
    required bool isShared,
    required Function(bool) onSharedChanged,
    required TextEditingController startController,
    required TextEditingController endController,
    required Function onStartChanged,
    required Function onEndChanged,
    required Function swapInputs,
  }) {
    return Column(
      children: [
        mediumVerticalSpacer,
        mobileModeSelectionContainer(context,
            isElectric: isElectric,
            onElectricChanged: onElectricChanged,
            isShared: isShared,
            onSharedChanged: onSharedChanged),
        largeVerticalSpacer,
        addressInputRow(context, state,
            isMobile: true,
            startController: startController,
            endController: endController,
            onStartChanged: onStartChanged,
            onEndChanged: onEndChanged,
            swapInputs: swapInputs),
      ],
    );
  }

  Widget mobileModeSelectionContainer(BuildContext context,
      {required bool isElectric,
      required Function(bool) onElectricChanged,
      required bool isShared,
      required Function(bool) onSharedChanged}) {
    return Container(
      decoration: boxDecorationWithShadow(),
      padding: EdgeInsets.all(mediumPadding),
      child: Column(
        children: [
          modeSelectionPart(),
          smallVerticalSpacer,
          sharedSelectionPart(context, isShared: isShared, onSharedChanged: onSharedChanged),
          smallVerticalSpacer,
          electricSelectionPart(context, isElectric: isElectric, onElectricChanged: onElectricChanged),
        ],
      ),
    );
  }

  Widget modeSelectionPart() {
    return Row(
      children: [
        modeIconButton(
          icon: Icons.directions_bike_outlined,
          isSelected: selectionMode == SelectionMode.bicycle,
          onPressed: () {
            setState(() {
              selectionMode = SelectionMode.bicycle;
            });
          },
        ),
        modeIconButton(
          icon: Icons.directions_car_outlined,
          isSelected: selectionMode == SelectionMode.car,
          onPressed: () {
            setState(() {
              selectionMode = SelectionMode.car;
            });
          },
        ),
        modeIconButton(
          icon: Icons.directions_bus_outlined,
          isSelected: selectionMode == SelectionMode.publicTransport,
          onPressed: () {
            setState(() {
              selectionMode = SelectionMode.publicTransport;
            });
          },
        ),
      ],
    );
  }

  Widget modeIconButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: extraSmallPadding),
      decoration: isSelected
          ? BoxDecoration(
              color: secondaryColorV3,
              shape: BoxShape.circle,
            )
          : null,
      child: IconButton(
        icon: Icon(icon),
        color: isSelected ? Colors.black : Colors.grey,
        onPressed: onPressed,
      ),
    );
  }

  void swapInputs() {
    setState(() {
      String temp = startController.text;
      startController.text = endController.text;
      endController.text = temp;
    });
  }

  Widget routeErrorWidget(SearchState state) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    return Column(
      children: [
        if (state is SearchError) ...[
          smallVerticalSpacer,
          Text(
            '${lang.error}: ${state.message}',
            style: const TextStyle(color: Colors.red),
          )
        ] else if (state is SearchLoaded) ...[
          smallVerticalSpacer,
          Text(
            'Successfully loaded ${state.trips.length} trips',
            style: const TextStyle(color: Colors.green),
          )
        ],
      ],
    );
  }
}

enum SelectionMode { bicycle, car, publicTransport }
