import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HealthRecordModel {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorImage;
  final String patientId;
  final String patientName;
  final String patientImage;
  final DateTime createAt;
  final String diagnostic;
  final String prescription;
  final String note;

  HealthRecordModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        doctorId = map["doctor_id"],
        doctorName = map["doctor_name"],
        doctorImage = map["doctor_image"],
        patientId = map["patient_image"],
        patientName = map["patient_image"],
        patientImage = map["patient_image"],
        createAt = map["create_at"],
        diagnostic = map["diagnostic"],
        prescription = map["prescription"],
        note = map["note"];
}
