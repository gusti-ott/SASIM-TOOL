import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/decorations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/progress_indicators.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/search/search_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/config/setup_dependencies.dart';

class SearchInputContent extends StatefulWidget {
  const SearchInputContent(this.state, {super.key, required this.isMobile});

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
    return (widget.isMobile) ? buildMobileContent(context, widget.state) : buildDesktopContent(context, widget.state);
  }

  Widget buildDesktopContent(BuildContext context, SearchState state) {
    return Column(
      children: [
        extraLargeVerticalSpacer,
        modeSelectionRow(context),
        largeVerticalSpacer,
        addressInputRow(context, state, isMobile: false),
        routeErrorWidget(state),
      ],
    );
  }

  Widget buildMobileContent(BuildContext context, SearchState state) {
    return Column(
      children: [
        mediumVerticalSpacer,
        mobileModeSelectionContainer(context),
        largeVerticalSpacer,
        addressInputRow(context, state, isMobile: true),
      ],
    );
  }

  Widget modeSelectionRow(BuildContext context) {
    return Container(
      decoration: boxDecorationWithShadow(),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          modeSelectionPart(),
          sharedSelectionPart(context),
          electricSelectionPart(context),
        ],
      ),
    );
  }

  Widget mobileModeSelectionContainer(BuildContext context) {
    return Container(
      decoration: boxDecorationWithShadow(),
      padding: EdgeInsets.all(mediumPadding),
      child: Column(
        children: [
          modeSelectionPart(),
          smallVerticalSpacer,
          sharedSelectionPart(context),
          smallVerticalSpacer,
          electricSelectionPart(context),
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

  Widget sharedSelectionPart(BuildContext context) {
    return Row(
      children: [
        sharedChip(
          context,
          label: 'Private',
          icon: Icons.person,
          isSelected: !isShared,
          onSelected: () {
            setState(() {
              isShared = false;
            });
          },
        ),
        SizedBox(width: smallPadding),
        sharedChip(
          context,
          label: 'Shared',
          icon: Icons.supervised_user_circle,
          isSelected: isShared,
          onSelected: () {
            setState(() {
              isShared = true;
            });
          },
        ),
      ],
    );
  }

  Widget sharedChip(
    BuildContext context, {
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onSelected,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ChoiceChip(
      avatar: Icon(icon, color: isSelected ? Colors.black : Colors.grey),
      label: Text(label, style: textTheme.titleSmall!.copyWith(color: isSelected ? Colors.black : Colors.grey)),
      showCheckmark: false,
      selected: isSelected,
      onSelected: (selected) {
        onSelected();
      },
      selectedColor: secondaryColorV3,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: isSelected ? secondaryColorV3 : Colors.grey),
      ),
      labelStyle: textTheme.labelMedium!.copyWith(
        color: isSelected ? Colors.black : Colors.grey,
      ),
    );
  }

  Widget electricSelectionPart(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Text('Electric', style: textTheme.titleSmall!.copyWith(color: Colors.black)),
        Switch(
          value: isElectric,
          onChanged: (value) {
            setState(() {
              isElectric = value;
            });
          },
          activeColor: secondaryColorV3,
          inactiveThumbColor: Colors.grey,
        ),
      ],
    );
  }

  Widget addressInputRow(BuildContext context, SearchState state, {required bool isMobile}) {
    SearchCubit cubit = sl<SearchCubit>();

    return (!isMobile)
        ? desktopAddressInputRow(context, state, cubit)
        // TODO: add state logic here
        : mobileAddressInputContainer(context, state, cubit);
  }

  Column mobileAddressInputContainer(BuildContext context, SearchState state, SearchCubit cubit) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: textInputField(
                context,
                controller: startController,
                hintText: 'From',
                onChanged: (value) {
                  setState(() {
                    startAddress = value;
                  });
                },
              ),
            ),
            SizedBox(
              width: 50,
              child: IconButton(
                icon: const Icon(Icons.swap_horiz, color: Colors.grey),
                onPressed: () {
                  swapInputs();
                },
              ),
            ),
          ],
        ),
        smallVerticalSpacer,
        textInputField(
          context,
          controller: endController,
          hintText: 'To',
          onChanged: (value) {
            setState(() {
              endAddress = value;
            });
          },
        ),
        largeVerticalSpacer,
        statefulCalculateButton(state, cubit)
      ],
    );
  }

  Row desktopAddressInputRow(BuildContext context, SearchState state, SearchCubit cubit) {
    return Row(
      children: [
        Expanded(
          child: textInputField(
            context,
            controller: startController,
            hintText: 'From',
            onChanged: (value) {
              setState(() {
                startAddress = value;
              });
            },
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.swap_horiz, color: Colors.grey),
          onPressed: () {
            swapInputs();
          },
        ),
        const SizedBox(width: 8),
        Expanded(
          child: textInputField(
            context,
            controller: endController,
            hintText: 'To',
            onChanged: (value) {
              setState(() {
                endAddress = value;
              });
            },
          ),
        ),
        smallHorizontalSpacer,
        statefulCalculateButton(state, cubit),
      ],
    );
  }

  Widget statefulCalculateButton(SearchState state, SearchCubit cubit) {
    if (state is SearchLoading) {
      return circularProgressIndicatorWithPadding();
    } else {
      return IntrinsicWidth(
        child: customButton(
          label: 'Calculate',
          onTap: () {
            cubit.loadTrips(startAddress, endAddress);
          },
        ),
      );
    }
  }

  Widget textInputField(
    BuildContext context, {
    required TextEditingController controller,
    required String hintText,
    required ValueChanged<String> onChanged,
  }) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: boxDecorationWithShadow(),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          suffixIcon: Icon(Icons.location_on, color: tertiaryColorV3),
          hintText: hintText,
          hintStyle: textTheme.labelMedium!.copyWith(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none, // No visible border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.transparent), // Transparent border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: secondaryColorV3), // Border when the TextField is focused
          ),
        ),
        onChanged: onChanged,
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
    return Column(
      children: [
        if (state is SearchError) ...[
          smallVerticalSpacer,
          Text(
            'Error: ${state.message}',
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
