import 'package:health_care/models/doctor_info.dart';

class PatientAppointment {
  late DateTime timeAppointment;
  late Doctor doctor;
  late int status;

  PatientAppointment(timeAppointment, doctor, status) {
    this.timeAppointment = timeAppointment;
    this.doctor = doctor;
    this.status = status;
  }
}
