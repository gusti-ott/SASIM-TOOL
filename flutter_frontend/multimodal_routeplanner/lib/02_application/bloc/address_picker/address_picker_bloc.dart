import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multimodal_routeplanner/03_domain/entities/address_picker/Address.dart';
import 'package:multimodal_routeplanner/03_domain/usecases/address_picker_usecases.dart';

part 'address_picker_event.dart';
part 'address_picker_state.dart';

class AddressPickerBloc extends Bloc<AddressPickerEvent, AddressPickerState> {
  final AddressPickerUsecases addressPickerUsecases;
  AddressPickerBloc(this.addressPickerUsecases) : super(AddressPickerInitial()) {
    on<AddressPickerEvent>(
      (event, emit) async {
        if (event is AddressInputChanged) {
          if (event is StartAddressInputChanged) {
            emit(RetrievingStartAddress());
          } else if (event is EndAddressInputChanged) {
            emit(RetrievingEndAddress());
          }

          List<Address> listAddresses = await addressPickerUsecases.getAddress(inputAddress: event.addressInput);

          listAddresses.removeWhere(
              (element) => element.properties.city != 'München' && element.properties.country != 'Deutschland');

          if (event is StartAddressInputChanged) {
            emit(StartAddressRetrieved(listAddresses));
          } else if (event is EndAddressInputChanged) {
            emit(EndAddressRetrieved(listAddresses));
          }
        }

        if (event is PickAddress) {
          if (event is PickStartAddress) {
            emit(StartAddressPicked());
          } else if (event is PickEndAddress) {
            emit(EndAddressPicked());
          }
        }
      },
      transformer: restartable(),
    );
  }
}
