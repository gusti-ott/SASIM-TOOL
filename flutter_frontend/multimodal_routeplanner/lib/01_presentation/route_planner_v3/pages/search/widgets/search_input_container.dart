import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/values.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/address_input_components.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/mode_selection_components.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/typography.dart';
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
  String? startCoordinates;
  String? endCoordinates;
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
    return (widget.isMobile) ? buildMobileContent(context) : buildDesktopContent(context);
  }

  Widget buildDesktopContent(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: heightSearchBar / 2),
          child: addressNote(lang, textTheme),
        ),
        smallVerticalSpacer,
        addressInputRow(
          context,
          isMobile: false,
          startController: startController,
          startCoordinates: startCoordinates,
          endController: endController,
          endCoordinates: endCoordinates,
          onStartChanged: (value, lat, lon) {
            setState(() {
              startAddress = value;
              if (lat != null && lon != null) {
                startCoordinates = '$lat,$lon';
              }
            });
          },
          onEndChanged: (address, lat, lon) {
            setState(() {
              endAddress = address;
              if (lat != null && lon != null) {
                endCoordinates = '$lat,$lon';
              }
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

  Widget buildMobileContent(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    TextTheme textTheme = Theme.of(context).textTheme;
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
        addressNote(lang, textTheme),
        smallVerticalSpacer,
        addressInputRow(context,
            isMobile: true,
            startController: startController,
            startCoordinates: startCoordinates,
            endController: endController,
            endCoordinates: endCoordinates, onStartChanged: (value, lat, lon) {
          setState(() {
            startAddress = value;
            if (lat != null && lon != null) {
              startCoordinates = '$lat,$lon';
            }
          });
        }, onEndChanged: (value, lat, lon) {
          setState(() {
            endAddress = value;
            if (lat != null && lon != null) {
              endCoordinates = '$lat,$lon';
            }
          });
        }, swapInputs: swapInputs, selectedMode: selectionMode, isElectric: isElectric, isShared: isShared),
      ],
    );
  }

  Widget addressNote(AppLocalizations lang, TextTheme textTheme) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(lang.note_address,
            style: widget.isMobile
                ? mobileSearchSubtitleTextStyle.copyWith(color: primaryColorV3, fontStyle: FontStyle.italic)
                : textTheme.bodyMedium!.copyWith(color: primaryColorV3, fontStyle: FontStyle.italic)));
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
}
