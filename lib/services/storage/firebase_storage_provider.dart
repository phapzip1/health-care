import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:health_care/services/storage/storage_exception.dart';
import 'package:health_care/services/storage/storage_provider.dart';

class FirebaseStorageProvider extends StorageProvider {
  final FirebaseStorage _instance = FirebaseStorage.instance;

  @override
  Future<String> uploadImage(File image, String path) async {
    try {
      final task = await _instance.ref(path).putFile(image);
      final downloadurl = await task.ref.getDownloadURL();
      return downloadurl;
    } catch (e) {
      throw GenericStorageException();
    }
  }

}