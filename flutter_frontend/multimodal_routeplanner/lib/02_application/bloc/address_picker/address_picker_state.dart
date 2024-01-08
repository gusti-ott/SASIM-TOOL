part of 'address_picker_bloc.dart';

@immutable
abstract class AddressPickerState {}

class AddressPickerInitial extends AddressPickerState {}

abstract class RetrievingAddress extends AddressPickerState {}

class RetrievingStartAddress implements RetrievingAddress {}

class RetrievingEndAddress implements RetrievingAddress {}

abstract class AddressRetrieved extends AddressPickerState {
  final List<Address> listAddresses;

  AddressRetrieved(this.listAddresses);
}

class StartAddressRetrieved implements AddressRetrieved {
  @override
  final List<Address> listAddresses;

  StartAddressRetrieved(this.listAddresses);
}

class EndAddressRetrieved implements AddressRetrieved {
  @override
  final List<Address> listAddresses;

  EndAddressRetrieved(this.listAddresses);
}

abstract class AddressPicked extends AddressPickerState {}

class StartAddressPicked implements AddressPicked {}

class EndAddressPicked implements AddressPicked {}

class AddressError extends AddressPickerState {}
