import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_care/models/post_model.dart';
import 'package:health_care/repos/post_repo.dart';
import 'package:health_care/repos/repo_exception.dart';

class PostFirebaseRepo extends PostRepo {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection("post");

  @override
  Future<String> create({
    required String patientId,
    required int age,
    required String specialization,
    required String description,
    required int gender,
    required bool private,
    required List<String> images,
  }) async {
    try {
      final docRef = await _ref.add({
        "patient_id": patientId,
        "age": age,
        "doctor_id": "undefined",
        "doctor_name": "undefined",
        "specialization": specialization,
        "description": description,
        "gender": gender,
        "private": private,
        "time": Timestamp.now(),
        "images": images,
        "count": 0,
      });
      return docRef.id;
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<List<PostModel>> getByDoctorId(String id) async {
    try {
      final querySnapshot = await _ref.where("doctor_id", isEqualTo: id).get();
      return querySnapshot.docs
          .map((e) => PostModel.fromMap({
                "id": e.id,
                "patient_id": e.get("patient_id"),
                "doctor_id": e.get("doctor_id"),
                "doctor_name": e.get("doctor_name"),
                "doctor_image": e.get("doctor_image"),
                "age": e.get("age"),
                "specialization": e.get("specialization"),
                "description": e.get("description"),
                "gender": e.get("gender"),
                "private": e.get("private"),
                "time": e.get("time"),
                "images":
                    (e.get("images") as List).map((e) => e as String).toList(),
                "count": e.get("count"),
              }))
          .toList();
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<List<PostModel>> getByField(String? field) async {
    try {
      if (field != null && field != "All") {
        final querySnapshot = await _ref
            .where("specialization", isEqualTo: field)
            .orderBy("time", descending: false)
            .limit(20)
            .get();
        return querySnapshot.docs
            .map(
              (e) => PostModel.fromMap({
                "id": e.id,
                "patient_id": e.get("patient_id"),
                "doctor_id": (e.get("doctor_id") == "undefined"
                    ? null
                    : e.get("doctor_id")),
                "doctor_name": (e.get("doctor_name") == "undefined"
                    ? null
                    : e.get("doctor_name")),
                "doctor_image": e.get("doctor_image"),
                "age": e.get("age"),
                "specialization": e.get("specialization"),
                "description": e.get("description"),
                "gender": e.get("gender"),
                "private": e.get("private"),
                "time": (e.get("time") as Timestamp).toDate(),
                "images":
                    (e.get("images") as List).map((e) => e as String).toList(),
                "count": e.get("count"),
              }),
            )
            .toList();
      } else {
        final querySnapshot =
            await _ref.orderBy("time", descending: false).limit(20).get();
        return querySnapshot.docs
            .map(
              (e) => PostModel.fromMap({
                "id": e.id,
                "patient_id": e.get("patient_id"),
                "doctor_id": (e.get("doctor_id") == "undefined"
                    ? null
                    : e.get("doctor_id")),
                "doctor_name": (e.get("doctor_name") == "undefined"
                    ? null
                    : e.get("doctor_name")),
                "age": e.get("age"),
                "doctor_image": (e.get("doctor_image") == "undefined"
                    ? null
                    : e.get("doctor_image")),
                "specialization": e.get("specialization"),
                "description": e.get("description"),
                "gender": e.get("gender"),
                "private": e.get("private"),
                "time": (e.get("time") as Timestamp).toDate(),
                "images":
                    (e.get("images") as List).map((e) => e as String).toList(),
                "count": e.get("count"),
              }),
            )
            .toList();
      }
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<List<PostModel>> getByPatientId(String id) async {
    try {
      final querySnapshot = await _ref.where("patient_id", isEqualTo: id).get();
      return querySnapshot.docs
          .map((e) => PostModel.fromMap({
                "id": e.id,
                "patient_id": e.get("patient_id"),
                "doctor_id": e.get("doctor_id"),
                "doctor_name": e.get("doctor_name"),
                "age": e.get("age"),
                "specialization": e.get("specialization"),
                "description": e.get("description"),
                "gender": e.get("gender"),
                "private": e.get("private"),
                "time": e.get("time"),
                "images":
                    (e.get("images") as List).map((e) => e as String).toList(),
                "count": e.get("count"),
              }))
          .toList();
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<void> reply(String message, String senderId, String postId) async {
    try {
      await _ref.doc(postId).collection("chat").add({
        "sender_id": senderId,
        "message": message,
        "create_at": Timestamp.now(),
      });
      await _ref.doc(postId).update({
        "count": FieldValue.increment(1),
      });
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Future<void> replyasDoctor(String message, String senderId, String senderName,
      String postId, String doctorImage) async {
    try {
      final snapshot = await _ref.doc(postId).get();
      if (snapshot.get("doctor_id") == "undefined") {
        await _ref.doc(postId).update({
          "doctor_id": senderId,
          "doctor_name": doctorImage,
          "doctor_image": senderName,
        });
      }
      await _ref.doc(postId).collection("chat").add({
        "sender_id": senderId,
        "message": message,
        "create_at": Timestamp.now(),
      });
      await _ref.doc(postId).update({
        "count": FieldValue.increment(1),
      });
    } catch (e) {
      throw GenericDBException();
    }
  }

  @override
  Stream getStreamChat(String postid) {
    return _ref.doc(postid).collection("chat").snapshots();
  }
}
