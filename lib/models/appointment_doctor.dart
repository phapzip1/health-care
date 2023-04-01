
import 'package:health_care/models/patient_info.dart';

class DoctorAppointment {
  late String day;
  late String time;
  late Patient patient;
  late int status;
  late String issues;

  DoctorAppointment(String day, String time, Patient patient, int status, String issues){
    this.day = day;
    this.time = time;
    this.patient = patient;
    this.status = status;
    this.issues = issues;
  }
}