enum Genders { male, female, other }

enum BloodTypes {
  aPositive,
  aNegative,
  bPositive,
  bNegative,
  oPositive,
  oNegative,
  abPositive,
  abNegative,
}

class User {
  dynamic _id;
  dynamic _password;

  String? _name;
  String? _surname;
  int? _age;
  int? _gender;
  int? _bloodType;
  String? _address;

  User(
      {gender,
      bloodType,
      password,
      String? name,
      String? surname,
      int? age,
      id,
      String? address}) {
    _name = name;
    _surname = surname;
    _age = age;
    _gender = gender;
    _bloodType = bloodType;
    _address = address;
    password(password);
    id(id);
  }

  //password
  set password(x) => _password = x;
  get password => _password;

  //id
  set id(x) => _id = x; //idk
  get id => _id;

  //gender
  set bloodType(x) => _bloodType = x;
  int? get gender => _gender;

  //bloodtype
  int? get bloodType => _bloodType;

  //name
  set name(String? x) => _name = x;
  String? get name => _name;

  //surname
  set surname(String? x) => _surname = x;
  String? get surname => _surname;

  //address
  set address(String? x) => _address = x;
  String? get address => _address;

  ///db struct
  toJson() {
    return {
      "Name": "$_name",
      "Surname": "$_surname",
      "Addresss": "$_address",
      "Gender": "$_gender",
      "Bloodtype": "$bloodType",
      "Age": "$_age",
      "password": "$_password",
    };
  }

  @override
  String toString() {
    return '$_name $_surname';
  }
}
