import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/decorations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_picker_list.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/calculate_button.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
import 'package:multimodal_routeplanner/02_application/bloc/address_picker/address_picker_bloc.dart';
import 'package:multimodal_routeplanner/config/setup_dependencies.dart';

Widget addressInputRow(BuildContext context,
    {required bool isMobile,
    required TextEditingController startController,
    required TextEditingController endController,
    required Function onStartChanged,
    required Function onEndChanged,
    required Function swapInputs,
    required SelectionMode selectedMode,
    required bool isElectric,
    required bool isShared}) {
  ResultCubit cubit = sl<ResultCubit>();

  return (!isMobile)
      ? desktopAddressInputRow(context,
          cubit: cubit,
          startController: startController,
          endController: endController,
          onStartChanged: onStartChanged,
          onEndChanged: onEndChanged,
          swapInputs: swapInputs,
          selectedMode: selectedMode,
          isElectric: isElectric,
          isShared: isShared)
      : mobileAddressInputContainer(context,
          cubit: cubit,
          startController: startController,
          endController: endController,
          onStartChanged: onStartChanged,
          onEndChanged: onEndChanged,
          swapInputs: swapInputs,
          selectedMode: selectedMode,
          isElectric: isElectric,
          isShared: isShared);
}

Column mobileAddressInputContainer(BuildContext context,
    {required ResultCubit cubit,
    required startController,
    required endController,
    required Function onStartChanged,
    required Function onEndChanged,
    required Function swapInputs,
    required SelectionMode selectedMode,
    required bool isElectric,
    required bool isShared}) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  AddressPickerBloc addressPickerBloc = sl<AddressPickerBloc>();
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: textInputField(context, controller: startController, hintText: lang.from, onChanged: (value) {
              onStartChanged(value);
              addressPickerBloc.add(
                StartAddressInputChanged(value),
              );
            }, isMobile: true),
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
      Row(
        children: [
          Expanded(child: startAddressPickerBuilder(addressPickerBloc, startController, isMobile: true)),
          const SizedBox(
            width: 50,
          )
        ],
      ),
      smallVerticalSpacer,
      textInputField(context, controller: endController, hintText: lang.to, onChanged: (value) {
        onEndChanged(value);
        addressPickerBloc.add(
          EndAddressInputChanged(value),
        );
      }, isMobile: true),
      endAddressPickerBuilder(addressPickerBloc, endController, isMobile: true),
      mediumVerticalSpacer,
      statefulCalculateButton(context,
          cubit: cubit,
          startAddress: startController.text,
          endAddress: endController.text,
          selectedMode: selectedMode,
          isElectric: isElectric,
          isShared: isShared,
          width: 220),
    ],
  );
}

Widget desktopAddressInputRow(BuildContext context,
    {required ResultCubit cubit,
    required startController,
    required endController,
    required Function onStartChanged,
    required Function onEndChanged,
    required Function swapInputs,
    required SelectionMode selectedMode,
    required bool isElectric,
    required bool isShared}) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  AddressPickerBloc addressPickerBloc = sl<AddressPickerBloc>();
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: textInputField(context, controller: startController, hintText: lang.from, onChanged: (value) {
              onStartChanged(value);
              addressPickerBloc.add(
                StartAddressInputChanged(value),
              );
            }, isMobile: false),
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
            child: textInputField(context, controller: endController, hintText: lang.to, onChanged: (value) {
              onEndChanged(value);
              addressPickerBloc.add(
                EndAddressInputChanged(value),
              );
            }, isMobile: false),
          ),
          smallHorizontalSpacer,
          statefulCalculateButton(
            context,
            cubit: cubit,
            startAddress: startController.text,
            endAddress: endController.text,
            selectedMode: selectedMode,
            isElectric: isElectric,
            isShared: isShared,
          ),
        ],
      ),
      Row(
        children: [
          Expanded(child: startAddressPickerBuilder(addressPickerBloc, startController)),
          const SizedBox(width: 45),
          Expanded(child: endAddressPickerBuilder(addressPickerBloc, endController)),
          const SizedBox(
            width: 95,
          )
        ],
      )
    ],
  );
}

BlocBuilder<AddressPickerBloc, AddressPickerState> endAddressPickerBuilder(
    AddressPickerBloc addressPickerBloc, endController,
    {bool isMobile = false}) {
  return BlocBuilder<AddressPickerBloc, AddressPickerState>(
      bloc: addressPickerBloc,
      builder: (context, state) {
        if (state is RetrievingEndAddress) {
          return loadingIndicator(isMobile: isMobile);
        } else if (state is EndAddressRetrieved) {
          if (state.listAddresses.isNotEmpty) {
            return AddressPickerListV3(
                width: double.infinity,
                listAddresses: state.listAddresses,
                addressInputController: endController,
                onAddressSelectedCallback: (address) {
                  addressPickerBloc.add(PickEndAddress(address));
                });
          }
        }
        return SizedBox(height: !isMobile ? 200 : null);
      });
}

BlocBuilder<AddressPickerBloc, AddressPickerState> startAddressPickerBuilder(
    AddressPickerBloc addressPickerBloc, TextEditingController controller,
    {bool isMobile = false, double? width}) {
  return BlocBuilder<AddressPickerBloc, AddressPickerState>(
      bloc: addressPickerBloc,
      builder: (context, state) {
        if (state is RetrievingStartAddress) {
          return loadingIndicator(isMobile: isMobile);
        } else if (state is StartAddressRetrieved) {
          if (state.listAddresses.isNotEmpty) {
            return AddressPickerListV3(
                width: width ?? double.infinity,
                listAddresses: state.listAddresses,
                addressInputController: controller,
                onAddressSelectedCallback: (address) {
                  addressPickerBloc.add(PickStartAddress(address));
                });
          }
        }
        return SizedBox(height: !isMobile ? 200 : null);
      });
}

SizedBox loadingIndicator({bool isMobile = false}) {
  return SizedBox(
      height: !isMobile ? 200 : null,
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.all(smallPadding),
          child: LinearProgressIndicator(
            color: secondaryColorV3,
          ),
        ),
      ));
}

Widget textInputField(
  BuildContext context, {
  required TextEditingController controller,
  required String hintText,
  required ValueChanged<String> onChanged,
  required bool isMobile,
}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return Container(
    decoration: customBoxDecorationWithShadow(),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: const Icon(Icons.search, color: Colors.black),
        suffixIcon: Icon(Icons.location_on, color: tertiaryColorV3, fill: 0.5),
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
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      ),
      onChanged: onChanged,
      maxLines: 1, // Ensure single-line input
      textInputAction: TextInputAction.done, // Handle done action on keyboard
      style: textTheme.labelMedium, // Style the text
      // Ensure text scrolls to the end when focused
      keyboardType: TextInputType.text,
      textAlignVertical: TextAlignVertical.center,
    ),
  );
}
