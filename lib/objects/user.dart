import 'dart:async';
import 'dart:developer';
import 'package:firebase_database/firebase_database.dart';
import 'package:homecareconnect/objects/visit.dart';

enum Genders { male, female, other }

enum BloodTypes { aPositive, aNegative, bPositive, bNegative, abPositive, abNegative, oPositive, oNegative }

Future<User> toObject(uid) async {
  var json;
  late final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('users/$uid').get();
  (snapshot.exists) ? json = (snapshot.value as Map) : log('${snapshot.exists}', name: 'snapshot.exists status');
  var id = uid;
  var name = ((json['FullName'])['Name']).toString();
  var surname = ((json['FullName'])['Surname']).toString();
  var age = json['Age'].toString();
  var gender = json['Gender'].toString();
  var bloodtype = json['Bloodtype'].toString();
  var address = json['Address'].toString();
  var email = ((json['Contact'])['E-mail']).toString();
  var phoneNumber = ((json['Contact'])['PhoneNumber']).toString();
  return User(
    id,
    name: name,
    surname: surname,
    age: DateTime.tryParse(age.trim()),
    gender: gender,
    bloodType: bloodtype,
    address: address,
    email: email,
    phoneNumber: phoneNumber,
  );
}

class User {
  late String id;
  late String? password;
  late String name;
  String? surname;
  DateTime? age;
  dynamic gender;
  dynamic bloodType;
  String? address;
  String? email;
  String? phoneNumber;

  List<Visit>? visits;
  List<String>? allergies;
  List<String>? medicaments;

  User(
    this.id, {
    this.password,
    this.gender,
    this.bloodType,
    required this.name,
    required this.surname,
    this.age,
    this.visits = null,
    this.allergies = null,
    this.medicaments = null,
    this.phoneNumber = null,
    this.email = null,
    this.address = null,
  }) {}

  ///test constructor
  User.testDummy()
      : this(
          'green420life', //id
          name: 'Denaro',
          surname: 'Hoti',
          age: DateTime(2000),
          gender: Genders.male,
          bloodType: BloodTypes.oNegative.index,
          visits: [
            Visit(visitID: '1', clinicID: '1', nurseID: '1', description: 'cls', userID: '1'),
            Visit(visitID: '2', clinicID: '1', nurseID: '1', description: 'gle', userID: '1'),
            Visit(visitID: '3', clinicID: '1', nurseID: '2', description: 'gls', userID: '1'),
          ],
          allergies: ['fëmrat', 'majmunët', 'qumesht'],
          medicaments: ['Ibuprofen', 'Antibiotics', 'Insulin'],
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
      "Medicaments": getMeds(),
    };
  }

  addVisit(Visit v) {
    this.visits?.add(v);
  }

  getAge() {
    var currentYear = (DateTime.now()).toString().replaceRange(4, null, '').trim();
    var year = this.age.toString().replaceRange(4, null, '').trim();
    return int.parse(currentYear) - int.parse(year);
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
        return null;
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
        return null;
    }
  }

  getVisits() {
    if (visits != null) {
      Map json = {};
      for (var i in visits!) {
        final entry = {i.visitID: i.toJson()};
        json.addEntries(entry.entries);
      }
      return json;
    } else {
      return 'null';
    }
  }

  getAllergies() {
    if (allergies != null) {
      Map json = {};
      for (var i in allergies!) {
        final entry = {i: i};
        json.addEntries(entry.entries);
      }
      return json;
    } else {
      return 'null';
    }
  }

  getMeds() {
    Map json = {};
    if (medicaments != null) {
      for (var i in medicaments!) {
        final entry = {i: i};
        json.addEntries(entry.entries);
      }
      return json;
    }
    return 'null';
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
