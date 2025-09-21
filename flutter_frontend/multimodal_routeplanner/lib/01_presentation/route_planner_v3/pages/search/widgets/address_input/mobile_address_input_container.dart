import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_screen_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/address_input_components.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/address_input_field.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/input_validation.dart';
import 'package:multimodal_routeplanner/02_application/bloc/address_picker/address_picker_bloc.dart';
import 'package:multimodal_routeplanner/config/setup_dependencies.dart';

class MobileAddressInputContainer extends StatefulWidget {
  final TextEditingController startController;
  final String? startCoordinates;
  final TextEditingController endController;
  final String? endCoordinates;
  final Function(String, String?, String?) onStartChanged;
  final Function(String, String?, String?) onEndChanged;
  final Function swapInputs;
  final SelectionMode selectedMode;
  final bool isElectric;
  final bool isShared;

  const MobileAddressInputContainer({
    Key? key,
    required this.startController,
    this.startCoordinates,
    required this.endController,
    this.endCoordinates,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.swapInputs,
    required this.selectedMode,
    required this.isElectric,
    required this.isShared,
  }) : super(key: key);

  @override
  State<MobileAddressInputContainer> createState() => _MobileAddressInputContainerState();
}

class _MobileAddressInputContainerState extends State<MobileAddressInputContainer> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    AddressPickerBloc addressPickerBloc = sl<AddressPickerBloc>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addressInputField(
                      context,
                      controller: widget.startController,
                      hintText: lang.from_hint,
                      onChanged: (value) {
                        widget.onStartChanged(value, null, null);
                        addressPickerBloc.add(
                          StartAddressInputChanged(value),
                        );
                      },
                      isMobile: true,
                      validator: (value) {
                        return validateInput(context, value);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                  icon: const Icon(Icons.swap_horiz, color: Colors.grey),
                  onPressed: () {
                    widget.swapInputs();
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: startAddressPickerBuilder(
                  addressPickerBloc,
                  widget.startController,
                  widget.onStartChanged,
                  isMobile: true,
                ),
              ),
              const SizedBox(width: 50),
            ],
          ),
          smallVerticalSpacer,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addressInputField(
                context,
                controller: widget.endController,
                hintText: lang.to_hint,
                onChanged: (value) {
                  widget.onEndChanged(value, null, null);
                  addressPickerBloc.add(
                    EndAddressInputChanged(value),
                  );
                },
                isMobile: true,
                validator: (value) {
                  return validateInput(context, value);
                },
              ),
            ],
          ),
          endAddressPickerBuilder(
            addressPickerBloc,
            widget.endController,
            widget.onEndChanged,
            isMobile: true,
          ),
          mediumVerticalSpacer,
          V3CustomButton(
            label: lang.calculate,
            width: 220,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                Map<String, String> parameters = {
                  'startAddress': widget.startController.text,
                  'endAddress': widget.endController.text,
                  'selectedMode': widget.selectedMode.name,
                  'isElectric': widget.isElectric.toString(),
                  'isShared': widget.isShared.toString(),
                };
                if (widget.startCoordinates != null) {
                  parameters['startCoordinates'] = widget.startCoordinates!;
                }
                if (widget.endCoordinates != null) {
                  parameters['endCoordinates'] = widget.endCoordinates!;
                }
                context.goNamed(
                  ResultScreenV3.routeName,
                  queryParameters: parameters,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
