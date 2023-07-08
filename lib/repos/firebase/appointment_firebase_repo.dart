import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/models/appointment_model.dart';
import 'package:health_care/models/health_record_model.dart';
import 'package:health_care/repos/appointment_repo.dart';
import 'package:health_care/repos/repo_exception.dart';
import 'package:health_care/screens/general/toast_notification.dart';

class AppointmentFirebaseRepo extends AppointmentRepo {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection("appointment");

  String _weekday(int wd) {
    switch (wd) {
      case 1:
        return "mon";
      case 2:
        return "tue";
      case 3:
        return "wed";
      case 4:
        return "thu";
      case 5:
        return "fri";
      case 6:
        return "sat";
      case 7:
        return "sun";
    }
    throw Exception("Invalid value");
  }

  @override
  Future<void> cancelAppointment(String id) async {
    try {
      await _ref.doc(id).update({
        "status": 3,
      });
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<void> declineAppointment(String id) async {
    try {
      await _ref.doc(id).update({
        "status": 2,
      });
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
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
  }) async {
    try {
      final snapshot = await _ref
          .where("datetime", isEqualTo: Timestamp.fromDate(datetime))
          .count()
          .get();
      if (snapshot.count == 0) {
        await _ref
            .add({
              "doctor_id": doctorId,
              "doctor_name": doctorName,
              "doctor_image": doctorImage,
              "doctor_phone": doctorPhone,
              "patient_id": patientId,
              "patient_name": patientName,
              "patient_image": patientImage,
              "patient_phone": patientPhone,
              "specialization": specialization,
              "datetime": datetime,
              "status": 0,
              "health_record": {
                "diagnostic": "",
                "prescription": "",
                "note": "",
              }
            })
            .then((value) => ToastNotification()
                .showToast("Make appointment successfully", true))
            .onError((error, stackTrace) => ToastNotification()
                .showToast("Make appointment unsuccessfully", false));
        ;
      } else {
        throw const QueryDBException("Already occupied!");
      }
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<List<AppointmentModel>> getAppointmentByDoctorId(String id) async {
    try {
      final now = DateTime.now();
      final querySnapshot = await _ref
          .where("doctor_id", isEqualTo: id)
          .where("datetime", isGreaterThan: Timestamp.fromDate(now))
          .where("status", whereIn: [1, 2]).get();
      return querySnapshot.docs
          .map((e) => AppointmentModel.fromMap({
                "id": e.id,
                "doctor_id": e.get("doctor_id"),
                "doctor_name": e.get("doctor_name"),
                "doctor_image": e.get("doctor_image"),
                "doctor_phone": e.get("doctor_phone"),
                "patient_id": e.get("patient_id"),
                "patient_name": e.get("patient_name"),
                "patient_image": e.get("patient_image"),
                "patient_phone": e.get("patient_phone"),
                "specialization": e.get("specialization"),
                "price": e.get("price"),
                "datetime": (e.get("datetime") as Timestamp).toDate(),
                "status": e.get("status"),
                "health_record": e.get("health_record"),
              }))
          .toList();
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<List<AppointmentModel>> getAppointmentByPatientId(String id) async {
    try {
      final now = DateTime.now();
      final querySnapshot = await _ref
          .where("patient_id", isEqualTo: id)
          .where("datetime", isGreaterThan: Timestamp.fromDate(now))
          .where("status", whereIn: [1, 2]).get();
      return querySnapshot.docs
          .map((e) => AppointmentModel.fromMap({
                "id": e.id,
                "doctor_id": e.get("doctor_id"),
                "doctor_name": e.get("doctor_name"),
                "doctor_image": e.get("doctor_image"),
                "doctor_phone": e.get("doctor_phone"),
                "patient_id": e.get("patient_id"),
                "patient_name": e.get("patient_name"),
                "patient_image": e.get("patient_image"),
                "patient_phone": e.get("patient_phone"),
                "specialization": e.get("specialization"),
                "price": e.get("price"),
                "datetime": (e.get("datetime") as Timestamp).toDate(),
                "status": e.get("status"),
                "health_record": e.get("health_record"),
              }))
          .toList();
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<List<AppointmentModel>> getOldAppointmentByDoctorId(String id) async {
    try {
      final now = DateTime.now();
      final rejected = await _ref
          .where("doctor_id", isEqualTo: id)
          .where("status", whereIn: [2, 3]).get();
      final outdated = await _ref
          .where("doctor_id", isEqualTo: id)
          .where("datetime", isGreaterThan: Timestamp.fromDate(now))
          .get();
      final list = rejected.docs;
      list.addAll(outdated.docs);
      return list
          .map((e) => AppointmentModel.fromMap({
                "id": e.id,
                "doctor_id": e.get("doctor_id"),
                "doctor_name": e.get("doctor_name"),
                "doctor_image": e.get("doctor_image"),
                "doctor_phone": e.get("doctor_phone"),
                "patient_id": e.get("patient_id"),
                "patient_name": e.get("patient_name"),
                "patient_image": e.get("patient_image"),
                "patient_phone": e.get("patient_phone"),
                "specialization": e.get("specialization"),
                "price": e.get("price"),
                "datetime": (e.get("datetime") as Timestamp).toDate(),
                "status": e.get("status"),
                "health_record": e.get("health_record"),
              }))
          .toList();
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<List<AppointmentModel>> getOldAppointmentByPatientId(String id) async {
    try {
      final now = DateTime.now();
      final rejected = await _ref
          .where("patient_id", isEqualTo: id)
          .where("status", whereIn: [2, 3]).get();
      final outdated = await _ref
          .where("patient_id", isEqualTo: id)
          .where("datetime", isGreaterThan: Timestamp.fromDate(now))
          .get();
      final list = rejected.docs;
      list.addAll(outdated.docs);
      return list
          .map((e) => AppointmentModel.fromMap({
                "id": e.id,
                "doctor_id": e.get("doctor_id"),
                "doctor_name": e.get("doctor_name"),
                "doctor_image": e.get("doctor_image"),
                "doctor_phone": e.get("doctor_phone"),
                "patient_id": e.get("patient_id"),
                "patient_name": e.get("patient_name"),
                "patient_image": e.get("patient_image"),
                "patient_phone": e.get("patient_phone"),
                "specialization": e.get("specialization"),
                "price": e.get("price"),
                "datetime": (e.get("datetime") as Timestamp).toDate(),
                "status": e.get("status"),
                "health_record": e.get("health_record"),
              }))
          .toList();
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<void> updateHeathRecord(
      String appointmentId, HealthRecordModel healthrecord) async {
    try {
      await _ref
          .doc(appointmentId)
          .update(healthrecord.toMap())
          .then((value) =>
              ToastNotification().showToast("Update successfully", true))
          .onError((error, stackTrace) =>
              ToastNotification().showToast("Update unsuccessfully", false));
      ;
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<int> getCompletedAppointmentCount(String doctorid) async {
    try {
      final aggregate = await _ref
          .where("doctor_id", isEqualTo: doctorid)
          .where("status", isLessThan: 1)
          .where("status", isEqualTo: 4)
          .count()
          .get();
      return aggregate.count;
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<List<DateTime>> getAvailableTime(
      DateTime date, String doctorid) async {
    try {
      final start = DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);
      final end = DateTime(date.year, date.month, date.day, 23, 59, 0, 0, 0);

      final doctorSnapshot = await FirebaseFirestore.instance
          .collection("doctor")
          .doc(doctorid)
          .get();
      final appointmentSnapshot = await _ref
          .where("doctor_id", isEqualTo: doctorid)
          .where("datetime", isLessThan: end)
          .where("datetime", isGreaterThan: start)
          .get();

      final availableTime = doctorSnapshot
          .get("available_time.${_weekday(date.weekday)}") as List<dynamic>;
      final booked = appointmentSnapshot.docs.map((e) {
        final date = (e.get("datetime") as Timestamp).toDate();
        return date.hour * 10 + (date.minute / 10).truncate();
      });

      return availableTime
          .map((e) => e as int)
          .where((e) => !booked.contains(e))
          .map((e) => DateTime(
                date.year,
                date.month,
                date.day,
                (e / 10).truncate(),
                (e % 10) * 10,
                0,
                0,
              ))
          .toList();
    } catch (e) {
      throw GenericDBException();
    }
  }
}
