enum Genders { male, female, other }

class Nurse {
  String? nurseID;
  bool selfEmp = false;
  String? clinicID;
  String? name;
  String? surname;
  int? age;
  dynamic gender;
  String? email;
  String? phoneNumber;
  String? license;

  ///self employed by default is false
  Nurse(this.nurseID, {required this.name, required this.surname, required this.age, required this.email, required this.gender, required this.license, required this.phoneNumber, this.selfEmp = false}) {}

  Nurse.testDummy([int n = 0]) : this('nurseID $n', name: 'petrit $n', surname: 'hoxha $n', age: 32, email: 'petrithoxha$n@gmail.com', phoneNumber: '069696969$n', license: 'licensum nvitin 200$n', gender: Genders.male);
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

  toJson() {
    return {
      "FullName": {
        "Name": name,
        "Surname": surname,
      },
      "ClinicID": clinicID,
      "self emp": selfEmp,
      "Age": age,
      "Gender": getGender(),
      "Contact": {
        "Email": email,
        "phone": phoneNumber,
      },
      "License": license,
    };
  }

  toJsonClinc() {
    return {
      "FullName": {
        "Name": name,
        "Surname": surname,
      },
      "Age": age,
      "Gender": getGender(),
      "Contact": {
        "Email": email,
        "phone": phoneNumber,
      },
      "License": license,
    };
  }
}