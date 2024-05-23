import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:homecareconnect/objects/nurse.dart';

class Clinic {
  String? clinicID;
  String? clinicName;
  List<Nurse>? employees;
  LatLng adress;
  List<String?>? emails;
  List<String?>? phoneNumbers;
  final int? minOnDuty=10;


  Clinic(
    this.clinicID,
    this.clinicName, {
    this.employees = null,
    this.adress = const LatLng(0, 0),
    this.emails = null,
    this.phoneNumbers = null,
  }) {}
  Clinic.testDummy()
      : this(
          '123',
          'klinika 1',
          adress: LatLng(41.40996208637048, 19.703387726015382),
          emails: ['gjakukrishtit@gmail.com', 'gjakukrishtit2@gmail.com', 'gjakukrishtit3@gmail.com'],
          phoneNumbers: ['0696969699', '0696969699', '0696969699'],
          employees: [Nurse.testDummy(), Nurse.testDummy(1), Nurse.testDummy(2)],
        );
  Clinic.testDummy1()
      : this(
          '123',
          'klinika 2',
          adress: LatLng(41.41231328517085, 19.7231566028525),
          emails: ['gjakukrishtit@gmail.com', 'gjakukrishtit2@gmail.com', 'gjakukrishtit3@gmail.com'],
          phoneNumbers: ['0696969699', '0696969699', '0696969699'],
          employees: [Nurse.testDummy(), Nurse.testDummy(1), Nurse.testDummy(2)],
        );

  addAdress(LatLng a) {
    adress = a;
  }

  addEmployee(Nurse a) {
    employees?.add(a);
  }

  addEmail(String a) {
    emails?.add(a);
  }

  addPhoneNumber(String a) {
    phoneNumbers?.add(a);
  }

  getAdress() {
    if (adress != null) {
      Map json = {};
      final entry = {
        "lat": adress.latitude,
        "lon": adress.longitude,
      };
      json.addEntries(entry.entries);
      return json;
    } else {
      return 'null';
    }
  }

  getPhoneNumbers() {
    if (phoneNumbers != null) {
      Map json = {};
      for (var i in phoneNumbers!) {
        final entry = {"Phone ${phoneNumbers?.indexOf(i)}": i};
        json.addEntries(entry.entries);
      }
      return json;
    } else {
      return 'null';
    }
  }

  getEmails() {
    if (emails != null) {
      Map json = {};
      for (var i in emails!) {
        final entry = {"email ${emails?.indexOf(i)}": i};
        json.addEntries(entry.entries);
      }
      return json;
    } else {
      return 'null';
    }
  }

  getEmployees() {
    if (employees != null) {
      Map json = {};
      for (var i in employees!) {
        final entry = {i.nurseID: i.toJsonClinc()};
        json.addEntries(entry.entries);
      }
      return json;
    } else {
      return 'null';
    }
  }

  ///     arg true => update
  ///     arg false => write (default)
  Future<void> writeClinic({bool update = false}) async {
    DatabaseReference x = FirebaseDatabase.instance.ref('clinics/$clinicID');
    (update) ? await x.update(toJson()) : await x.set(toJson());
  }

  toJson() {
    return {
      "Clinic Name": clinicName,
      "Employees": getEmployees(),
      "Adress": getAdress(),
      "Contact": {
        "Email": getEmails(),
        "Phone": getPhoneNumbers(),
      },
    };
  }
}
