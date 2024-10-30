import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multimodal_routeplanner/03_domain/entities/MobilityMode.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/enums/MobilityModeEnum.dart';
import 'package:multimodal_routeplanner/04_infrastructure/datasources/mock_trip_1.dart';
import 'package:multimodal_routeplanner/04_infrastructure/datasources/mock_trip_2.dart';
import 'package:multimodal_routeplanner/04_infrastructure/datasources/mock_trip_3.dart';
import 'package:multimodal_routeplanner/04_infrastructure/datasources/mock_trip_4.dart';
import 'package:multimodal_routeplanner/04_infrastructure/datasources/mock_trip_5.dart';
import 'package:multimodal_routeplanner/04_infrastructure/datasources/mock_trip_6.dart';
import 'package:multimodal_routeplanner/04_infrastructure/datasources/mock_trip_7.dart';
import 'package:multimodal_routeplanner/04_infrastructure/models/trip_model.dart';

/// requests a trip from Route Planner REST-Api
/// throws a server-exception if respond code is not 200
abstract class RouteRemoteDatasource {
  Future<Trip> getSingleRouteFromApi(
      {required String startInput,
      required String endInput,
      String? startCoordinates,
      String? endCoordinates,
      required MobilityMode mode,
      bool? quickResponse});
}

class RouteRemoteDatasourceImpl implements RouteRemoteDatasource {
  final http.Client client = http.Client();

  @override
  Future<Trip> getSingleRouteFromApi(
      {required String startInput,
      required String endInput,
      String? startCoordinates,
      String? endCoordinates,
      required MobilityMode mode,
      bool? quickResponse}) async {
    String modeString = mapMode(mode: mode);
    String quickResponseString = quickResponse != null ? quickResponse.toString() : 'false';

    bool isMocked = false;

    /*// Construct URI for local server
    var uri = Uri.http(
      '127.0.0.1:5000',
      '/platform',
      {
        'inputStartAddress': startInput,
        'inputEndAddress': endInput,
        'tripMode': modeString,
        'quickResponse': quickResponseString,
        if (startCoordinates != null) 'startCoordinates': startCoordinates,
        if (endCoordinates != null) 'endCoordinates': endCoordinates,
      },
    );*/

    // URI for production server
    var uri = Uri.https(
      'sasim.mcube-cluster.de',
      '/platform',
      {
        'inputStartAddress': startInput,
        'inputEndAddress': endInput,
        'tripMode': modeString,
        'quickResponse': quickResponseString,
        if (startCoordinates != null) 'startCoordinates': startCoordinates,
        if (endCoordinates != null) 'endCoordinates': endCoordinates,
      },
    );

    var headers = {"Referrer-Policy": "no-referrer-when-downgrade"};
    Map<String, dynamic> responseBody = {};

    if (isMocked) {
      responseBody = await getSingleRouteMockedResponse(mode: mode);
    } else {
      final response = await client.get(uri, headers: headers);
      responseBody = json.decode(response.body);
    }

    return TripModel.fromJson(responseBody);
  }

  Future<Map<String, dynamic>> getSingleRouteMockedResponse({required MobilityMode mode}) async {
    if (mode.mode == MobilityModeEnum.bike) {
      return mockTrip1;
    } else if (mode.mode == MobilityModeEnum.ebike) {
      return mockTrip2;
    } else if (mode.mode == MobilityModeEnum.cab) {
      return mockTrip3;
    } else if (mode.mode == MobilityModeEnum.car) {
      return mockTrip4;
    } else if (mode.mode == MobilityModeEnum.ecar) {
      return mockTrip5;
    } else if (mode.mode == MobilityModeEnum.sharenow) {
      return mockTrip6;
    } else {
      return mockTrip7;
    }
  }

  String mapMode({required MobilityMode mode}) {
    switch (mode.mode) {
      case MobilityModeEnum.bike:
        return 'BICYCLE';
      case MobilityModeEnum.ebike:
        return 'EBICYCLE';
      case MobilityModeEnum.car:
        return 'CAR';
      case MobilityModeEnum.ecar:
        return 'ECAR';
      case MobilityModeEnum.moped:
        return 'MOPED';
      case MobilityModeEnum.emoped:
        return 'EMOPED';
      case MobilityModeEnum.escooter:
        return 'ESCOOTER';

      case MobilityModeEnum.mvg:
        return 'PT';
      case MobilityModeEnum.intermodal:
        return 'INTERMODAL_PT_BIKE';

      case MobilityModeEnum.emmy:
        return 'EMMY';
      case MobilityModeEnum.tier:
        return 'TIER';
      case MobilityModeEnum.flinkster:
        return 'FLINKSTER';
      case MobilityModeEnum.sharenow:
        return 'SHARENOW';
      case MobilityModeEnum.cab:
        return 'CAB';

      case MobilityModeEnum.walk:
        return 'WALK';
      default:
        return '';
    }
  }
}
