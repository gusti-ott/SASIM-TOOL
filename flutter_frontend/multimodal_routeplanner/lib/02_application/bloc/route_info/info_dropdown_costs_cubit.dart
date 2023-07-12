import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'info_dropdown_costs_state.dart';

class InfoDropdownCostsCubit extends Cubit<InfoDropdownCostsState> {
  InfoDropdownCostsCubit() : super(InfoDropdownCostsClosed());

  void openOrCloseDropdown(bool isOpenState) {
    //if dropdown is opened then close
    if (isOpenState == false) {
      emit(InfoDropdownCostsClosed());
    } else {
      emit(InfoDropdownCostsOpened());
    }
  }
}
