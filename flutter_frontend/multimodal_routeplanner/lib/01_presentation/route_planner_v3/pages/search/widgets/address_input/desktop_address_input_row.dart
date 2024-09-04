import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/buttons.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/commons/selection_mode.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_cubit.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_screen_v3.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/address_input_components.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/address_input_field.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/search/widgets/address_input/input_validation.dart';
import 'package:multimodal_routeplanner/02_application/bloc/address_picker/address_picker_bloc.dart';
import 'package:multimodal_routeplanner/config/setup_dependencies.dart';

class DesktopAddressInputRow extends StatefulWidget {
  final ResultCubit cubit;
  final TextEditingController startController;
  final TextEditingController endController;
  final Function onStartChanged;
  final Function onEndChanged;
  final Function swapInputs;
  final SelectionMode selectedMode;
  final bool isElectric;
  final bool isShared;

  const DesktopAddressInputRow({
    Key? key,
    required this.cubit,
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
  State<DesktopAddressInputRow> createState() => _DesktopAddressInputRowState();
}

class _DesktopAddressInputRowState extends State<DesktopAddressInputRow> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    AddressPickerBloc addressPickerBloc = sl<AddressPickerBloc>();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: addressInputField(
                  context,
                  controller: widget.startController,
                  hintText: lang.from_hint,
                  onChanged: (value) {
                    widget.onStartChanged(value);
                    addressPickerBloc.add(
                      StartAddressInputChanged(value),
                    );
                  },
                  isMobile: false,
                  validator: (value) {
                    return validateInput(context, value);
                  },
                ),
              ),
              SizedBox(width: smallPadding),
              IconButton(
                icon: const Icon(Icons.swap_horiz, color: Colors.grey),
                onPressed: () {
                  widget.swapInputs();
                },
              ),
              SizedBox(width: smallPadding),
              Expanded(
                child: addressInputField(
                  context,
                  controller: widget.endController,
                  hintText: lang.to_hint,
                  onChanged: (value) {
                    widget.onEndChanged(value);
                    addressPickerBloc.add(
                      EndAddressInputChanged(value),
                    );
                  },
                  isMobile: false,
                  validator: (value) {
                    return validateInput(context, value);
                  },
                ),
              ),
              smallHorizontalSpacer,
              V3CustomButton(
                label: lang.calculate,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: startAddressPickerBuilder(addressPickerBloc, widget.startController)),
              const SizedBox(width: 45),
              Expanded(child: endAddressPickerBuilder(addressPickerBloc, widget.endController)),
              const SizedBox(
                width: 95,
              )
            ],
          )
        ],
      ),
    );
  }
}
