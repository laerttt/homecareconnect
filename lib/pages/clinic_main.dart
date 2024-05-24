import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/app_bar.dart';
import '../components/drawer.dart';
import '../components/text_field.dart';
import '../objects/clinic.dart';
import '../objects/nurse.dart';
import '../objects/user.dart';

class clinic_main extends StatefulWidget {
    clinic_main({Key? key}) : super(key: key);

  @override
  State<clinic_main> createState() => ClinicMain();
}

class ClinicMain extends State<clinic_main> {


  var NurseContainers = <Container>[];
  final List<bool> onDuty=[];



  getAllNurses(Clinic clinic){
      for (int i = 0; i < clinic.employees!.length; i++) {
        print(i);
        print("i");
        Nurse? nurse= clinic.employees?[i];
        NurseContainers.add(nursePage(nurse!,i)) ;


      }
  }

  @override
  Widget build(BuildContext context) {
    print("before");
    final clinic = FirebaseAuth.instance.currentUser!;
    print("after");
    return FutureBuilder(
        future: Clinic.toObject(clinic.uid),
        builder: (BuildContext context, AsyncSnapshot<Clinic> snapshot) {
          if (!snapshot.hasData) return Container(); // still loading
          // alternatively use snapshot.connectionState != ConnectionState.done
          final Clinic? clinic = snapshot.data;
          print('PRINTCHECK');
          print(clinic);

          getAllNurses(clinic!);
          print(clinic);

          return mainClinicScaffold(clinic!, context);
          // return a widget here (you have to return a widget to the builder)
        });
  }

  Scaffold mainClinicScaffold(Clinic clinic,BuildContext context) {
    return Scaffold(
    drawer: myDrawer('clinicmain'),
    appBar: getAppBar(
        "Homepage"
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: clinic.employees!.length,
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
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                children: [Container()],
              ),
            ),
          );
        });
  }

  Container nursePage(Nurse nurse, int index) {
    String? Name = nurse.name;
    // String? ClinicID=nurse.clinicID;
    String? PhoneNumber = nurse.phoneNumber;
    String? Surname = nurse.surname;

    var issueNoteController = TextEditingController();

    return  Container(

      height: 180,
      margin:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      decoration:  BoxDecoration(
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
                  Text(
                      "Is nurse on duty: "+ nurse.onDuty.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis
                  ),
                  const SizedBox(height: 8),

                  IconButton(
                      onPressed:(){
                        if(nurse.onDuty==true){
                         nurse.onDuty= false;
                        }else{
                          nurse.onDuty=true;
                        }
                        print(nurse.onDuty);

                      }

                      , icon:Icon(Icons.check) ),








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
