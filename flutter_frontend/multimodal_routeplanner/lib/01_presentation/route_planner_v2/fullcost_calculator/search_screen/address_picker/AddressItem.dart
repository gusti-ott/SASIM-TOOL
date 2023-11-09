import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/03_domain/entities/address_picker/Geometry.dart';

class AddressItem extends StatelessWidget {
  final String name;
  final Geometry geometry;
  final VoidCallback onTap;
  final TextEditingController addressInputController;

  const AddressItem({
    Key? key,
    required this.name,
    required this.geometry,
    required this.onTap,
    required this.addressInputController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Text(
            '${geometry.coordinates[0].toString()}, ${geometry.coordinates[1].toString()}',
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
