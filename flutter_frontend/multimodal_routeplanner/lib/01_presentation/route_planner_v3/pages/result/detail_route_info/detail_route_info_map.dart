import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:latlong2/latlong.dart';
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

class _DetailRouteInfoMapState extends State<DetailRouteInfoMap> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  LatLngBounds? bounds;
  bool isFirstRoute = true; // Flag to check if it's the first route
  AnimationController? _animationController;
  Animation<LatLng>? _latLngAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DetailRouteInfoMap oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Trigger animation to new route bounds when route changes
    if (widget.trip != oldWidget.trip && widget.trip != null) {
      bounds = fitTripBounds(widget.trip!);
      animateMapToBounds(bounds!);
    }
  }

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
              // Initial animation when the map is first ready
              if (isFirstRoute && widget.trip != null) {
                isFirstRoute = false;
                // _mapController. = const LatLng(48.1662627, 11.5768211); // Start position
                // After initial animation, animate to route bounds
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (bounds != null) {
                    animateMapToBounds(bounds!);
                  }
                });
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

  void animateMapToLatLng(LatLng targetLatLng) {
    LatLng currentCenter = _mapController.center;

    // Define the tween with CurvedAnimation for a bouncy effect
    _latLngAnimation = LatLngTween(begin: currentCenter, end: targetLatLng).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOut, // Smooth easing out towards the end
      ),
    );

    _animationController?.addListener(() {
      _mapController.move(_latLngAnimation!.value, _mapController.zoom);
    });

    _animationController?.forward(from: 0.0);
  }

  // Function to animate the map to the bounds of the route without changing the zoom
  void animateMapToBounds(LatLngBounds bounds) {
    LatLng targetCenter = bounds.center;

    animateMapToLatLng(targetCenter); // Animate to the center of the bounds
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
        onTap: (polyline, tapPosition) => {},
        onMiss: (tapPosition) {});
  }

  MarkerLayer markerLayer(Trip trip) {
    return MarkerLayer(
      markers: [
        Marker(
          width: 30,
          height: 30,
          point: trip.segments.first.getWaypointInLagLng().first,
          builder: (context) => startIcon(),
        ),
        Marker(
            width: 50,
            height: 50,
            point: trip.segments.last.getWaypointInLagLng().last,
            builder: (context) => Transform.translate(offset: const Offset(0, -30), child: endIcon(size: 50))),
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
}

mapSegmentModeToV3Color(String segmentMode) {
  if (segmentMode == 'WALK') {
    return Colors.lightBlue;
  } else {
    return colorC;
  }
}

Widget startIcon() {
  return const Icon(
    Icons.circle,
    color: Colors.black,
  );
}

Widget endIcon({double? size}) {
  return iconWithTransparentFilling(Icons.location_on, Icons.location_on_outlined, Colors.black, size);
}

Widget iconWithTransparentFilling(IconData iconData, IconData iconDataOutlined, Color color, double? size) {
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

class LatLngTween extends Tween<LatLng> {
  LatLngTween({LatLng? begin, LatLng? end}) : super(begin: begin, end: end);

  @override
  LatLng lerp(double t) => LatLng(
        begin!.latitude + (end!.latitude - begin!.latitude) * t,
        begin!.longitude + (end!.longitude - begin!.longitude) * t,
      );
}
