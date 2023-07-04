import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:health_care/models/doctor_model.dart';
import 'package:health_care/models/health_record_model.dart';
import 'package:health_care/models/patient_model.dart';

@immutable
abstract class AppEvent {
  const AppEvent();
}

// authentication
class AppEventInitialize extends AppEvent {
  const AppEventInitialize();
}

class AppEventLogin extends AppEvent {
  final String email;
  final String password;
  const AppEventLogin(this.email, this.password);
}

class AppEventCreateDoctorAccount extends AppEvent {
  final String email;
  final String password;
  final File image;
  final String username;
  final String phone;
  final DateTime birthdate;
  final int exp;
  final double price;
  final String identityId;
  final String licenseId;
  final String workplace;
  final String specialization;
  final int gender;

  const AppEventCreateDoctorAccount(
    this.email,
    this.password,
    this.image,
    this.username,
    this.phone,
    this.birthdate,
    this.exp,
    this.price,
    this.identityId,
    this.licenseId,
    this.workplace,
    this.specialization,
    this.gender,
  );
}

class AppEventCreatePatientAccount extends AppEvent {
  final File selectedImage;
  final String email;
  final String password;
  final String username;
  final String phone;
  final int gender;
  final DateTime birthday;

  const AppEventCreatePatientAccount(this.selectedImage, this.email, this.password, this.username, this.phone, this.gender, this.birthday);
}

class AppEventLogout extends AppEvent {
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
  final String? specialization;
  const AppEventLoadPosts(this.specialization);
}

class AppEventLoadPostsAsDoctor extends AppEvent {
  final String doctorId;
  const AppEventLoadPostsAsDoctor(this.doctorId);
}

class AppEventLoadPostsAsPatient extends AppEvent {
  final String patientId;
  const AppEventLoadPostsAsPatient(this.patientId);
}

class AppEventLoadHealthRecords extends AppEvent {
  const AppEventLoadHealthRecords();
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

class AppEventUpdateHealthRecord extends AppEvent {
  final HealthRecordModel healthRecord;
  final String appointmentId;

  const AppEventUpdateHealthRecord(this.healthRecord, this.appointmentId);
}
