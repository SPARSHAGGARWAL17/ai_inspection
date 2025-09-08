import 'dart:io';

class FirebaseUploadFileService {
  // final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(String path, File file) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return '';
      // final ref = _storage.ref().child(path);
      // final uploadTask = await ref.putFile(file);
      // return await uploadTask.ref.getDownloadURL();
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
