import 'package:flutter/foundation.dart' show immutable;
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:health_care/models/post_model.dart';

@immutable
class AppState {
  final bool isLoading;
  final String? uid;
  final DoctorModel? doctor;
  final PatientModel? patient;
  final List<DoctorModel>? doctors;
  final List<PostModel>? posts;
  final List<AppointmentModel>? appointments;

  const AppState(this.isLoading, this.uid, this.doctor, this.patient, this.doctors, this.posts, this.appointments);
}