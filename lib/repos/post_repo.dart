import 'package:health_care/models/post_model.dart';

abstract class PostRepo {
  Future<void> create({
    required String patientId,
    required int age,
    required String specialization,
    required String description,
    required int gender,
    required bool private,
    required List<String> images,
  });
  Future<void> reply(String message, String senderId, String postId);
  Future<void> replyasDoctor(String message, String senderId, String senderName, String postId);

  // nhung cau hoi theo linh vuc
  Future<List<PostModel>> getByField(String? field);

  // nhung cau hoi cua benh nhan
  Future<List<PostModel>> getByPatientId(String id);

  // nhung cau hoi cua bac si da tra loi
  Future<List<PostModel>> getByDoctorId(String id);
}
