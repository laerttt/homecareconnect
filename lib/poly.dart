// Object for PolylinePoints
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

late PolylinePoints polylinePoints;

// List of coordinates to join
List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
Map<PolylineId, Polyline> polylines = {};

// Create the polylines for showing the route between two places

createPolylines(
  double startLatitude,
  double startLongitude,
  double destinationLatitude,
  double destinationLongitude,
) async {
  // Initializing PolylinePoints
  polylinePoints = PolylinePoints();

  // Generating the list of coordinates to be used for
  // drawing the polylines
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    'AIzaSyDf0ucw8-zcvDKXm-k9B2jntdrcYv4Kv4M',
    PointLatLng(startLatitude, startLongitude),
    PointLatLng(destinationLatitude, destinationLongitude),
    travelMode: TravelMode.driving,
  );

  // Adding the coordinates to the list
  if (result.points.isNotEmpty) {
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
  }

  // Defining an ID
  PolylineId id = PolylineId('poly');

  // Initializing Polyline
  Polyline polyline = Polyline(
    polylineId: id,
    color: Colors.red,
    points: polylineCoordinates,
    width: 3,
  );

  // Adding the polyline to the map
  polylines[id] = polyline;
}
