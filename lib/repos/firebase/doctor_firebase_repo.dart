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
      });
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<void> editFeedback(FeedbackModel feedback) async {
    try {
      await _ref.doc(feedback.id).update({
        "doctor_id": feedback.doctorId,
        "patient_id": feedback.patientId,
        "patient_name": feedback.patientName,
        "patient_image": feedback.patientImage,
        "create_at": Timestamp.fromDate(feedback.createAt),
        "rating": feedback.rating,
        "message": feedback.message,
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
      await _ref.add({
        "doctor_id": doctorId,
        "patient_id": patientId,
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
  Future<void> removeFeedback(String feedbackId) async {
    try {
      await _ref.doc(feedbackId).delete();
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<void> update(DoctorModel model) async {
    try {
      await _ref.doc(model.id).update({
        "name": model.name,
        "phone_number": model.phoneNumber,
        "image": model.image,
        "gender": model.gender,
        "birthday": (model.birthdate as Timestamp).toDate(),
        "email": model.email,
        "identity_id": model.identityId,
        "license_id": model.licenseId,
        "experience": model.experience,
        "price": model.price,
        "workplace": model.workplace,
        "specialization": model.specialization,
        "verified": model.verified,
        "rating": model.rating,
      });
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
}
