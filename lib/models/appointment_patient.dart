import 'package:health_care/models/doctor_info.dart';

class PatientAppointment {
  late String time;
  late String day;
  late Doctor doctor;
  late int status;

  PatientAppointment(timeAppointment, doctor, status, day) {
    this.time = timeAppointment;
    this.day = day;
    this.doctor = doctor;
    this.status = status;

  }
}
