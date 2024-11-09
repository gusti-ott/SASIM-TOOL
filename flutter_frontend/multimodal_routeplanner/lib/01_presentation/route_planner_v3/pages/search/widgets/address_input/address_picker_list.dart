import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/commons/spacers.dart';
import 'package:multimodal_routeplanner/03_domain/entities/address_picker/Address.dart';

class AddressPickerListV3 extends StatelessWidget {
  const AddressPickerListV3(
      {super.key,
      required this.width,
      required this.listAddresses,
      required this.addressInputController,
      required this.onAddressSelectedCallback});

  final double width;
  final List<Address> listAddresses;
  final TextEditingController addressInputController;
  final Function(String, String, String) onAddressSelectedCallback;

  @override
  Widget build(BuildContext context) {
    List<String> listAddressNames = listAddresses.map((e) => e.name).toList();
    listAddressNames = listAddressNames.toSet().toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediumPadding),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: width,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: listAddressNames.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: listAddressNames.length < 3 ? listAddressNames.length : 3,
                    itemBuilder: (BuildContext context, int index) {
                      String name = listAddressNames[index];
                      String lon = listAddresses[index].geometry.coordinates[0].toString();
                      String lat = listAddresses[index].geometry.coordinates[1].toString();

                      if (index + 1 == listAddressNames.length) {
                        return addressItem(context, name: name, addressInputController: addressInputController,
                            onTap: () {
                          onAddressSelectedCallback(name, lat, lon);
                        });
                      } else {
                        return Column(
                          children: [
                            addressItem(
                              context,
                              name: name,
                              addressInputController: addressInputController,
                              onTap: () {
                                onAddressSelectedCallback(name, lat, lon);
                              },
                            ),
                            const Divider()
                          ],
                        );
                      }
                    },
                  )
                : addressNotFoundItem(context)),
      ),
    );
  }
}

Widget addressItem(
  BuildContext context, {
  required String name,
  required VoidCallback onTap,
  required TextEditingController addressInputController,
}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return InkWell(
    onTap: () {
      addressInputController.text = name;
      onTap();
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget addressNotFoundItem(BuildContext context) {
  AppLocalizations lang = AppLocalizations.of(context)!;
  return Padding(
    padding: EdgeInsets.all(smallPadding),
    child: Row(
      children: [
        const Icon(Icons.error_outline_outlined, color: Colors.red),
        smallHorizontalSpacer,
        Expanded(
          child: Text(
            lang.address_not_found_text,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
