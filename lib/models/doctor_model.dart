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
  int experience;
  int price;
  Map<String, dynamic> availableTime;

  static final CollectionReference _ref = FirebaseFirestore.instance.collection("doctor");

  DoctorModel(
    this.id,
    this.name,
    this.phoneNumber,
    this.image,
    this.gender,
    this.birthdate,
    this.email,
    this.experience,
    this.price,
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
        "image": image,
        "available_time": availableTime,
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
