import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './patient_model.dart' show Gender;

const _map = [
  "mon",
  "tue",
  "wed",
  "thu",
  "fri",
  "sat",
  "sun",
];

class DoctorModel {
  String? id;
  String name;
  String phoneNumber;
  String image;
  Gender gender;
  DateTime birthdate;
  String email;
  String identityId;
  String licenseId;
  int experience;
  int price;
  String workplace;
  String specialization;

  static final CollectionReference _ref = FirebaseFirestore.instance.collection("doctor");

  DoctorModel(
    this.id,
    this.name,
    this.phoneNumber,
    this.gender,
    this.birthdate,
    this.email,
    this.experience,
    this.price,
    this.workplace,
    this.specialization,
    this.identityId,
    this.licenseId,
    this.image,
  );

  Future<void> save() async {
    try {
      await _ref.doc(id).set({
        "name": name,
        "phone_number": phoneNumber,
        "gender": gender.name,
        "birthdate": Timestamp.fromDate(birthdate),
        "email": email,
        "experience": experience,
        "identityId": identityId,
        "licenseId": licenseId,
        "price": price,
        "workplace": workplace,
        "specialization": specialization,
        "image": image,
        "available_time": {},
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> checkTime() async {
    final snapshot = await _ref.doc(id).get();
    return (snapshot.get('available_time') as Map).isEmpty ;
  }

  static Gender toGenderEnum(String val) {
    switch (val) {
      case "male":
        return Gender.male;
      case "female":
        return Gender.female;
      default:
        return Gender.other;
    }
  }

  static Future<DoctorModel> getById(String id) async {
    final snapshot = await _ref.doc(id).get();

    return DoctorModel(
      snapshot.id,
      snapshot.get("name"),
      snapshot.get("phone_number"),
      toGenderEnum(snapshot.get("gender") as String),
      (snapshot.get("birthdate") as Timestamp).toDate(),
      snapshot.get("email"),
      snapshot.get("experience"),
      snapshot.get("price"),
      snapshot.get("workplace"),
      snapshot.get("specialization"),
      snapshot.get("identityId"),
      snapshot.get("licenseId"),
      snapshot.get("image"),
    );
  }

  // 0 = Monday; 6 == Sun
  Future<List<dynamic>> getSchedule(int weekday) async {
    final snapshot = await _ref.doc(id).get();
    final val = snapshot.get("available_time.${_map[weekday]}");
    return val;
  }

  Future<void> applySchedule(int weekday, List<double> data) async {
    await _ref.doc(id).update({
      "available_time.${_map[weekday]}": data,
    });
  }

  Future<void> applyToAllSchedule(List<double> data) async {
    await _ref.doc(id).update({
      "available_time.mon": data,
    });
    await _ref.doc(id).update({
      "available_time.tue": data,
    });
    await _ref.doc(id).update({
      "available_time.wed": data,
    });
    await _ref.doc(id).update({
      "available_time.thu": data,
    });
    await _ref.doc(id).update({
      "available_time.fri": data,
    });
    await _ref.doc(id).update({
      "available_time.sat": data,
    });
    await _ref.doc(id).update({
      "available_time.sun": data,
    });
  }
}
