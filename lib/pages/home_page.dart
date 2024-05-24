// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:homecareconnect/components/markers.dart';
import 'package:homecareconnect/dark_map_style.dart';
import 'dart:developer';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/drawer.dart';
import 'package:homecareconnect/poly.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});
  @override
  State<HomeWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    super.initState();
    packData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMarkers(context),
        builder: (BuildContext context, AsyncSnapshot<Set<Marker>> snapshot) {
          if (!snapshot.hasData)
            return Container(
              color: Colors.grey,
            ); // still loading
          // alternatively use snapshot.connectionState != ConnectionState.done
          final Set<Marker>? markers = snapshot.data;
          return mapScaffold(context, markers);
          // return a widget here (you have to return a widget to the builder)
        });
  }

  Scaffold mapScaffold(BuildContext context, markers) {
    return Scaffold(
      appBar: getAppBar('Map'),
      drawer: myDrawer('map'),
      body: Container(
        height: MediaQuery.of(context).size.height + 100,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: GoogleMap(
          polylines: Set<Polyline>.of(polylines.values),
          markers: markers,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          style: darkMapStyle.pussJson(),
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 16.0,
          ),
          myLocationButtonEnabled: false,
          // padding: const EdgeInsets.only(bottom: 5, left: 10),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        onPressed: () {
          packData();
        },
        child: Icon(Icons.location_on_outlined),
      ),
    );
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
      LatLng target = LatLng(lat, lon);
      CameraPosition cameraPosition = CameraPosition(
        target: target,
        zoom: 18,
      );

      GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
      return target;
    });
  }
}
