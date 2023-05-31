import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './patient_model.dart' show Gender;

class DoctorModel {
  String? id;
  String name;
  String phoneNumber;
  String image;
  Gender gender;
  DateTime birthdate;
  String email;
  String field;
  int experience;
  int price;
  String workplace;
  String specialization;
  Map<String, dynamic> availableTime;

  static final CollectionReference _ref = FirebaseFirestore.instance.collection("doctor");

  DoctorModel(
    this.id,
    this.name,
    this.phoneNumber,
    this.gender,
    this.birthdate,
    this.email,
    this.field,
    this.experience,
    this.price,
    this.workplace,
    this.specialization,
    this.image,
    this.availableTime,
  );

  Future<void> save() async {
    try {
      await _ref.doc(id).set({
        "name": name,
        "phone_number": phoneNumber,
        "gender": gender.name,
        "birthdate": Timestamp.fromDate(birthdate),
        "email": email,
        "field": field,
        "experience": experience,
        "price": price,
        "workplace": workplace,
        "specialization": specialization,
        "image": image,
        "available_time": availableTime,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
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
      snapshot.get("field"),
      snapshot.get("experience"),
      snapshot.get("price"),
      snapshot.get("workplace"),
      snapshot.get("specialization"),
      snapshot.get("image"),
      snapshot.get("available_time"),
    );
  }
}
