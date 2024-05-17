import 'dart:async';
import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:homecareconnect/objects/visit.dart';

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
  dynamic gender;
  int? bloodType;
  String? address;
  String? email;
  String? phoneNumber;
  List<Visit>? visits;
  List<String>? allergies;

  User(
    this.id,
    this.password, {
    this.gender,
    this.bloodType,
    required this.name,
    required this.surname,
    required this.age,
    required this.address,
    this.visits = null,
    this.allergies = null,
  }) {}

  ///test constructor
  User.testDummy()
      : this(
          'green420life', //id
          'green420life', //pass
          name: 'Denaro',
          surname: 'Hoti',
          age: 1,
          address: 'Allias ngjit me finemin',
          gender: Genders.male,
          bloodType: BloodTypes.oNegative.index,
          visits: [
            Visit(
              visitID: '1',
              clinicID: '1',
              nurseID: '1',
              description: 'cls',
              userID: '1',
            ),
            Visit(
              visitID: '2',
              clinicID: '1',
              nurseID: '1',
              description: 'gle',
              userID: '1',
            ),
            Visit(
              visitID: '3',
              clinicID: '1',
              nurseID: '2',
              description: 'gls',
              userID: '1',
            ),
          ],
          allergies: [
            'fëmrat',
            'majmunët',
            'qumesht',
          ],
        );

  ///db json struct
  toJson() {
    return {
      "FullName": {
        "Name": name,
        "Surname": surname,
      },
      "Age": "$age",
      "Gender": getGender(),
      "Bloodtype": getBloodType(),
      "Addresss": address,
      "Contact": {
        "E-mail": email,
        "PhoneNumber": phoneNumber,
      },
      "Visits": getVisits(),
      "Allergies": getAllergies(),
    };
  }

  addVisit(Visit v) {
    this.visits?.add(v);
  }

  getGender() {
    switch (this.gender) {
      case Genders.male:
        return 'male';
      case Genders.female:
        return 'female';
      case Genders.other:
        return 'other';
      default:
        return 'not specified';
    }
  }

  getBloodType() {
    switch (this.bloodType) {
      case 0:
        return 'aPositive';
      case 1:
        return 'aNegative';
      case 2:
        return 'bPositive';
      case 3:
        return 'bNegative';
      case 4:
        return 'abPositive';
      case 5:
        return 'abNegative';
      case 6:
        return 'oPositive';
      case 7:
        return 'oNegative';
      default:
        return 'not specified';
    }
  }

  getVisits() {
    Map json = {};
    for (var i in visits!) {
      final entry = {i.visitID: i.toJson()};
      json.addEntries(entry.entries);
    }
    log('$json', name: 'visit list log');
    return json;
  }

  getAllergies() {
    Map json = {};
    for (var i in allergies!) {
      final entry = {i: i};
      json.addEntries(entry.entries);
    }
    log('$json', name: 'allergies list log');
    return json;
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
