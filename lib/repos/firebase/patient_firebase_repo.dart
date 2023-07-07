import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:health_care/repos/patient_repo.dart';
import 'package:health_care/repos/repo_exception.dart';

class PatientFirebaseRepo extends PatientRepo {
  final CollectionReference _ref = FirebaseFirestore.instance.collection("patient");
  @override
  Future<void> add({
    required String id,
    required String name,
    required String phoneNumber,
    required int gender,
    required DateTime birthdate,
    required String email,
    required String image,
  }) async {
    try {
      await _ref.doc(id).set({
        "name": name,
        "phone_number": phoneNumber,
        "gender": gender,
        "birthdate": birthdate,
        "email": email,
        "image": image,
      });
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<void> update({
    required String id,
    required String name,
    required String phoneNumber,
    required int gender,
    required DateTime birthdate,
    String? image,
  }) async {
    try {
      if (image != null) {
        await _ref.doc(id).update({
          "name": name,
          "phone_number": phoneNumber,
          "gender": gender,
          "birthdate": birthdate,
          "image": image,
        });
      } else {
        await _ref.doc(id).update({
          "name": name,
          "phone_number": phoneNumber,
          "gender": gender,
          "birthdate": birthdate,
        });
      }
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<PatientModel?> getById(String id) async {
    try {
      final snapshot = await _ref.doc(id).get();
      if (snapshot.exists) {
        return PatientModel.fromMap({
          "id": snapshot.id,
          "name": snapshot.get("name"),
          "phone_number": snapshot.get("phone_number"),
          "gender": snapshot.get("gender"),
          "birthdate": (snapshot.get("birthdate") as Timestamp).toDate(),
          "email": snapshot.get("email"),
          "image": snapshot.get("image"),
        });
      }
      return null;
    } catch (e) {
      throw GenericDBException();
    }
  }
}
