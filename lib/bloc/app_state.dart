import 'package:flutter/foundation.dart' show immutable;
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:health_care/models/post_model.dart';
import 'package:health_care/services/auth/auth_user.dart';

@immutable
class AppState {
  final bool isLoading;
  final AuthUser? user;
  final DoctorModel? doctor;
  final PatientModel? patient;
  final List<DoctorModel>? doctors;
  final List<PostModel>? posts;
  final List<AppointmentModel>? appointments;

  const AppState(this.isLoading, this.user, this.doctor, this.patient, this.doctors, this.posts, this.appointments);
}