import 'package:multimodal_routeplanner/03_domain/entities/address_picker/Address.dart';
import 'package:multimodal_routeplanner/03_domain/repositories/address_picker_repository.dart';
import 'package:multimodal_routeplanner/04_infrastructure/repositories/address_picker_repository_impl.dart';

class AddressPickerUsecases {
  final AddressPickerRepository addressRepository =
      AddressPickerRepositoryImpl();

  Future<List<Address>> getAddress({required String inputAddress}) async {
    return addressRepository.getAddressFromApi(address: inputAddress);
  }
}
