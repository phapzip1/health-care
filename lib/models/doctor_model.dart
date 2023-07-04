class DoctorModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String image;
  final int gender;
  final DateTime birthdate;
  final String email;
  final String identityId;
  final String licenseId;
  final int experience;
  final double price;
  final String workplace;
  final String specialization;
  final bool verified;
  final double rating;

  DoctorModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        phoneNumber = map["phone_number"],
        image = map["image"],
        gender = map["gender"],
        birthdate = map["birthday"],
        email = map["email"],
        identityId = map["identity_id"],
        licenseId = map["license_id"],
        experience = map["experience"],
        price = map["price"],
        workplace = map["workplace"],
        specialization = map["specialization"],
        verified = map["verified"],
        rating = map["rating"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "phone_number": phoneNumber,
      "image": image,
      "gender": gender,
      "birthday": birthdate,
      "email": email,
      "identity_id": identityId,
      "license_id": licenseId,
      "experience": experience,
      "price": price,
      "workplace": workplace,
      "specialization": specialization,
      "verified": verified,
      "rating": rating,
    };
  }
}
