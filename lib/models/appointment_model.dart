import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentModel {
  String? id;
  String doctorId;
  String doctorName;
  String doctorPhone;
  String doctorImage;
  String patientId;
  String patientName;
  String patientImage;
  String patientPhone;
  String specialization;
  DateTime dateTime;
  bool status;

  static final CollectionReference _ref = FirebaseFirestore.instance.collection("appointment");

  AppointmentModel(
    this.id,
    this.doctorId,
    this.doctorName,
    this.doctorPhone,
    this.doctorImage,
    this.patientId,
    this.patientName,
    this.patientPhone,
    this.patientImage,
    this.specialization,
    this.dateTime,
    this.status,
  );

  AppointmentModel.create(
    this.doctorId,
    this.doctorName,
    this.doctorPhone,
    this.doctorImage,
    this.patientId,
    this.patientName,
    this.patientPhone,
    this.patientImage,
    this.specialization,
    this.dateTime,
    this.status,
  );

  Future<void> save() async {
    try {
      if (id == null) {
        final docRef = await _ref.add({
          "doctor_id": doctorId,
          "doctor_name": doctorName,
          "doctor_image": doctorImage,
          "doctor_phone": doctorPhone,
          "patient_id": patientId,
          "patient_name": patientName,
          "patient_image": patientImage,
          "patient_phone": patientPhone,
          "specialization": specialization,
          "datetime": Timestamp.fromDate(dateTime),
          "status": status,
        });
        id = docRef.id;
      } else {
        await _ref.doc(id).set({
          "doctor_id": doctorId,
          "doctor_name": doctorName,
          "doctor_image": doctorImage,
          "doctor_phone": doctorPhone,
          "patient_id": patientId,
          "patient_name": patientName,
          "patient_image": patientImage,
          "patient_phone": patientPhone,
          "specialization": specialization,
          "datetime": Timestamp.fromDate(dateTime),
          "status": status,
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<List<AppointmentModel>> getAppointment({String? doctorId, String? patientId}) async {
    if (doctorId != null) {
      final snapshot = await _ref.where("doctor_id", isEqualTo: doctorId).get();
      final res = snapshot.docs
          .map(
            (e) => AppointmentModel(
              e.id,
              e.get("doctor_id"),
              e.get("doctor_name"),
              e.get("doctor_image"),
              e.get("doctor_phone"),
              e.get("patient_id"),
              e.get("patient_name"),
              e.get("patient_image"),
              e.get("patient_phone"),
              e.get("specialization"),
              (e.get("datetime") as Timestamp).toDate(),
              e.get("status"),
            ),
          )
          .toList();
      return res;
    }
    final snapshot = await _ref.where("patient_id", isEqualTo: patientId).get();
    final res = snapshot.docs
        .map(
          (e) => AppointmentModel(
            e.id,
            e.get("doctor_id"),
            e.get("doctor_name"),
            e.get("doctor_image"),
            e.get("doctor_phone"),
            e.get("patient_id"),
            e.get("patient_name"),
            e.get("patient_image"),
            e.get("patient_phone"),
            e.get("specialization"),
            (e.get("datetime") as Timestamp).toDate(),
            e.get("status"),
          ),
        )
        .toList();
    return res;
  }
}
