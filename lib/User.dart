import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';

enum Genders { male, female, other }

enum BloodTypes {
  aPositive,
  aNegative,
  bPositive,
  bNegative,
  abPositive,
  abNegative,
  oPositive,
  oNegative,
}

class User {
  late String id;
  late String password;

  late String name;
  String? surname;
  int? age;
  int? gender;
  int? bloodType;
  String? address;

  User(this.id, this.password,
      {gender,
      bloodType,
      required this.name,
      required this.surname,
      required this.age,
      required this.address}) {
    gender = gender;
    bloodType = bloodType;
  }

  ///db json struct
  toJson() {
    return {
      "Name": name,
      "Surname": surname,
      "Addresss": address,
      "Gender": "$gender",
      "Bloodtype": "$bloodType",
      "Age": "$age",
      "password": password,
    };
  }

  ///write to db
  Future<void> writeUser() async {
    log('ref...');
    DatabaseReference x = FirebaseDatabase.instance.ref('users/$id');
    log('writing...');
    await x.set(toJson());
  }

  @override
  String toString() {
    return '$name $surname';
  }
}
