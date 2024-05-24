import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homecareconnect/objects/clinic.dart';
import 'package:homecareconnect/string_extension.dart';

Future<Set<Marker>> getMarkers(context) async {
  Set<Marker> markers = {};
  late final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('clinics').get();
  if (snapshot.exists) {
    for (var f in snapshot.children) {
      markers.add(Marker(
        markerId: MarkerId(f.key.toString().trim()),
        position: LatLng(double.parse(f.child('Adress').child('lat').value.toString()), double.parse(f.child('Adress').child('lon').value.toString())),
        infoWindow: InfoWindow(title: f.child('Clinic Name').value.toString().trim().capitalize()),
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return FutureBuilder(
                    future: Clinic.toObject(f.key),
                    builder: (BuildContext context, AsyncSnapshot<Clinic> snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                          color: Colors.grey,
                        ); // still loading
                      final Clinic? c = snapshot.data;
                      return SizedBox(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              indent: (MediaQuery.of(context).size.width / 2) - 30,
                              endIndent: (MediaQuery.of(context).size.width / 2) - 30,
                              thickness: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${c?.clinicName.toString().capitalize()}',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                            Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                              child: Text(
                                'E-mail:',
                                style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                            ),
                            for (var i in c!.emails)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                child: Text(
                                  '${i.toString()}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                              child: Text(
                                'Phone Number:',
                                style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                            ),
                            for (var i in c.phoneNumbers)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                child: Text(
                                  '${i.toString()}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                          ],
                        ),
                      );
                      // return a widget here (you have to return a widget to the builder)
                    });
              });
        },
      ));
    }
  } else {
    return {};
  }
  return markers;
}
