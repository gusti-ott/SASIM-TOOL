import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/result/result_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/address_input_components.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/widgets/mode_selection_components.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/config/setup_dependencies.dart';

class SearchInputContent extends StatefulWidget {
  const SearchInputContent({
    super.key,
    required this.isMobile,
  });

  final bool isMobile;

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

  ResultCubit cubit = sl<ResultCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.isMobile) ? buildMobileContent() : buildDesktopContent();
  }

  Widget buildDesktopContent() {
    return Column(
      children: [
        extraLargeVerticalSpacer,
        modeSelectionRow(
          context,
          isElectric: isElectric,
          onElectricChanged: (value) {
            setState(() {
              isElectric = value;
            });
          },
          selectionMode: selectionMode,
          onSelectionModeChanged: (value) {
            setState(() {
              selectionMode = value;
            });
          },
          isShared: isShared,
          onSharedChanged: (value) {
            setState(() {
              isShared = value;
            });
          },
        ),
        largeVerticalSpacer,
        addressInputRow(
          context,
          isMobile: false,
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
          swapInputs: swapInputs,
          selectedMode: selectionMode,
          isElectric: isElectric,
          isShared: isShared,
        ),
      ],
    );
  }

  Widget buildMobileContent() {
    return Column(
      children: [
        mediumVerticalSpacer,
        mobileModeSelectionContainer(context,
            selectedMode: selectionMode,
            onSelectionModeChanged: (value) {
              setState(() {
                selectionMode = value;
              });
            },
            isElectric: isElectric,
            onElectricChanged: (value) {
              setState(() {
                isElectric = value;
              });
            },
            isShared: isShared,
            onSharedChanged: (value) {
              setState(() {
                isShared = value;
              });
            }),
        largeVerticalSpacer,
        addressInputRow(context, isMobile: true, startController: startController, endController: endController,
            onStartChanged: (value) {
          setState(() {
            startAddress = value;
          });
        }, onEndChanged: (value) {
          setState(() {
            endAddress = value;
          });
        }, swapInputs: swapInputs, selectedMode: selectionMode, isElectric: isElectric, isShared: isShared),
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

  Widget routeErrorWidget(ResultState state) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    return Column(
      children: [
        if (state is ResultError) ...[
          smallVerticalSpacer,
          Text(
            '${lang.error}: ${state.message}',
            style: const TextStyle(color: Colors.red),
          )
        ] else if (state is ResultLoaded) ...[
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
