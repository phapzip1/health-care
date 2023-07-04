import 'package:flutter/foundation.dart' show immutable;
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/models/patient_model.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

// authentication
class AppEventInitialize extends AppEvent{
  const AppEventInitialize();
}

class AppEventLogin extends AppEvent {
  final String email;
  final String password;
  const AppEventLogin(this.email, this.password);
}

class AppEventCreateAccount extends AppEvent {
  final String email;
  final String password;
  const AppEventCreateAccount(this.email, this.password);
}

class AppEventLogout extends AppEvent{
  const AppEventLogout();
}

// loading data
class AppEventLoadDoctors extends AppEvent {
  final String? specialization;
  const AppEventLoadDoctors(this.specialization);
}

class AppEventLoadAppointments extends AppEvent {
  const AppEventLoadAppointments();
}

class AppEventLoadPosts extends AppEvent {
  const AppEventLoadPosts();
}

class AppEventLoadDoctorInfomation extends AppEvent {
  const AppEventLoadDoctorInfomation();
}

class AppEventLoadPatientInfomation extends AppEvent {
  const AppEventLoadPatientInfomation();
}

// update data
class AppEventUpdateDoctorInfomation extends AppEvent {
  final DoctorModel doctor;
  const AppEventUpdateDoctorInfomation(this.doctor);
}
class AppEventUpdatePatientInfomation extends AppEvent {
  final PatientModel patient;
  const AppEventUpdatePatientInfomation(this.patient);
}