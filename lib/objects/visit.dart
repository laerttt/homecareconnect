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

  Map toJson() {
    Map json = {
      "Clinic ID": clinicID,
      "Nurse ID": nurseID,
      "User ID": userID,
      "Description": description,
    };
    return json;
  }
}
