import 'package:multimodal_routeplanner/03_domain/entities/MobilityMode.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/03_domain/repositories/route_repository.dart';
import 'package:multimodal_routeplanner/04_infrastructure/datasources/route_remote_datasource.dart';

class RouteRepositoryImpl implements RouteRepository {
  final RouteRemoteDatasource routeRemoteDatasource = RouteRemoteDatasourceImpl();

  @override
  Future<Trip> getTripFromApi(
      {required String startInput, required String endInput, required MobilityMode mode, bool? quickResponse}) async {
    final remoteTrip = await routeRemoteDatasource.getSingleRouteFromApi(
      startInput: startInput,
      endInput: endInput,
      mode: mode,
      quickResponse: quickResponse,
    );

    return remoteTrip;
  }
}
