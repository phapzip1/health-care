class FeedbackModel {
  final String doctorId;
  final String patientId;
  final String patientName;
  final String patientImage;
  final DateTime createAt;
  final double rating;
  final String message;

  FeedbackModel.fromMap(Map<String, dynamic> map)
      : doctorId = map["doctor_id"],
        patientId = map["patient_id"],
        patientName = map["patient_name"],
        patientImage = map["patient_image"],
        createAt = map["create_at"],
        rating = map["rating"],
        message = map["message"];

  Map<String, dynamic> toMap() {
    return {
      "doctor_id": doctorId,
      "patient_id": patientId,
      "patient_name": patientName,
      "patient_image": patientImage,
      "create_at": createAt,
      "rating": rating,
      "message": message,
    };
  }
}
