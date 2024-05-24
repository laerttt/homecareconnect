import 'dart:math';

import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/drawer.dart';

class MedicineTracker extends StatefulWidget {
  const MedicineTracker({Key? key}) : super(key: key);

  @override
  State<MedicineTracker> createState() => _Medicine();
}

class Medicine {
  String medicineName;
  String medicineDescription;
  TimeOfDay medicineTime;

  Medicine(this.medicineName, this.medicineDescription, this.medicineTime);
}

class _Medicine extends State<MedicineTracker> {
  var containers = <Container>[];
  String? Time;
  final medicineDescriptiom = TextEditingController();
  final medicineName = TextEditingController();
  final medicineTime = TextEditingController();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) Time = picked.hour.toString() + ':' + picked.minute.toString();
  }

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
      drawer: myDrawer('medicine'),
      appBar: getAppBar("Medicine Tracker"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: containers.length,
              itemBuilder: (BuildContext context, int index) {
                return containers[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: _displayDialog,
            ),
          )
        ],
      ),
    );
  }

  Container issue() {
    return Container(
      height: 136,
      margin:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      decoration:BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                medicineName.text,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 1),
              Text(
                medicineDescriptiom.text,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                Time!,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _DialogWithTextField(BuildContext context) => Container(
        height: 360,
        decoration: BoxDecoration(
          color: Colors.white,
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
                  controller: medicineName,
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
                )),
            Container(
              width: 150.0,
              height: 1.0,
              color: Colors.grey[400],
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                child: TextFormField(
                  controller: medicineDescriptiom,
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
                )),
            SizedBox(height: 10),
            IconButton(
              icon: Icon(Icons.date_range_rounded),
              onPressed: () => _selectTime(context),
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
                    /// TODO add method to save medicaments
                    setState(() => containers.add(issue()));
                    Navigator.of(context).pop();

                    // return Navigator.of(context).pop(true);
                  },
                )
              ],
            ),
          ],
        ),
      );
}
