import 'package:firebase_database/firebase_database.dart';

class Visit {
  String? visitID;
  String? userID;
  String? nurseID;
  String? clinicID;
  String? description;
  int? billable;

  Visit({
    required this.visitID,
    required this.clinicID,
    required this.nurseID,
    required this.description,
    required this.userID,
  });

  toJson() {
    return {
      "Clinic ID": clinicID,
      "Nurse ID": nurseID,
      "User ID": userID,
      "Description": description,
    };
  }

  wrtieDB({bool update = false}) async {
    DatabaseReference x = FirebaseDatabase.instance.ref('visits/$visitID');
    (update) ? await x.update(toJson()) : await x.set(toJson());
  }
}
