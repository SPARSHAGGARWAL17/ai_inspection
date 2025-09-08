import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUploadFileService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(String folderTimestamp, String fileName, File file) async {
    try {
      // Create the full path: folderTimestamp/filename
      final fullPath = '$folderTimestamp/$fileName';
      final ref = _storage.ref().child(fullPath);
      final uploadTask = await ref.putFile(file, SettableMetadata());
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw Exception('File upload failed: $e');
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      // final ref = _storage.ref().child(path);
      // await ref.delete();
    } catch (e) {
      throw Exception('File deletion failed: $e');
    }
  }
}
