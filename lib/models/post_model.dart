import 'package:cloud_firestore/cloud_firestore.dart';
import './chat_model.dart';

class PostModel {
  String postId;
  String specialization;
  String? doctorId;
  String? doctorName;
  String? doctorImage;
  bool closed;

  static final CollectionReference _ref = FirebaseFirestore.instance.collection("post");

  PostModel(this.postId, this.specialization, this.doctorId, this.doctorName, this.doctorImage, this.closed);

  Future<void> post() async {}

  Future<List<ChatModel>> getChat() async {
    final snapshot = await _ref.doc(postId).collection("chat").get();
    final res = snapshot.docs.map(
      (e) => ChatModel(
        postId,
        e.get("sender_id"),
        (e.get("time") as Timestamp).toDate(),
        image: e.data()["image"],
        text: e.data()["text"],
      ),
    ).toList();
    return res;
  }
}
