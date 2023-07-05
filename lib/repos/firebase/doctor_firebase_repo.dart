import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/models/feedback_model.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/repos/doctor_repo.dart';
import 'package:health_care/repos/repo_exception.dart';

class DoctorFirebaseRepo extends DoctorRepo {
  final CollectionReference _ref = FirebaseFirestore.instance.collection("doctor");

  @override
  Future<void> add({
    required String id,
    required String name,
    required String phoneNumber,
    required String image,
    required int gender,
    required DateTime birthdate,
    required String email,
    required String identityId,
    required String licenseId,
    required int experience,
    required double price,
    required String workplace,
    required String specialization,
  }) async {
    try {
      await _ref.doc(id).set({
        "name": name,
        "phone_number": phoneNumber,
        "image": image,
        "gender": gender,
        "birthday": Timestamp.fromDate(birthdate),
        "email": email,
        "identity_id": identityId,
        "license_id": licenseId,
        "experience": experience,
        "price": price,
        "workplace": workplace,
        "specialization": specialization,
        "verified": false,
        "rating": 0.0,
        "available_time": {
          "mon": [],
          "tue": [],
          "wed": [],
          "thu": [],
          "fri": [],
          "sat": [],
          "sun": [],
        }
      });
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<void> giveFeedback({
    required String doctorId,
    required String patientId,
    required String patientName,
    required String patientImage,
    required DateTime createAt,
    required double rating,
    required String message,
  }) async {
    try {
      await _ref.doc(doctorId).collection("feedback").doc(patientId).set({
        "patient_name": patientName,
        "patient_image": patientImage,
        "create_at": Timestamp.fromDate(createAt),
        "rating": rating,
        "message": message,
      });
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<void> removeFeedback(String doctorId, String patientId) async {
    try {
      await _ref.doc(doctorId).collection("feedback").doc(patientId).delete();
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<List<FeedbackModel>> getFeedbacks(String doctorid) async {
    try {
      final querySnapshot = await _ref.doc(doctorid).collection("feedback").get();
      return querySnapshot.docs
          .map((e) => FeedbackModel.fromMap({
                "doctor_id": doctorid,
                "patient_id": e.id,
                "patient_name": e.get("patient_name"),
                "patient_image": e.get("patient_image"),
                "create_at": e.get("create_at"),
                "rating": e.get("rating"),
                "message": e.get("message"),
              }))
          .toList();
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<void> update({
    required String id,
    required String? avatar,
    required String username,
    required String phone,
    required int gender,
    required String workplace,
    required int exp,
    required double price,
    required DateTime birthdate,
  }) async {
    try {
      if (avatar != null) {
        await _ref.doc(id).update({
          "name": username,
          "phone_number": phone,
          "image": avatar,
          "gender": gender,
          "birthday": (birthdate as Timestamp).toDate(),
          "price": price,
          "workplace": workplace,
          "experience": exp,
        });
      } else {
        await _ref.doc(id).update({
          "name": username,
          "phone_number": phone,
          "gender": gender,
          "birthday": (birthdate as Timestamp).toDate(),
          "price": price,
          "workplace": workplace,
          "experience": exp,
        });
      }
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<DoctorModel?> getById(String id) async {
    try {
      final snapshot = await _ref.doc(id).get();
      if (snapshot.exists) {
        return DoctorModel.fromMap({
          "id": snapshot.id,
          "name": snapshot.get("name"),
          "phone_number": snapshot.get("phone_number"),
          "image": snapshot.get("image"),
          "gender": snapshot.get("gender"),
          "birthday": (snapshot.get("birthday") as Timestamp).toDate(),
          "email": snapshot.get("email"),
          "identity_id": snapshot.get("identity_id"),
          "license_id": snapshot.get("license_id"),
          "experience": snapshot.get("experience"),
          "price": snapshot.get("price"),
          "workplace": snapshot.get("workplace"),
          "specialization": snapshot.get("specialization"),
          "verified": snapshot.get("verified"),
          "rating": snapshot.get("rating"),
          "available_time": snapshot.get("available_time"),
        });
      }
      return null;
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<List<DoctorModel>> getBySpecification(String spec) async {
    try {
      final querySnapshot = await _ref.where("specialization", isEqualTo: spec).where("verified", isEqualTo: true).orderBy("rating", descending: true).get();
      return querySnapshot.docs
          .map((e) => DoctorModel.fromMap({
                "id": e.id,
                "name": e.get("name"),
                "phone_number": e.get("phone_number"),
                "image": e.get("image"),
                "gender": e.get("gender"),
                "birthday": (e.get("birthday") as Timestamp).toDate(),
                "email": e.get("email"),
                "identity_id": e.get("identity_id"),
                "license_id": e.get("license_id"),
                "experience": e.get("experience"),
                "price": e.get("price"),
                "workplace": e.get("workplace"),
                "specialization": e.get("specialization"),
                "verified": e.get("verified"),
                "rating": e.get("rating"),
                "available_time": e.get("available_time"),
              }))
          .toList();
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<List<DoctorModel>> getAll() async {
    try {
      final querySnapshot = await _ref.orderBy("rating", descending: true).get();
      return querySnapshot.docs
          .map((e) => DoctorModel.fromMap({
                "id": e.id,
                "name": e.get("name"),
                "phone_number": e.get("phone_number"),
                "image": e.get("image"),
                "gender": e.get("gender"),
                "birthday": (e.get("birthday") as Timestamp).toDate(),
                "email": e.get("email"),
                "identity_id": e.get("identity_id"),
                "license_id": e.get("license_id"),
                "experience": e.get("experience"),
                "price": e.get("price"),
                "workplace": e.get("workplace"),
                "specialization": e.get("specialization"),
                "verified": e.get("verified"),
                "rating": e.get("rating"),
              }))
          .toList();
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<void> updateAvailableTime(String doctorid, List<int> time, String weekday) async {
    try {
      await _ref.doc(doctorid).update({
        "available_time.$weekday": time,
      });
    } catch (e) {
      throw GenericDBException();
    }
  }
}
