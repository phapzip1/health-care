import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HealthRecordModel {
  String? id;
  String doctorId;
  String doctorName;
  String doctorImage;
  String patientId;
  String patientName;
  String patientImage;
  DateTime time;
  String diagnostic;
  String prescription;
  String note;

  static final CollectionReference _ref = FirebaseFirestore.instance.collection("patient_record");

  HealthRecordModel(
    this.id,
    this.doctorId,
    this.doctorName,
    this.doctorImage,
    this.patientId,
    this.patientName,
    this.patientImage,
    this.time,
    this.diagnostic,
    this.prescription,
    this.note,
  );
  HealthRecordModel.create(
    this.doctorId,
    this.doctorName,
    this.doctorImage,
    this.patientId,
    this.patientName,
    this.patientImage,
    this.time,
    this.diagnostic,
    this.prescription,
    this.note,
  );

  Future<void> save() async {
    try {
      if (id == null) {
        final docRef = await _ref.add({
          "doctor_id": doctorId,
          "doctor_name": doctorName,
          "doctor_image": doctorImage,
          "patient_id": patientId,
          "patient_name": patientName,
          "patient_image": patientImage,
          "time": Timestamp.fromDate(time),
          "diagnostic": diagnostic,
          "prescription": prescription,
          "note": note,
        });
        id = docRef.id;
      } else {
        await _ref.doc(id).set({
          "doctor_id": doctorId,
          "doctor_name": doctorName,
          "doctor_image": doctorImage,
          "patient_id": patientId,
          "patient_name": patientName,
          "patient_image": patientImage,
          "time": Timestamp.fromDate(time),
          "diagnostic": diagnostic,
          "prescription": prescription,
          "note": note,
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> remove() async {
    try {
      if (id != null) {
        _ref.doc(id).delete();
      } else {
        debugPrint("Id was null!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<List<HealthRecordModel>> get({String? doctorId, String? patientId}) async {
    final res = <HealthRecordModel>[];
    if (doctorId != null) {
      res.addAll((await _ref.where("doctor_id", isEqualTo: doctorId).orderBy("time").get())
          .docs
          .map(
            (e) => HealthRecordModel(
              e.id,
              e.get("doctor_id"),
              e.get("doctor_name"),
              e.get("doctor_image"),
              e.get("patient_id"),
              e.get("patient_name"),
              e.get("patient_image"),
              (e.get("time") as Timestamp).toDate(),
              e.get("diagnostic"),
              e.get("prescription"),
              e.get("note"),
            ),
          )
          .toList());
    } else if (patientId != null) {
      res.addAll((await _ref.where("patient_id", isEqualTo: patientId).orderBy("time").get())
          .docs
          .map(
            (e) => HealthRecordModel(
              e.id,
              e.get("doctor_id"),
              e.get("doctor_name"),
              e.get("doctor_image"),
              e.get("patient_id"),
              e.get("patient_name"),
              e.get("patient_image"),
              (e.get("time") as Timestamp).toDate(),
              e.get("diagnostic"),
              e.get("prescription"),
              e.get("note"),
            ),
          )
          .toList());
    }
    return res;
  }
}
