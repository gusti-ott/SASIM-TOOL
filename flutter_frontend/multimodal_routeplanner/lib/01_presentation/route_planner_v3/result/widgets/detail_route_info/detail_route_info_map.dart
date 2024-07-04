import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:multimodal_routeplanner/01_presentation/route_planner_v3/helpers/flutter_map_helper.dart';
import 'package:multimodal_routeplanner/01_presentation/theme_data/colors_v3.dart';
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
        children: [
          osmTileLayer(),
          if (widget.trip != null) ...[routePolylineLayer(widget.trip!), markerLayer(widget.trip!)],
        ],
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
              strokeWidth: 10,
              color: mapSegmentModeToV3Color(trip.segments[i].mode),
            ),
        ],
        onTap: (polylines, tapPosition) => {},
        onMiss: (tapPosition) {});
  }

  MarkerLayer markerLayer(Trip trip) {
    return MarkerLayer(
      markers: [
        Marker(
          width: 30,
          height: 30,
          point: trip.segments.first.getWaypointInLagLng().first,
          builder: (context) => const Icon(
            Icons.circle,
            color: Colors.black,
          ),
        ),
        Marker(
            width: 50,
            height: 50,
            point: trip.segments.last.getWaypointInLagLng().last,
            builder: (context) => Transform.translate(
                offset: const Offset(0, -30),
                child: iconWithTransparentFilling(Icons.location_on, Icons.location_on_outlined, Colors.black, 50))),
      ],
    );
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

  Widget iconWithTransparentFilling(IconData iconData, IconData iconDataOutlined, Color color, double size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          iconData,
          size: size,
          color: color.withOpacity(0.3), // 50% transparent black
        ),
        Icon(
          iconDataOutlined,
          size: size,
          color: color,
        ),
      ],
    );
  }
}

mapSegmentModeToV3Color(String segmentMode) {
  if (segmentMode == 'WALK') {
    return Colors.grey;
  } else {
    return colorC;
  }
}
