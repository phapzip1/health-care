import 'package:health_care/models/health_record_model.dart';

class AppointmentModel {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorPhone;
  final String doctorImage;
  final String patientId;
  final String patientName;
  final String patientImage;
  final String patientPhone;
  final String specialization;
  final double price;
  final DateTime datetime;
  final HealthRecordModel healthRecord;
  // 0: pending
  // 1: confirmed
  // 2: rejected
  // 3: canceled
  // 4: completed
  final int status;

  AppointmentModel(
    this.id,
    this.doctorId,
    this.doctorName,
    this.doctorPhone,
    this.doctorImage,
    this.patientId,
    this.patientName,
    this.patientImage,
    this.patientPhone,
    this.specialization,
    this.price,
    this.datetime,
    this.healthRecord,
    this.status,
  );

  AppointmentModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        doctorId = map["doctor_id"],
        doctorName = map["doctor_name"],
        doctorImage = map["doctor_image"],
        doctorPhone = map["doctor_phone"],
        patientId = map["patient_id"],
        patientName = map["patient_name"],
        patientImage = map["patient_image"],
        patientPhone = map["patient_phone"],
        specialization = map["specialization"],
        price = map["price"],
        datetime = map["datetime"],
        status = map["status"],
        healthRecord = HealthRecordModel.fromMap(map["health_record"]);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "doctor_id": doctorId,
      "doctor_name": doctorName,
      "doctor_image": doctorImage,
      "doctor_phone": doctorPhone,
      "patient_id": patientId,
      "patient_name": patientName,
      "patient_image": patientImage,
      "patient_phone": patientPhone,
      "specialization": specialization,
      "price": price,
      "datetime": datetime,
      "status": status,
      "health_record": healthRecord.toMap(),
    };
  }
}
