import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

getCurrentPosition() async {
  await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {
    log('error USER PERMISSION', stackTrace: stackTrace);
  });
  Geolocator.getCurrentPosition().then(
    (value) => LatLng(value.latitude, value.longitude),
  );
}
