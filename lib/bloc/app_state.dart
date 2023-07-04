import 'package:flutter/foundation.dart' show immutable;
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/models/health_record_model.dart';
import 'package:health_care/models/patient_model.dart';
import 'package:health_care/models/post_model.dart';
import 'package:health_care/models/symptom_model.dart';
import 'package:health_care/services/auth/auth_user.dart';

@immutable
class AppState {
  final bool isLoading;
  final AuthUser? user;
  final List<SymptomModel>? symptom;
  final DoctorModel? doctor;
  final PatientModel? patient;
  final List<DoctorModel>? doctors;
  final List<PostModel>? posts;
  final List<AppointmentModel>? appointments;
  final List<HealthRecordModel>? records;

  const AppState(this.isLoading, this.user, this.doctor, this.patient, this.symptom, this.doctors, this.posts, this.appointments, this.records);
}
