import 'package:get_it/get_it.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/pages/result/result_cubit.dart';
import 'package:multimodal_routeplanner/02_application/bloc/address_picker/address_picker_bloc.dart';
import 'package:multimodal_routeplanner/03_domain/usecases/address_picker_usecases.dart';
import 'package:multimodal_routeplanner/03_domain/usecases/route_usecases.dart';

GetIt sl = GetIt.instance;

void setupDependencies() {
  // singleton services
  sl.registerLazySingleton<RoutePlannerUsecases>(() => RoutePlannerUsecases());
  sl.registerLazySingleton<AddressPickerUsecases>(() => AddressPickerUsecases());

  // singleton cubits
  sl.registerLazySingleton<ResultCubit>(() => ResultCubit(sl()));

  // non factory cubits
  sl.registerLazySingleton<AddressPickerBloc>(() => AddressPickerBloc(sl()));
}
