import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/drawer.dart';
import '../components/text_field.dart';


class MedicineTracker extends StatefulWidget {
  const MedicineTracker({Key? key}) : super(key: key);

  @override
  State<MedicineTracker> createState() => _Medicine();
}


class _Medicine extends State<MedicineTracker>{

  final medicineDescriptiom= TextEditingController();
  final medicineTime= TextEditingController();
  _displayDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: _DialogWithTextField(context),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: myDrawer(),
    appBar: getAppBar(
    "Medicine "
    ),
    body: SingleChildScrollView(
    child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: TextButton(
      onPressed: _displayDialog,
      child: const Text('Show Dialog'),
    ),
    ),
    ));
  }

}
Widget _DialogWithTextField(BuildContext context) => Container(
  height: 280,
  decoration: BoxDecoration(
    color:  Colors.white,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  child: Column(
    children: <Widget>[
      SizedBox(height: 24),
      Text(
        "Enter medicine details",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
          child: TextFormField(
            maxLines: 1,
            autofocus: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Enter medicine name",
              labelStyle: TextStyle(color: Colors.black),
              hintStyle: TextStyle(color: Colors.grey[500]),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              fillColor: Colors.white,
              filled: true,
              // filled: true,
            ),
          )
      ),
      Container(
        width: 150.0,
        height: 1.0,
        color: Colors.grey[400],
      ),
      Padding(
          padding: EdgeInsets.only(top: 10, right: 15, left: 15),
          child: TextFormField(
            maxLines: 1,
            autofocus: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Enter medicine description',
              labelStyle: TextStyle(color: Colors.black),
              hintStyle: TextStyle(color: Colors.grey[500]),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              fillColor: Colors.white,
              filled: true,
            ),
          )
      ),
      SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(

            child: Text(
              "Save".toUpperCase(),
              style: TextStyle(
                color: Colors.redAccent,
              ),
            ),
            onPressed: () {
              print('Update the user info');
              // return Navigator.of(context).pop(true);
            },
          )
        ],
      ),
    ],
  ),
);