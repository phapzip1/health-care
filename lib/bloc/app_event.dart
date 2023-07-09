import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:health_care/models/feedback_model.dart';
import 'package:health_care/models/health_record_model.dart';

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
    this.licenseId,
    this.workplace,
    this.specialization,
    this.gender,
  );
}

class AppEventCreatePatientAccount extends AppEvent {
  final File image;
  final String email;
  final String password;
  final String username;
  final String phone;
  final int gender;
  final DateTime birthday;

  const AppEventCreatePatientAccount(this.image, this.email,
      this.password, this.username, this.phone, this.gender, this.birthday);
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

class AppEventLoadOwnPosts extends AppEvent {
  const AppEventLoadOwnPosts();
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

class AppEventLoadHistory extends AppEvent {
  final String doctorId;

  const AppEventLoadHistory(this.doctorId);
}

class AppEventLoadAvailableTime extends AppEvent {

  final DateTime date;
  const AppEventLoadAvailableTime(this.date);
}

// update data
class AppEventUpdateDoctorInfomation extends AppEvent {
  final File? avatar;
  final String username;
  final String phone;
  final int gender;
  final String workplace;
  final int exp;
  final double price;
  final DateTime birthdate;

  const AppEventUpdateDoctorInfomation(this.avatar, this.username, this.phone,
      this.gender, this.workplace, this.exp, this.price, this.birthdate);
}

class AppEventUpdatePatientInfomation extends AppEvent {
  final String name;
  final String phoneNumber;
  final int gender;
  final DateTime birthdate;
  final File? image;

  const AppEventUpdatePatientInfomation(
      this.name, this.phoneNumber, this.gender, this.birthdate, this.image);
}

// silent actions
class AppEventGiveFeedback extends AppEvent {
  final FeedbackModel feedback;

  const AppEventGiveFeedback(this.feedback);
}

class AppEventMakeAppointment extends AppEvent {
  final String doctorId;
  final String doctorName;
  final String doctorPhone;
  final String doctorImage;
  final String patientId;
  final String patientName;
  final String patientImage;
  final String patientPhone;
  final String specialization;
  final DateTime datetime;

  const AppEventMakeAppointment(
    this.doctorId,
    this.doctorName,
    this.doctorPhone,
    this.doctorImage,
    this.patientId,
    this.patientName,
    this.patientImage,
    this.patientPhone,
    this.specialization,
    this.datetime,
  );
}

class AppEventCancelAppointment extends AppEvent {
  final String appointmentId;

  const AppEventCancelAppointment(this.appointmentId);
}

class AppEventDeclineAppoitment extends AppEvent {
  final String appointmentId;

  const AppEventDeclineAppoitment(this.appointmentId);
}

class AppEventSendFeedback extends AppEvent {
  final FeedbackModel feedback;

  const AppEventSendFeedback(this.feedback);
}

class AppEventUpdateDoctorSchedule extends AppEvent {
  final List<int> times;
  final String? weekday;

  const AppEventUpdateDoctorSchedule({required this.times, this.weekday});
}

class AppEventUpdateHealthRecord extends AppEvent {
  final HealthRecordModel healthRecord;
  final String appointmentId;

  const AppEventUpdateHealthRecord(this.healthRecord, this.appointmentId);
}
