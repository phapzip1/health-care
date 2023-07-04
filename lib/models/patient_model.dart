class PatientModel {
  final String id;
  final String name;
  final String phoneNumber;
  final int gender;
  final DateTime birthdate;
  final String email;
  final String image;

  PatientModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        phoneNumber = map["phone_number"],
        gender = map["gender"],
        birthdate = map["birthdate"],
        email = map["email"],
        image = map["image"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "phone_number": phoneNumber,
      "gender": gender,
      "birthdate": birthdate,
      "email": email,
      "image": image,
    };
  }
}
