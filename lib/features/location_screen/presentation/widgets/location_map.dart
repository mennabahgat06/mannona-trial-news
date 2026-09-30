import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/utils/app_colors.dart';

/// OpenStreetMap with one pin. Tap anywhere to move the pin.
class LocationMap extends StatelessWidget {
  final MapController controller;
  final LatLng selectedPoint;
  final ValueChanged<LatLng> onPointSelected;

  const LocationMap({
    super.key,
    required this.controller,
    required this.selectedPoint,
    required this.onPointSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        initialCenter: selectedPoint,
        initialZoom: 13,
        onTap: (_, point) => onPointSelected(point),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.mannona.news',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: selectedPoint,
              width: 50,
              height: 50,
              child: const Icon(Icons.location_on,
                  size: 45, color: AppColors.primaryBlue),
            ),
          ],
        ),
      ],
    );
  }
}
