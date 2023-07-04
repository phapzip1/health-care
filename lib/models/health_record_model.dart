import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HealthRecordModel {
  final String appointmentId;
  final String doctorId;
  final String doctorName;
  final String doctorImage;
  final String patientId;
  final String patientName;
  final String patientImage;
  final String diagnostic;
  final String prescription;
  final String note;

  HealthRecordModel.fromMap(Map<String, dynamic> map)
      : appointmentId = map["appointment_id"],
        doctorId = map["doctor_id"],
        doctorName = map["doctor_name"],
        doctorImage = map["doctor_image"],
        patientId = map["patient_id"],
        patientName = map["patient_name"],
        patientImage = map["patient_image"],
        diagnostic = map["diagnostic"],
        prescription = map["prescription"],
        note = map["note"];

  Map<String, dynamic> toMap() {
    return {
      "appointment_id": appointmentId,
      "doctor_id": doctorId,
      "doctor_name": doctorName,
      "doctor_image": doctorImage,
      "patient_id": patientId,
      "patient_name": patientName,
      "patient_image": patientImage,
      "diagnostic": diagnostic,
      "prescription": prescription,
      "note": note,
    };
  }
}
