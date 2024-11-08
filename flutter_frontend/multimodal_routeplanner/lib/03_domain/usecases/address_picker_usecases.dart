import 'package:multimodal_routeplanner/03_domain/entities/address_picker/Address.dart';
import 'package:multimodal_routeplanner/03_domain/repositories/address_picker_repository.dart';
import 'package:multimodal_routeplanner/04_infrastructure/repositories/address_picker_repository_impl.dart';

class AddressPickerUsecases {
  final AddressPickerRepository addressRepository = AddressPickerRepositoryImpl();

  Future<List<Address>> getAddress({required String inputAddress}) async {
    List<Address> addressList = await addressRepository.getAddressFromApi(address: inputAddress);

    // only keep elements, where Address.Properties.city at least contains or is "München"
    addressList = addressList
        .where((element) => element.properties.city != null && element.properties.city!.contains('München'))
        .toList();

    return addressList;
  }
}
