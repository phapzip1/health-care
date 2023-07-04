import 'dart:io';

abstract class StorageProvider {
  Future<String> uploadImage(File image, String path);
}