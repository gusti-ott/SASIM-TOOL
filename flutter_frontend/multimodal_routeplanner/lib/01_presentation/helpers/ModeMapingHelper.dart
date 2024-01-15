import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:multimodal_routeplanner/03_domain/entities/MobilityMode.dart';
import 'package:multimodal_routeplanner/03_domain/enums/MobilityModeEnum.dart';
import 'package:multimodal_routeplanner/logger.dart';

class ModeMappingHelper {
  MobilityModeEnum mapModeStringToMode(String mode) {
    switch (mode) {
      case 'WALK':
        return MobilityModeEnum.walk;

      case 'CAR':
        return MobilityModeEnum.car;

      case 'BICYCLE':
        return MobilityModeEnum.bike;

      case 'MOPED':
        return MobilityModeEnum.moped;

      case 'ECAR':
        return MobilityModeEnum.ecar;

      case 'EBICYCLE':
        return MobilityModeEnum.ebike;

      case 'EMOPED':
        return MobilityModeEnum.emoped;

      case 'CAB':
        return MobilityModeEnum.cab;

      case 'EMMY':
        return MobilityModeEnum.emmy;

      case 'TIER':
        return MobilityModeEnum.tier;

      case 'FLINKSTER':
        return MobilityModeEnum.flinkster;

      case 'SHARENOW':
        return MobilityModeEnum.sharenow;

      case 'PT':
        return MobilityModeEnum.mvg;

      case 'INTERMODAL_PT_BIKE':
        return MobilityModeEnum.intermodal;

      default:
        return MobilityModeEnum.bike;
    }
  }

  String mapModeToStringMode(MobilityMode mode) {
    switch (mode.mode) {
      case MobilityModeEnum.walk:
        return 'WALK';

      case MobilityModeEnum.car:
        return 'CAR';

      case MobilityModeEnum.bike:
        return 'BICYCLE';

      case MobilityModeEnum.moped:
        return 'MOPED';

      case MobilityModeEnum.ecar:
        return 'ECAR';

      case MobilityModeEnum.ebike:
        return 'EBICYCLE';

      case MobilityModeEnum.emoped:
        return 'EMOPED';

      case MobilityModeEnum.cab:
        return 'CAB';

      case MobilityModeEnum.emmy:
        return 'EMMY';

      case MobilityModeEnum.tier:
        return 'TIER';

      case MobilityModeEnum.flinkster:
        return 'FLINKSTER';

      case MobilityModeEnum.sharenow:
        return 'SHARENOW';

      case MobilityModeEnum.mvg:
        return 'PT';

      case MobilityModeEnum.intermodal:
        return 'INTERMODAL_PT_BIKE';

      default:
        return 'BICYCLE';
    }
  }

  mapModeStringToIcon(String mode) {
    switch (mode) {
      case 'WALK':
        return const Icon(Icons.directions_walk);

      case 'CAR':
        return const Icon(Icons.directions_car);

      case 'BICYCLE':
        return const Icon(Icons.directions_bike);

      case 'MOPED':
        return const Icon(Icons.moped);

      case 'ECAR':
        return const Icon(
          Icons.electric_car,
        );

      case 'EBICYCLE':
        return const Icon(
          Icons.electric_bike,
        );

      case 'EMOPED':
        return const Icon(
          Icons.electric_moped,
        );

      case 'CAB':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_cab.png'),
        );

      case 'EMMY':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_emmy.png'),
        );

      case 'TIER':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_tier.jpg'),
        );

      case 'FLINKSTER':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_flinkster.png'),
        );

      case 'SHARENOW':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_sharenow.jpg'),
        );

      case 'PT':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_mvv.png'),
        );

      case 'INTERMODAL_PT_BIKE':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_mvv_plus_bike.png'),
        );

      default:
        return const Icon(
          Icons.electric_car,
        );
    }
  }

  IconData mapModeStringToIconData(String mode) {
    switch (mode) {
      case 'WALK':
        return Icons.directions_walk;

      case 'CAR':
        return Icons.directions_car;

      case 'BICYCLE':
        return Icons.directions_bike;

      case 'MOPED':
        return Icons.moped;

      case 'ECAR':
        return Icons.electric_car;

      case 'EBICYCLE':
        return Icons.electric_bike;

      case 'EMOPED':
        return Icons.electric_moped;

      case 'CAB':
        return Icons.directions_car;

      case 'EMMY':
        return Icons.electric_moped;

      case 'TIER':
        return Icons.directions_car;

      case 'FLINKSTER':
        return Icons.directions_bike;

      case 'SHARENOW':
        return Icons.directions_car;

      case 'PT':
        return Icons.directions_bus;

      case 'INTERMODAL_PT_BIKE':
        return Icons.directions_bus;

      default:
        return Icons.directions_car;
    }
  }

  mapModeStringToBigIcon(String mode) {
    switch (mode) {
      case 'WALK':
        return const Icon(Icons.directions_walk);

      case 'CAR':
        return const Icon(Icons.directions_car);

      case 'BICYCLE':
        return const Icon(Icons.directions_bike);

      case 'MOPED':
        return const Icon(Icons.moped);

      case 'ECAR':
        return const Icon(
          Icons.electric_car,
        );

      case 'EBICYCLE':
        return const Icon(
          Icons.electric_bike,
        );

      case 'EMOPED':
        return const Icon(
          Icons.electric_moped,
        );

      case 'CAB':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_cab.png'),
        );

      case 'EMMY':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_emmy.png'),
        );

      case 'TIER':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_tier.jpg'),
        );

      case 'FLINKSTER':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_flinkster.png'),
        );

      case 'SHARENOW':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_sharenow.jpg'),
        );

      case 'PT':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_mvv.png'),
        );

      case 'INTERMODAL_PT_BIKE':
        return const CircleAvatar(
          backgroundImage: AssetImage('assets/icons/icon_mvv_plus_bike.png'),
        );

      default:
        return const Icon(
          Icons.electric_car,
        );
    }
  }

  String mapModeStringToGermanString(String mode) {
    Logger logger = getLogger();
    switch (mode) {
      case 'WALK':
        return 'zu Fuß';

      case 'CAR':
        return 'Pkw';

      case 'CAR_GASOLINE':
        return 'Pkw';

      case 'BICYCLE':
        return 'Fahrrad';

      case 'MOPED':
        return 'Moped';

      case 'ECAR':
        return 'E-Pkw';

      case 'CAR_BEV':
        return 'E-Pkw';

      case 'EBICYCLE':
        return 'E-Fahrrad';

      case 'EMOPED':
        return 'E-Moped';

      case 'CAB':
        return 'Call a Bike';

      case 'EMMY':
        return 'Emmy';

      case 'TIER':
        return 'Tier';

      case 'FLINKSTER':
        return 'Flinkster';

      case 'SHARENOW':
        return 'Sharenow';

      case 'PT':
        return 'ÖPNV';

      case 'METRO':
        return 'U-Bahn';

      case 'TRAM':
        return 'Tram';

      case 'BUS':
        return 'Bus';

      case 'EBUS':
        return 'E-Bus';

      case 'INTERMODAL_PT_BIKE':
        return 'ÖPNV + Fahrrad';

      default:
        logger.w('mode $mode not found in mapModeStringToGermanString()', 'ModeMappingHelper');
        return 'nicht vorhanden';
    }
  }

  String mapGermanStringToModeString(String germanMode) {
    switch (germanMode) {
      case 'zu Fuß':
        return 'WALK';

      case 'Pkw':
        return 'CAR';

      case 'Fahrrad':
        return 'BICYCLE';

      case 'Moped':
        return 'MOPED';

      case 'E-Pkw':
        return 'ECAR';

      case 'E-Fahrrad':
        return 'EBICYCLE';

      case 'E-Moped':
        return 'EMOPED';

      case 'Call a Bike':
        return 'CAB';

      case 'Emmy':
        return 'EMMY';

      case 'Tier':
        return 'TIER';

      case 'Flinkster':
        return 'FLINKSTER';

      case 'Sharenow':
        return 'SHARENOW';

      case 'ÖPNV':
        return 'PT';

      case 'ÖPNV + Fahrrad':
        return 'INTERMODAL_PT_BIKE';

      default:
        return 'BICYCLE';
    }
  }

  AssetImage mapMobiScoreStringToPath(String mobiScore) {
    switch (mobiScore) {
      case 'A':
        return const AssetImage('assets/mobiscore/mobiscore_a.png');

      case 'B':
        return const AssetImage('assets/mobiscore/mobiscore_b.png');

      case 'C':
        return const AssetImage('assets/mobiscore/mobiscore_c.png');

      case 'D':
        return const AssetImage('assets/mobiscore/mobiscore_d.png');

      case 'E':
        return const AssetImage('assets/mobiscore/mobiscore_e.png');

      default:
        return const AssetImage('assets/mobiscore/mobiscore_e.png');
    }
  }
}
