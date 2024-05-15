import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class my_bottom_navitagion_bar extends StatefulWidget {
  const my_bottom_navitagion_bar({super.key});

  @override
  State<my_bottom_navitagion_bar> createState() => _my_bottom_navitagion_barState();
}

class _my_bottom_navitagion_barState extends State<my_bottom_navitagion_bar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.red,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Map'),
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'M'),
      ],
    );
  }
}
