import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/McubeLogo.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/search_screen/address_picker/AddressPickerList.dart';
import 'package:multimodal_routeplanner/02_application/bloc/address_picker/address_picker_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodeEndLocation = FocusNode();
  final TextEditingController _controllerStartLocation =
      TextEditingController();
  final TextEditingController _controllerEndLocation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const double searchAreaWidth = 800;
    const double textInputWidth = (searchAreaWidth - 100) / 2;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        children: [
          Row(
            children: [
              const Expanded(child: SizedBox(height: 96)),
              mcubeLogo(),
            ],
          ),
          Form(
            key: _formKey,
            child: Center(
              child: SizedBox(
                width: searchAreaWidth,
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage('assets/logos/mobiscore_logo.png'),
                    ),
                    const SizedBox(height: 96),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        addressInputField(
                          textInputWidth,
                          'Startadresse',
                          _controllerStartLocation,
                          (value) {
                            BlocProvider.of<AddressPickerBloc>(context)
                                .add(StartAddressInputChanged(value));
                          },
                        ),
                        const Icon(
                          Icons.double_arrow,
                          color: Colors.white,
                          size: 48,
                        ),
                        addressInputField(
                          textInputWidth,
                          'Zieladresse',
                          _controllerEndLocation,
                          (value) {
                            BlocProvider.of<AddressPickerBloc>(context)
                                .add(EndAddressInputChanged(value));
                          },
                        ),
                      ],
                    ),
                    BlocBuilder<AddressPickerBloc, AddressPickerState>(
                      builder: (context, state) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (state is StartAddressRetrieved)
                              AddressPickerList(
                                  width: textInputWidth,
                                  listAddresses: state.listAddresses,
                                  addressInputController:
                                      _controllerStartLocation,
                                  onAddressSelectedCallback: (address) {
                                    BlocProvider.of<AddressPickerBloc>(context)
                                        .add(PickStartAddress(address));
                                  }),
                            if (state is! StartAddressRetrieved)
                              emptyAddressPicker(textInputWidth),
                            Column(
                              children: [
                                const SizedBox(height: 64),
                                InkWell(
                                  onTap: () {
                                    context.goNamed(
                                      'result-screen',
                                      queryParameters: {
                                        'startInput':
                                            _controllerStartLocation.text,
                                        'endInput': _controllerEndLocation.text,
                                      },
                                    );
                                  },
                                  child: Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      child: Center(
                                        child: Text(
                                          'GO!',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              fontSize: 24),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            if (state is EndAddressRetrieved)
                              AddressPickerList(
                                  width: textInputWidth,
                                  listAddresses: state.listAddresses,
                                  addressInputController:
                                      _controllerEndLocation,
                                  onAddressSelectedCallback: (address) {
                                    BlocProvider.of<AddressPickerBloc>(context)
                                        .add(PickEndAddress(address));
                                  }),
                            if (state is! EndAddressRetrieved)
                              emptyAddressPicker(textInputWidth),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emptyAddressPicker(double width) {
    return Container(
      width: width,
      decoration: const BoxDecoration(color: Colors.white),
    );
  }

  Widget addressInputField(
      double width,
      String labelText,
      TextEditingController textEditingController,
      Function(String) onChangedCallback) {
    return SizedBox(
      width: width,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.streetAddress,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            label: Align(
              alignment: Alignment.centerLeft,
              child: Text(labelText),
            ),
            labelStyle: const TextStyle(color: Colors.black)),
        onChanged: (value) {
          onChangedCallback(value);
          /*if (addressType == AddressType.startAddress) {
            BlocProvider.of<AddressPickerBloc>(context)
                .add(StartAddressInputChanged(value));
          }
          if (addressType == AddressType.endAddress) {
            BlocProvider.of<AddressPickerBloc>(context)
                .add(EndAddressInputChanged(value));
          }*/
        },
        onEditingComplete: () => _focusNodeEndLocation.requestFocus(),
        validator: (String? value) {
          //TODO: fix validation
          if (value == null || value.isEmpty) {
            return "Bitte gib eine $labelText an";
          }
          return null;
        },
      ),
    );
  }
}
