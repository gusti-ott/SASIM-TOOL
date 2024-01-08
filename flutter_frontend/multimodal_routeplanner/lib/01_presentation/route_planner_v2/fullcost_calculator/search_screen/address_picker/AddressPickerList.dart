import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/search_screen/address_picker/AddressItem.dart';
import 'package:multimodal_routeplanner/03_domain/entities/address_picker/Address.dart';
import 'package:multimodal_routeplanner/03_domain/entities/address_picker/Geometry.dart';

class AddressPickerList extends StatelessWidget {
  const AddressPickerList(
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
    double height = (listAddresses.length >= 5) ? 300 : listAddresses.length * 60;

    return Container(
      color: Colors.white,
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: listAddresses.length,
          itemBuilder: (BuildContext context, int index) {
            String name = "";
            Geometry geometry = Geometry([0.0, 0.0], 'geometry');
            if (listAddresses[index].properties.city != null &&
                listAddresses[index].properties.postcode != null) {
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
            geometry = listAddresses[index].geometry;

            if (index + 1 == listAddresses.length) {
              return AddressItem(
                  name: name,
                  geometry: geometry,
                  addressInputController: addressInputController,
                  onTap: () {
                    onAddressSelectedCallback(name);
                  });
            } else {
              return Column(
                children: [
                  AddressItem(
                    name: name,
                    geometry: geometry,
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
    );
  }
}
