import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/models/feedback_model.dart';

abstract class DoctorRepo {
  const DoctorRepo();

  // get current doctor
  Future<DoctorModel?> getById(String id);

  Future<void> updateAvailableTime(String doctorid, List<double> time, String weekday);

  // get multiple doctors
  Future<List<DoctorModel>> getBySpecification(String spec);
  Future<void> update(DoctorModel model);
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
  });

  Future<List<DoctorModel>> getAll();

  //feedback
  Future<void> giveFeedback({
    required String doctorId,
    required String patientId,
    required String patientName,
    required String patientImage,
    required DateTime createAt,
    required double rating,
    required String message,
  });
  Future<void> removeFeedback(String doctorId, String patientId);

  Future<List<FeedbackModel>> getFeedbacks(String doctorid);
}
