import 'dart:developer';
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

Future<Position> get_user_location() async {
  await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {
    log('error USER PERMISSION', stackTrace: stackTrace);
  });
  return await Geolocator.getCurrentPosition();
}

locationData([l = false]) {
  get_user_location().then((value) async {
    dynamic lat = value.latitude;
    dynamic lon = value.longitude;
    if (l) {
      return lat;
    }
    return lon;
  });
}
