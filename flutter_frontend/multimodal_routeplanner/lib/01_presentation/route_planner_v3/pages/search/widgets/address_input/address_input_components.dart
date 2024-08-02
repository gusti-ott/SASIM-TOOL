import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/address_picker_list.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/desktop_address_input_row.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/mobile_address_input_container.dart';
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
      ? DesktopAddressInputRow(
          cubit: cubit,
          startController: startController,
          endController: endController,
          onStartChanged: onStartChanged,
          onEndChanged: onEndChanged,
          swapInputs: swapInputs,
          selectedMode: selectedMode,
          isElectric: isElectric,
          isShared: isShared)
      : MobileAddressInputContainer(
          startController: startController,
          endController: endController,
          onStartChanged: onStartChanged,
          onEndChanged: onEndChanged,
          swapInputs: swapInputs,
          selectedMode: selectedMode,
          isElectric: isElectric,
          isShared: isShared);
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
