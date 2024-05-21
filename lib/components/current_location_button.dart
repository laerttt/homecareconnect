import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class current_location_button extends StatefulWidget {
  @override
  State<current_location_button> createState() => _currentLocationButtonState();
}

class _currentLocationButtonState extends State<current_location_button> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    packData();
  }

  Future<Position> get_user_location() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {
      log('error USER PERMISSION', stackTrace: stackTrace);
    });
    return await Geolocator.getCurrentPosition();
  }

  packData() {
    get_user_location().then((value) async {
      dynamic lat = value.latitude;
      dynamic lon = value.longitude;

      log('current location\nlat: $lat\nlong: $lon');
      LatLng target = LatLng(lat, lon);
      CameraPosition cameraPosition = CameraPosition(
        target: target,
        zoom: 14,
      );
      log('$cameraPosition');

      GoogleMapController controller = await _controller.future;
      log('$cameraPosition');
      await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      shape: CircleBorder(),
      onPressed: () {
        log('pressed');
        packData();
      },
      child: Icon(Icons.location_on_outlined),
    );
  }
}
