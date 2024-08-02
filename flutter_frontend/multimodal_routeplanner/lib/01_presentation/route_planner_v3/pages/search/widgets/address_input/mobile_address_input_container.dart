import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_screen_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/address_input_components.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/text_input_field.dart';
import 'package:multimodal_routeplanner/02_application/bloc/address_picker/address_picker_bloc.dart';
import 'package:multimodal_routeplanner/config/setup_dependencies.dart';

class MobileAddressInputContainer extends StatefulWidget {
  final TextEditingController startController;
  final TextEditingController endController;
  final Function onStartChanged;
  final Function onEndChanged;
  final Function swapInputs;
  final SelectionMode selectedMode;
  final bool isElectric;
  final bool isShared;

  const MobileAddressInputContainer({
    Key? key,
    required this.startController,
    required this.endController,
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

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    } else if (value.length <= 2) {
      return 'Input must be longer than 2 characters';
    }
    return null;
  }

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
                    textInputField(
                      context,
                      controller: widget.startController,
                      hintText: lang.from,
                      onChanged: (value) {
                        widget.onStartChanged(value);
                        addressPickerBloc.add(
                          StartAddressInputChanged(value),
                        );
                      },
                      isMobile: true,
                      validator: validateInput,
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
              textInputField(
                context,
                controller: widget.endController,
                hintText: lang.to,
                onChanged: (value) {
                  widget.onEndChanged(value);
                  addressPickerBloc.add(
                    EndAddressInputChanged(value),
                  );
                },
                isMobile: true,
                validator: validateInput,
              ),
            ],
          ),
          endAddressPickerBuilder(
            addressPickerBloc,
            widget.endController,
            isMobile: true,
          ),
          mediumVerticalSpacer,
          V3CustomButton(
            label: lang.calculate,
            width: 220,
            onTap: () {
              if (_formKey.currentState!.validate()) {
                context.goNamed(
                  ResultScreenV3.routeName,
                  queryParameters: {
                    'startAddress': widget.startController.text,
                    'endAddress': widget.endController.text,
                    'selectedMode': widget.selectedMode.name,
                    'isElectric': widget.isElectric.toString(),
                    'isShared': widget.isShared.toString(),
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
