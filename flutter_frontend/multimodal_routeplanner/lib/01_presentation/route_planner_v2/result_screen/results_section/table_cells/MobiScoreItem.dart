import 'package:flutter/material.dart';
import 'package:multimodal_routeplanner/01_presentation/helpers/ModeMapingHelper.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';

class MobiScoreItem extends StatelessWidget {
  const MobiScoreItem({super.key, required this.selectedTrip});

  final Trip selectedTrip;

  @override
  Widget build(BuildContext context) {
    ModeMappingHelper stringMappingHelper = ModeMappingHelper();

    return TableCell(
      child: SizedBox(
        width: 100,
        height: 50,
        child: Image(
          image: stringMappingHelper
              .mapMobiScoreStringToPath(selectedTrip.mobiScore),
        ),
      ),
    );
  }
}
