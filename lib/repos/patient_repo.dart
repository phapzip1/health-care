import 'package:health_care/models/patient_model.dart';

abstract class PatientRepo {
  const PatientRepo();

  Future<PatientModel?> getById(String id);
  Future<void> add({
    required String id,
    required String name,
    required String phoneNumber,
    required int gender,
    required DateTime birthdate,
    required String email,
    required String image,
  });
  Future<void> update({
    required String id,
    required String name,
    required String phoneNumber,
    required int gender,
    required DateTime birthdate,
    String? image,
  });
}
