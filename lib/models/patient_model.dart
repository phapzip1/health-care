import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum Gender {
  male,
  female,
  other,
}

class PatientModel {
  String? id;
  String name;
  String phoneNumber;
  Gender gender;
  DateTime birthdate;
  String email;
  String image;

  PatientModel(
    this.id,
    this.name,
    this.phoneNumber,
    this.gender,
    this.birthdate,
    this.email,
    this.image,
  );

  PatientModel.create(
    this.name,
    this.phoneNumber,
    this.gender,
    this.birthdate,
    this.email,
    this.image,
  );

  static final CollectionReference _ref = FirebaseFirestore.instance.collection("patient");

  Future<void> save() async {
    try {
      if (id == null) {
        await _ref.doc(id).set({
          "name": name,
          "phone_number": phoneNumber,
          "gender": gender.name,
          "birthdate": Timestamp.fromDate(birthdate),
          "email": email,
          "image": image,
        });
      } else {
        final docRef = await _ref.add({
          "name": name,
          "phone_number": phoneNumber,
          "gender": gender.name,
          "birthdate": Timestamp.fromDate(birthdate),
          "email": email,
          "image": image,
        });
        id = docRef.id;
      }
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

  static Future<PatientModel> getById(String id) async {
    final snapshot = await _ref.doc(id).get();

    return PatientModel(
      snapshot.id,
      snapshot.get("name"),
      snapshot.get("phone_number"),
      toGenderEnum(snapshot.get("gender") as String),
      (snapshot.get("birthdate") as Timestamp).toDate(),
      snapshot.get("email"),
      snapshot.get("image"),
    );
  }
}
