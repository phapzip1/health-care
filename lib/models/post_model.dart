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
    final querySnapshot = await _ref.where("private", isEqualTo: false).orderBy("time", descending: true).startAt([offset]).limit(POST_PER_LOAD).get();
    return querySnapshot.docs.map((e) {
      return PostModel(e.id, e.get("patientId"), e.get("specialization"), e.get("age"), e.get("descriptions"), e.get("gender"), e.get("doctorId"), e.get("doctorName"), e.get("doctorImage"),
          e.get("private"), (e.get("time") as Timestamp).toDate(), []);
    }).toList();
  }

  static Future<List<PostModel>> getByPatientId(String patientId, int offset) async {
    final querySnapshot = await _ref.where("patientId", isEqualTo: patientId).orderBy("time", descending: true).startAt([offset]).limit(POST_PER_LOAD).get();

    return querySnapshot.docs
        .map(
          (e) => PostModel(e.id, patientId, e.get("specialization"), e.get("age"), e.get("descriptions"), e.get("gender"), e.get("doctorId"), e.get("doctorName"), e.get("doctorImage"),
              e.get("private"), (e.get("time") as Timestamp).toDate(), []),
        )
        .toList();
  }
}
