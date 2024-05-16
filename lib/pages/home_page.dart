// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:homecareconnect/dark_map_style.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/drawer.dart';

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
    return Scaffold(
      appBar: getAppBar('Map'),
      drawer: myDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height + 100,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: GoogleMap(
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
        zoom: 16,
      );

      GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }
}
