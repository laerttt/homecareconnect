// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/bottom_navigation_bar.dart';
import 'package:homecareconnect/components/current_location_button.dart';
import 'package:homecareconnect/components/drawer.dart';
import 'package:homecareconnect/objects/google_map.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});
  @override
  State<HomeWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar('Map'),
      drawer: myDrawer(),
      bottomNavigationBar: my_bottom_navitagion_bar(),
      body: Container(
        height: MediaQuery.of(context).size.height + 100,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: google_maps_widget(),
      ),
      floatingActionButton: current_location_button(),
    );
  }
}
