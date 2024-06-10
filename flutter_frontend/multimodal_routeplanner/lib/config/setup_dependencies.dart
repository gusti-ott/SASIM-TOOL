import 'package:get_it/get_it.dart';
import 'package:multimodal_routeplanner/03_domain/usecases/route_usecases.dart';

import '../01_presentation/route_planner_v3/search/search_cubit.dart';

GetIt sl = GetIt.instance;

void setupDependencies() {
  // singleton services
  sl.registerLazySingleton<RoutePlannerUsecases>(() => RoutePlannerUsecases());

  // singleton cubits
  sl.registerLazySingleton<SearchCubit>(() => SearchCubit(sl()));
}
