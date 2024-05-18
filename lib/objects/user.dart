import 'dart:async';
// ignore: unused_import
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
  DateTime age;
  dynamic gender;
  dynamic bloodType;
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

  ///test constructor
  User.testDummy()
      : this(
          'green420life', //id
          'green420life', //pass
          name: 'Denaro',
          surname: 'Hoti',
          age: DateTime(2000),
          address: 'Allias ngjit me finemin',
          gender: Genders.male,
          bloodType: BloodTypes.oNegative,
        );

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

  ///     arg true => update
  ///     arg false => write (default)
  Future<void> writeUser({bool update = false}) async {
    DatabaseReference x = FirebaseDatabase.instance.ref('users/$id');
    (update) ? await x.update(toJson()) : await x.set(toJson());
  }

  @override
  String toString() {
    return '$name $surname';
  }
}
