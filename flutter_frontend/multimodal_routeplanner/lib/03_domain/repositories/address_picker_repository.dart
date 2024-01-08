import 'package:multimodal_routeplanner/03_domain/entities/address_picker/Address.dart';

abstract class AddressPickerRepository {
  Future<List<Address>> getAddressFromApi({required String address});
}
