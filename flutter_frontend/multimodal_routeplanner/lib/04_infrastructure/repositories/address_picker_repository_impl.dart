import 'package:multimodal_routeplanner/03_domain/entities/address_picker/Address.dart';
import 'package:multimodal_routeplanner/03_domain/repositories/address_picker_repository.dart';
import 'package:multimodal_routeplanner/04_infrastructure/datasources/photon_address_picker_datasource.dart';

class AddressPickerRepositoryImpl implements AddressPickerRepository {
  final PhotonGeocoderDatasource photonAddressDatasource =
      PhotonGeocoderDatasourceImpl();

  @override
  Future<List<Address>> getAddressFromApi({required String address}) async {
    final remoteListAddresses = await photonAddressDatasource
        .getListAddressesFromApi(inputAddress: address);
    return remoteListAddresses;
  }
}
