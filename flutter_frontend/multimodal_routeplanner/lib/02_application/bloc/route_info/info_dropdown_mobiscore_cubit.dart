import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'info_dropdown_mobiscore_state.dart';

class InfoDropdownMobiscoreCubit extends Cubit<InfoDropdownMobiscoreState> {
  InfoDropdownMobiscoreCubit() : super(InfoDropdownMobiscoreClosed());

  void openOrCloseDropdown(bool isOpenState) {
    //if dropdown is opened then close
    if (isOpenState == false) {
      emit(InfoDropdownMobiscoreClosed());
    } else {
      emit(InfoDropdownMobiscoreOpened());
    }
  }
}
