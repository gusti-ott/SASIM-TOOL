import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/flutter_map_helper.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/config/munich_geo_values.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailRouteInfoMap extends StatefulWidget {
  const DetailRouteInfoMap({super.key, required this.trip});

  final Trip? trip;

  @override
  State<DetailRouteInfoMap> createState() => _DetailRouteInfoMapState();
}

class _DetailRouteInfoMapState extends State<DetailRouteInfoMap> {
  final MapController _mapController = MapController();
  LatLngBounds? bounds;

  @override
  Widget build(BuildContext context) {
    if (widget.trip != null) {
      bounds = fitTripBounds(widget.trip!);
    }

    return SizedBox(
      width: double.infinity,
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
            onMapReady: () {
              if (bounds != null) {
                _mapController.fitBounds(
                  bounds!,
                  options: const FitBoundsOptions(padding: EdgeInsets.all(96)),
                );
              }
            },
            center: munichCenter,
            zoom: 13),
        nonRotatedChildren: [
          attributionWidget(),
        ],
        children: [osmTileLayer(), if (widget.trip != null) routePolylineLayer(widget.trip!)],
      ),
    );
  }

  TileLayer osmTileLayer() {
    return TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.app',
    );
  }

  TappablePolylineLayer routePolylineLayer(Trip trip) {
    return TappablePolylineLayer(
        polylineCulling: true,
        polylines: [
          // visualize selected
          for (var i = 0; i < trip.segments.length; i++)
            TaggedPolyline(
              points: trip.segments[i].getWaypointInLagLng(),
              tag: "selected",
              strokeWidth: 5,
              color: mapSegmentModeToColor(trip.segments[i].mode),
            ),
        ],
        onTap: (polylines, tapPosition) => {},
        onMiss: (tapPosition) {});
  }

  RichAttributionWidget attributionWidget() {
    return RichAttributionWidget(
      attributions: [
        TextSourceAttribution(
          'OpenStreetMap contributors',
          onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
        ),
      ],
    );
  }
}
