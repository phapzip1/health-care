class PostModel {
  final String id;
  final String patientId;
  final String? doctorId;
  final String? doctorName;
  final String? doctorImage;
  final int age;
  final String specialization;
  final String description;
  final int gender;
  final bool private;
  final DateTime time;
  final List<String> images;
  final int count;

  PostModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        patientId = map["patient_id"],
        doctorId = map["doctor_id"],
        doctorName = map["doctor_name"],
        doctorImage = map["doctor_image"],
        age = map["age"],
        specialization = map["specialization"],
        description = map["description"],
        gender = map["gender"],
        private = map["private"],
        time = map["time"],
        images = map["images"],
        count = map["count"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "patient_id": patientId,
      "doctor_id": doctorId,
      "doctor_name": doctorName,
      "doctor_image": doctorImage,
      "age": age,
      "specialization": specialization,
      "description": description,
      "gender": gender,
      "private": private,
      "time": time,
      "images": images,
      "count": count,
    };
  }
}
