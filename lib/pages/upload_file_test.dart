import 'package:flutter/material.dart';
import 'package:homecareconnect/components/app_bar.dart';
import 'package:homecareconnect/components/drawer.dart';

class myTestFilePicker extends StatefulWidget {
  const myTestFilePicker({super.key});

  @override
  State<myTestFilePicker> createState() => _myTestFilePickerState();
}

class _myTestFilePickerState extends State<myTestFilePicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar('test'),
      drawer: myDrawer(),
    );
  }
}
