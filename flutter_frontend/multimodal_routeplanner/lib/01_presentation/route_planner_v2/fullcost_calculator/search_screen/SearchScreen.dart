import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multimodal_routeplanner/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/headers.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/ResultScreen.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/search_screen/address_picker/AddressPickerList.dart';
import 'package:multimodal_routeplanner/02_application/bloc/address_picker/address_picker_bloc.dart';
import 'package:multimodal_routeplanner/config/setup_dependencies.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const String routeName = 'search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _focusNodeEndLocation = FocusNode();
  final TextEditingController _controllerStartLocation = TextEditingController();
  final TextEditingController _controllerEndLocation = TextEditingController();

  bool _startInputValid = true;
  bool _endInputValid = true;

  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;

    const double searchAreaWidth = 800;
    const double textInputWidth = (searchAreaWidth - 100) / 2;

    AddressPickerBloc addressPickerBloc = sl<AddressPickerBloc>();

    return Column(
      children: [
        Center(
          child: Column(
            children: [
              TitleImage(
                  imagePath: 'assets/title_image/titelbild_ubahn.png', titleText: lang.that_are_the_true_costs_header),
              const SizedBox(height: 96),
              SizedBox(
                  width: searchAreaWidth,
                  child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<AddressPickerBloc, AddressPickerState>(
                          bloc: addressPickerBloc,
                          builder: (context, state) {
                            return Column(
                              children: [
                                addressInputField(
                                  textInputWidth,
                                  lang.start_address,
                                  _controllerStartLocation,
                                  (value) {
                                    addressPickerBloc.add(StartAddressInputChanged(value));
                                  },
                                  _startInputValid,
                                ),
                                if (state is RetrievingStartAddress)
                                  const SizedBox(
                                      width: textInputWidth,
                                      child: LinearProgressIndicator(
                                        color: Colors.white,
                                      )),
                                if (state is StartAddressRetrieved)
                                  AddressPickerList(
                                      width: textInputWidth,
                                      listAddresses: state.listAddresses,
                                      addressInputController: _controllerStartLocation,
                                      onAddressSelectedCallback: (address) {
                                        addressPickerBloc.add(PickStartAddress(address));
                                      }),
                              ],
                            );
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.double_arrow,
                              color: Colors.white,
                              size: 48,
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            searchButton(context),
                          ],
                        ),
                        BlocBuilder<AddressPickerBloc, AddressPickerState>(
                          bloc: addressPickerBloc,
                          builder: (context, state) {
                            return Column(
                              children: [
                                addressInputField(
                                  textInputWidth,
                                  lang.end_address,
                                  _controllerEndLocation,
                                  (value) {
                                    BlocProvider.of<AddressPickerBloc>(context).add(EndAddressInputChanged(value));
                                  },
                                  _endInputValid,
                                ),
                                if (state is RetrievingEndAddress)
                                  const SizedBox(
                                      width: textInputWidth,
                                      child: LinearProgressIndicator(
                                        color: Colors.white,
                                      )),
                                if (state is EndAddressRetrieved)
                                  AddressPickerList(
                                      width: textInputWidth,
                                      listAddresses: state.listAddresses,
                                      addressInputController: _controllerEndLocation,
                                      onAddressSelectedCallback: (address) {
                                        BlocProvider.of<AddressPickerBloc>(context).add(PickEndAddress(address));
                                      }),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  InkWell searchButton(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _startInputValid = _controllerStartLocation.text.isNotEmpty;
        });

        setState(() {
          _endInputValid = _controllerEndLocation.text.isNotEmpty;
        });

        if (_startInputValid && _endInputValid) {
          context.goNamed(
            ResultScreen.routeName,
            queryParameters: {
              'startInput': _controllerStartLocation.text,
              'endInput': _controllerEndLocation.text,
            },
          );
        }
      },
      child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          child: Center(
            child: Text(
              'GO!',
              style: TextStyle(color: Theme.of(context).colorScheme.onSecondary, fontSize: 24),
            ),
          )),
    );
  }

  Widget emptyAddressPicker(double width) {
    return Container(
      width: width,
      height: 0,
      decoration: const BoxDecoration(color: Colors.white),
    );
  }

  Widget addressInputField(
    double width,
    String labelText,
    TextEditingController textEditingController,
    Function(String) onChangedCallback,
    bool isValid,
  ) {
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
          labelStyle: const TextStyle(color: Colors.black),
          error: isValid ? null : errorWidget(context),
          // errorText: isValide ? null : 'Bitte gib eine $labelText an',
        ),
        onChanged: (value) {
          onChangedCallback(value);
        },
        onEditingComplete: () => _focusNodeEndLocation.requestFocus(),
      ),
    );
  }
}

Widget errorWidget(BuildContext context) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  return Container(
    color: Colors.red,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(lang.please_insert_address),
    ),
  );
}
