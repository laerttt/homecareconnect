import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homecareconnect/dark_map_style.dart';

class google_maps_widget extends StatefulWidget {
  const google_maps_widget({super.key});

  @override
  State<google_maps_widget> createState() => google_maps_widgetState();
}

class google_maps_widgetState extends State<google_maps_widget> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      style: darkMapStyle.pussJson(),
      initialCameraPosition: const CameraPosition(
        target: LatLng(-33.86, 151.20),
        zoom: 16.0,
      ),
      myLocationButtonEnabled: false,
      markers: {
        const Marker(
          markerId: MarkerId('Marker'),
          position: LatLng(-33.86, 151.20),
        )
      },
      padding: const EdgeInsets.only(bottom: 5, left: 10),
    );
  }
}
