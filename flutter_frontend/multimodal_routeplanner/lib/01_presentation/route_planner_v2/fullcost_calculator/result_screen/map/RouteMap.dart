import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v1/widgets/map/StartMarker.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v1/widgets/map/StopMarker.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v2/fullcost_calculator/result_screen/map/route_map_helper_methods.dart';
import 'package:multimodal_routeplanner/03_domain/entities/Trip.dart';
import 'package:multimodal_routeplanner/config/munich_geo_values.dart';

class RouteMap extends StatefulWidget {
  const RouteMap({super.key, required this.trip});

  final Trip trip;

  @override
  State<RouteMap> createState() => _RouteMapState();
}

class _RouteMapState extends State<RouteMap> {
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Trip trip = widget.trip;

    LatLngBounds bounds = fitTripBounds(trip);

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        onMapReady: () {
          mapController.fitBounds(
            bounds,
            options: const FitBoundsOptions(padding: EdgeInsets.all(96)),
          );

          // this is a bug fix, because map doesn't focus to max resolution after fitBounds method
          double currentZoom = mapController.zoom;
          mapController.move(bounds.center, currentZoom - 0.01);
        },
        center: munichCenter,
        zoom: 13.0,
      ),
      nonRotatedChildren: [
        RichAttributionWidget(
          animationConfig: const ScaleRAWA(), // Or `FadeRAWA` as is default
          attributions: [
            TextSourceAttribution('OpenStreetMap contributors',
                onTap: () {} // => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                ),
          ],
        ),
      ],
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
        ),
        TappablePolylineLayer(
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
            onMiss: (tapPosition) {}),
        MarkerLayer(
          markers: [
            Marker(
              point: trip.segments.first.waypoints.first.getLatLng(),
              builder: (ctx) => StartMarker(mode: trip.mode),
            ),
            Marker(
              point: trip.segments.last.waypoints.last.getLatLng(),
              builder: (ctx) => const StopMarker(),
            ),
          ],
        ),
      ],
    );
  }
}
