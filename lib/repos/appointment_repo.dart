import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/health_record_model.dart';

abstract class AppointmentRepo {
  Future<List<AppointmentModel>> getAppointmentByDoctorId(String id);
  Future<List<AppointmentModel>> getAppointmentByPatientId(String id);

  Future<List<AppointmentModel>> getOldAppointmentByDoctorId(String id);
  Future<List<AppointmentModel>> getOldAppointmentByPatientId(String id);

  // for patient
  Future<void> makeAppointment({
    required String doctorId,
    required String doctorName,
    required String doctorPhone,
    required String doctorImage,
    required String patientId,
    required String patientName,
    required String patientImage,
    required String patientPhone,
    required String specialization,
    required DateTime datetime,
  });

  // for both
  Future<void> cancelAppointment(String id);

  // for doctor
  Future<void> declineAppointment(String id);

  Future<void> updateHeathRecord(String appointmentId, HealthRecordModel healthrecord);
}
