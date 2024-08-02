import 'package:flutter/material.dart';
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
  final Function(String) onAddressSelectedCallback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediumPadding),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: listAddresses.length < 3 ? listAddresses.length : 3,
            itemBuilder: (BuildContext context, int index) {
              String name = "";
              // Geometry geometry = Geometry([0.0, 0.0], 'geometry');
              if (listAddresses[index].properties.city != null && listAddresses[index].properties.postcode != null) {
                if (listAddresses[index].properties.name != null) {
                  name =
                      '${listAddresses[index].properties.name}, ${listAddresses[index].properties.postcode.toString()} ${listAddresses[index].properties.city}';
                } else if (listAddresses[index].properties.street != null &&
                    listAddresses[index].properties.housenumber != null) {
                  name =
                      '${listAddresses[index].properties.street} ${listAddresses[index].properties.housenumber.toString()}, ${listAddresses[index].properties.postcode.toString()} ${listAddresses[index].properties.city}';
                }
              } else {
                name = 'kein Name gefunden';
              }
              // geometry = listAddresses[index].geometry;

              if (index + 1 == listAddresses.length) {
                return addressItem(
                    name: name,
                    addressInputController: addressInputController,
                    onTap: () {
                      onAddressSelectedCallback(name);
                    });
              } else {
                return Column(
                  children: [
                    addressItem(
                      name: name,
                      addressInputController: addressInputController,
                      onTap: () {
                        onAddressSelectedCallback(name);
                      },
                    ),
                    const Divider()
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget addressItem({
  required String name,
  required VoidCallback onTap,
  required TextEditingController addressInputController,
}) {
  return InkWell(
    onTap: () {
      addressInputController.text = name;
      onTap();
    },
    child: Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
