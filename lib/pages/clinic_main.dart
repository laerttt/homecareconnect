
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/drawer.dart';
import '../components/text_field.dart';
import '../objects/clinic.dart';
import '../objects/nurse.dart';


class clinic_main extends StatefulWidget {
    clinic_main({Key? key}) : super(key: key);
  final List<bool> onDuty=[];

  @override
  State<clinic_main> createState() => ClinicMain();
}

class ClinicMain extends State<clinic_main>{
  void initState() {
    super.initState();
    getAllNurses(clinic);
  }
  var NurseContainers = <Container>[];

  Clinic clinic = Clinic.testDummy();
  getClinic(){

    ///TODO active clinic from database
    //


  }

  getAllNurses(Clinic clinic){
      for (int i = 0; i < clinic.employees!.length; i++) {
        print(i);
        print("i");
        Nurse? nurse= clinic.employees?[i];
        widget.onDuty.add(nurse!.onDuty);
        NurseContainers.add(nursePage(nurse,i)) ;


      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: getAppBar(
          ""
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: NurseContainers.length,
              itemBuilder: (BuildContext conteext, int index) {

                return NurseContainers[index];
              },
            ),
          ),

        ],
      ),
    );
  }


  nurseAnalytics() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: Container(
              height: 360,
              decoration: BoxDecoration(
                color:  Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                children: [
                  Container(

                  )
                ],

              ),


            ),
          );
        });
  }

  Container nursePage(Nurse nurse,int index) {
   String? Name=nurse.name;
   // String? ClinicID=nurse.clinicID;
   String? PhoneNumber=nurse.phoneNumber;
   String? Surname= nurse.surname;

    var issueNoteController = TextEditingController();

    return  Container(
      height: 300,
      margin:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(9.0)),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   "Name: "+ Name!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Surname: "+Surname!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 8),
                  Text(
                      "Phone Number: "+PhoneNumber!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                  ),
                  const SizedBox(height: 8),
                  // Text(
                  //   "Clinic ID: "+ClinicID!,
                  //   style: const TextStyle(fontWeight: FontWeight.bold),
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 8),

                  Switch(
                    // This bool value toggles the switch.
                    value: widget.onDuty[index],
                    activeColor: Colors.redAccent,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        widget.onDuty[index] = value ;
                      });
                    },
                  ),



                  TextButton(
                    onPressed: nurseAnalytics ,
                    child: Text("See nurse analytics",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),) ,

                  ),




                ],
              )),

        ],
      ),
    );
  }


  // Widget _DialogWithTextField(BuildContext context) => Container(
  //   height: 360,
  //   decoration: BoxDecoration(
  //     color:  Colors.white,
  //     shape: BoxShape.rectangle,
  //     borderRadius: BorderRadius.all(Radius.circular(12)),
  //   ),
  //   child: Column(
  //     children: <Widget>[
  //       SizedBox(height: 24),
  //       Text(
  //         "Enter medicine details",
  //         textAlign: TextAlign.center,
  //         style: TextStyle(
  //           color: Colors.redAccent,
  //           fontWeight: FontWeight.bold,
  //           fontSize: 17,
  //         ),
  //       ),
  //       SizedBox(height: 10),
  //       Padding(
  //           padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
  //           child: TextFormField(
  //             controller: medicineName,
  //             maxLines: 1,
  //             autofocus: false,
  //             keyboardType: TextInputType.text,
  //             decoration: InputDecoration(
  //               labelText: "Enter medicine name",
  //               labelStyle: TextStyle(color: Colors.black),
  //               hintStyle: TextStyle(color: Colors.grey[500]),
  //               enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
  //               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
  //               fillColor: Colors.white,
  //               filled: true,
  //               // filled: true,
  //             ),
  //           )
  //       ),
  //
  //       Container(
  //         width: 150.0,
  //         height: 1.0,
  //         color: Colors.grey[400],
  //       ),
  //       Padding(
  //           padding: EdgeInsets.only(top: 10, right: 15, left: 15),
  //           child: TextFormField(
  //             controller: medicineDescriptiom,
  //             maxLines: 1,
  //             autofocus: false,
  //             keyboardType: TextInputType.text,
  //             decoration: InputDecoration(
  //               labelText: 'Enter medicine description',
  //               labelStyle: TextStyle(color: Colors.black),
  //               hintStyle: TextStyle(color: Colors.grey[500]),
  //               enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200)),
  //               focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
  //               fillColor: Colors.white,
  //               filled: true,
  //             ),
  //           )
  //       ),
  //       SizedBox(height: 10),
  //       IconButton(
  //         icon: Icon(Icons.date_range_rounded),
  //         onPressed: () => _selectTime(context),
  //       ),
  //       SizedBox(height: 10),
  //
  //       Row(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(
  //               "Cancel",
  //               style: TextStyle(
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ),
  //           SizedBox(width: 8),
  //           ElevatedButton(
  //
  //             child: Text(
  //               "Save".toUpperCase(),
  //               style: TextStyle(
  //                 color: Colors.redAccent,
  //               ),
  //             ),
  //             onPressed: () {
  //               /// TODO add method to save medicaments
  //               setState(() => NurseContainers.add(nursePage()));
  //               Navigator.of(context).pop();
  //
  //               // return Navigator.of(context).pop(true);
  //             },
  //           )
  //         ],
  //       ),
  //     ],
  //   ),
  // );

}

