import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String? id;
  String doctorId;
  String patientId;
  String patientName;
  String patientImage;
  DateTime time;
  double rating;
  String feedback;

  static final CollectionReference _ref =
      FirebaseFirestore.instance.collection("review");

  ReviewModel(this.id, this.doctorId, this.patientId, this.patientName,
      this.patientImage, this.time, this.rating, this.feedback);

  ReviewModel.create(this.doctorId, this.patientId, this.patientName,
      this.patientImage, this.time, this.rating, this.feedback);

  Future<void> save() async {
    try {
      if (id != null) {
        _ref.doc(id).set(
          {
            "doctor_id": doctorId,
            "patient_id": patientId,
            "patient_name": patientName,
            "patient_image": patientImage,
            "create_at": time,
            "rating": rating,
            "feedback": feedback,
          },
          SetOptions(merge: true),
        );
      } else {
        _ref.add({
          "doctor_id": doctorId,
          "patient_id": patientId,
          "patient_name": patientName,
          "patient_image": patientImage,
          "create_at": time,
          "rating": rating,
          "feedback": feedback,
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<ReviewModel?> getByDoctorIdAndPatientId(
      String doctorid, String patientid) async {
    final snapshot = await _ref
        .where("doctor_id", isEqualTo: doctorid)
        .where("patient_id", isEqualTo: patientid)
        .get();
    if (snapshot.size != 0) {
      return ReviewModel(
        snapshot.docs[0].id,
        snapshot.docs[0].get("doctor_id"),
        snapshot.docs[0].get("patient_id"),
        snapshot.docs[0].get("patient_name"),
        snapshot.docs[0].get("patient_image"),
        snapshot.docs[0].get("create_at"),
        snapshot.docs[0].get("rating"),
        snapshot.docs[0].get("feedback"),
      );
    }
    return null;
  }

  static Future<String> getAverageRating(String doctorid) async {
    double sum = 0;
    final snapshot = await _ref.where("doctor_id", isEqualTo: doctorid).get();

    if (snapshot.docs.isNotEmpty) {
      for (final doc in snapshot.docs) {
        final review = ReviewModel(
          doc.id,
          doc.get("doctor_id"),
          doc.get("patient_id"),
          doc.get("patient_name"),
          doc.get("patient_image"),
          (doc.get("create_at") as Timestamp).toDate(),
          doc.get("rating"),
          doc.get("feedback"),
        );

        sum += review.rating;
      }
      sum = sum / snapshot.size;
    }

    return sum.toStringAsFixed(1);
  }

  static Future<int> getTotalReview(String doctorid) async {
    final snapshot = await _ref.where("doctor_id", isEqualTo: doctorid).get();

    return snapshot.docs.isNotEmpty ? snapshot.size : 0;
  }

  Future<void> remove() async {
    await _ref.doc(id).delete();
  }
}
