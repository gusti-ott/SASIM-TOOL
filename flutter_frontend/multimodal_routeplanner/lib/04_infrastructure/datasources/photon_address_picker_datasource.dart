import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:multimodal_routeplanner/03_domain/entities/address_picker/Address.dart';

abstract class PhotonGeocoderDatasource {
  Future<List<Address>> getListAddressesFromApi({required String inputAddress});
}

class PhotonGeocoderDatasourceImpl implements PhotonGeocoderDatasource {
  final http.Client client = http.Client();

  //add coordinates of Munich, to prioritize locations in Munich (Marienplatz) (in request url)
  final String munichLat = 48.1371695.toString();
  final String munichLon = 11.571096.toString();

  @override
  Future<List<Address>> getListAddressesFromApi(
      {required String inputAddress}) async {
    var url =
        'https://photon.komoot.io/api/?q=$inputAddress&lang=de&lat=$munichLat&lon=$munichLon';

    final response = await client.get(Uri.parse(url));
    final responseBody = json.decode(response.body)['features'];

    final List<Address> listAddresses = [];
    responseBody.forEach((element) {
      Address address = Address.fromJson(element);
      listAddresses.add(address);
    });

    return listAddresses;
  }
}
