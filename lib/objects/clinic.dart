import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:homecareconnect/objects/nurse.dart';

class Clinic {
  String? clinicID;
  String? clinicName;
  List<Nurse>? employees;
  List<String?>? adress;
  List<String?>? emails;
  List<String?>? phoneNumbers;

  Clinic(
    this.clinicID,
    this.clinicName, {
    this.employees = null,
    this.adress = null,
    this.emails = null,
    this.phoneNumbers = null,
  }) {}
  Clinic.testDummy()
      : this('123', 'klinika gjaku i krishtit',
            adress: ['rruga e jezusit', 'rruga e kaurrav', 'rruga e berxollav'],
            emails: ['gjakukrishtit@gmail.com', 'gjakukrishtit2@gmail.com', 'gjakukrishtit3@gmail.com'],
            phoneNumbers: ['0696969699', '0696969699', '0696969699'],
            employees: [Nurse.testDummy(), Nurse.testDummy(1), Nurse.testDummy(2)]);

  addAdress(String a) {
    adress?.add(a);
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
    Map json = {};
    for (var i in adress!) {
      final entry = {"Adress ${adress?.indexOf(i)}": i};
      json.addEntries(entry.entries);
    }
    return json;
  }

  getPhoneNumbers() {
    Map json = {};
    for (var i in phoneNumbers!) {
      final entry = {"Phone ${phoneNumbers?.indexOf(i)}": i};
      json.addEntries(entry.entries);
    }
    return json;
  }

  getEmails() {
    Map json = {};
    for (var i in emails!) {
      final entry = {"Phone ${emails?.indexOf(i)}": i};
      json.addEntries(entry.entries);
    }
    return json;
  }

  getEmployees() {
    Map json = {};
    for (var i in employees!) {
      final entry = {i.nurseID: i.toJsonClinc()};
      json.addEntries(entry.entries);
    }
    log('$json', name: 'nurse list log');
    return json;
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
