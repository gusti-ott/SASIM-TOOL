import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_map/flutter_map.dart';

/// On web, browsers classify User-Agent as a forbidden header, so any XHR
/// attempt to set it is blocked. flutter_map's default NetworkTileProvider
/// always tries to set it, which causes Safari to reject the tile requests
/// entirely (returning 403 from OSM servers).
///
/// This provider uses Flutter's NetworkImage instead, which delegates tile
/// fetching to the browser's native image loading — no XHR, no User-Agent
/// override, no console error.
class _WebTileProvider extends TileProvider {
  _WebTileProvider();

  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) {
    return NetworkImage(getTileUrl(coordinates, options));
  }
}

/// Returns a correctly configured OSM TileLayer for the current platform.
/// On web: uses [_WebTileProvider] to avoid the forbidden User-Agent header.
/// On native: uses flutter_map's default NetworkTileProvider with a proper
/// User-Agent identifying the app to OSM's servers.
TileLayer osmTileLayer() {
  if (kIsWeb) {
    return TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      tileProvider: _WebTileProvider(),
    );
  }
  return TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'de.mcube-cluster.sasim',
  );
}
