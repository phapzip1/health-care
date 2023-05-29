import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? id;
  String doctorId;
  String patientId;
  double rating;
  String feedback;

  static final CollectionReference _ref = FirebaseFirestore.instance.collection("review");

  ReviewModel(this.id, this.doctorId, this.patientId, this.rating, this.feedback);

  ReviewModel.create(this.doctorId, this.patientId, this.rating, this.feedback);

  Future<void> save() async {
    try {
      if (id == null) {
        final docRef = await _ref.add({
          "doctor_id": doctorId,
          "patient_id": patientId,
          "rating": rating,
          "feedback": feedback,
        });
        id = docRef.id;
      } else {
        await _ref.doc(id).set({
          "doctor_id": doctorId,
          "patient_id": patientId,
          "rating": rating,
          "feedback": feedback,
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> remove() async {
    await _ref.doc(id).delete();
  }
}
