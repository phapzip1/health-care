import 'package:cloud_firestore/cloud_firestore.dart';
import './chat_model.dart';

const POST_PER_LOAD = 10;

class PostModel {
  String? id;
  String patientId;
  int age;
  String specialization;
  String descriptions;
  int gender;
  bool private;
  DateTime time;
  List<String>? images;

  String doctorId;
  String doctorName;
  String doctorImage;

  static final CollectionReference _ref = FirebaseFirestore.instance.collection("post");

  PostModel(this.id, this.patientId, this.specialization, this.age, this.descriptions, this.gender, this.doctorId, this.doctorName, this.doctorImage, this.private, this.time, this.images);
  PostModel.create(this.patientId, this.specialization, this.age, this.descriptions, this.gender, this.doctorId, this.doctorName, this.doctorImage, this.private, this.time, this.images);

  Future<void> post() async {
    if (id == null) {
      _ref.add({
        "patient_id": patientId,
        "age": age,
        "specialization": specialization,
        "gender": gender,
        "doctor_id": "",
        "doctor_name": "",
        "doctor_image": "",
        "time": Timestamp.fromDate(time),
        "private": private,
        "images": images,
      });
    }
  }

  Future<void> reply(String message, {bool isDoctor = false}) async {
    if (id != null) {
      _ref.doc(id).collection("chat").add({
        "message": message,
        "is_doctor": isDoctor,
      });
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamChat() {
    return _ref.doc(id).collection("chat").snapshots();
  }

  static Future<List<PostModel>> getPublic(int offset) async {
    if (offset != 0) {
      final docs = await _ref.orderBy("time", descending: true).limit(offset).get();
      final querySnapshot = await _ref.orderBy("time", descending: true).startAfter([docs.docs.length - 1]).limit(POST_PER_LOAD).get();

      return querySnapshot.docs.map((e) {
        return PostModel(e.id, e.get("patient_id"), e.get("specialization"), e.get("age"), e.get("descriptions"), e.get("gender"), e.get("doctor_id"), e.get("doctor_name"), e.get("doctor_image"),
            e.get("private"), (e.get("time") as Timestamp).toDate(), []);
      }).toList();
    }

    final querySnapshot = await _ref.orderBy("time", descending: true).limit(POST_PER_LOAD).get();

    return querySnapshot.docs.map((e) {
      return PostModel(e.id, e.get("patient_id"), e.get("specialization"), e.get("age"), e.get("descriptions"), e.get("gender"), e.get("doctor_id"), e.get("doctor_name"), e.get("doctor_image"),
          e.get("private"), (e.get("time") as Timestamp).toDate(), []);
    }).toList();
  }

  static Future<List<PostModel>> getAsDoctor(int offset, String id) async {
    if (offset != 0) {
      final docs = await _ref.where("doctor_id", whereIn: ["", id]).orderBy("time", descending: true).limit(offset).get();
      final querySnapshot = await _ref.where("doctor_id", whereIn: ["", id]).orderBy("time", descending: true).startAt([docs.docs[docs.size - 1]]).limit(POST_PER_LOAD).get();

      return querySnapshot.docs.map((e) {
        return PostModel(e.id, e.get("patient_id"), e.get("specialization"), e.get("age"), e.get("descriptions"), e.get("gender"), e.get("doctor_id"), e.get("doctor_name"), e.get("doctor_image"),
            e.get("private"), (e.get("time") as Timestamp).toDate(), []);
      }).toList();
    }

    final querySnapshot = await _ref.where("doctor_id", whereIn: ["", id]).orderBy("time", descending: true).limit(POST_PER_LOAD).get();

    return querySnapshot.docs.map((e) {
      return PostModel(e.id, e.get("patient_id"), e.get("specialization"), e.get("age"), e.get("descriptions"), e.get("gender"), e.get("doctor_id"), e.get("doctor_name"), e.get("doctor_image"),
          e.get("private"), (e.get("time") as Timestamp).toDate(), []);
    }).toList();
  }

  static Future<List<PostModel>> getAsPatient(int offset, String id) async {
    if (offset != 0) {
      final docs = await _ref.where("doctor_id", whereIn: ["", id]).orderBy("time", descending: true).limit(offset).get();
      final querySnapshot = await _ref.where("patient_id", isEqualTo: id).orderBy("time", descending: true).startAt([docs.docs[docs.size - 1]]).limit(POST_PER_LOAD).get();

      return querySnapshot.docs
          .map(
            (e) => PostModel(e.id, id, e.get("specialization"), e.get("age"), e.get("descriptions"), e.get("gender"), e.get("doctor_id"), e.get("doctor_name"), e.get("doctor_image"), e.get("private"),
                (e.get("time") as Timestamp).toDate(), []),
          )
          .toList();
    }
    final querySnapshot = await _ref.where("patient_id", isEqualTo: id).orderBy("time", descending: true).limit(POST_PER_LOAD).get();

    return querySnapshot.docs
        .map(
          (e) => PostModel(e.id, id, e.get("specialization"), e.get("age"), e.get("descriptions"), e.get("gender"), e.get("doctor_id"), e.get("doctor_name"), e.get("doctor_image"), e.get("private"),
              (e.get("time") as Timestamp).toDate(), []),
        )
        .toList();
  }
}
