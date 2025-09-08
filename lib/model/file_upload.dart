import 'dart:io';

class FileUploadSection {
  final String sectionId;
  final String sectionName;
  final int maxPhotoAllowed;
  FileUploadSection({required this.sectionId, required this.sectionName, required this.maxPhotoAllowed});

  final Map<String, File> _photos = {};

  Map<String, File> get photos => _photos;

  List<File> get uploadedPhotos => _photos.values.toList();

  bool canUploadMore() {
    return _photos.length < maxPhotoAllowed;
  }

  void uploadPhoto(String id, File photo) {
    if (canUploadMore()) {
      _photos[id] = photo;
    }
  }

  void removePhoto(String id) {
    _photos.remove(id);
  }

  void clearPhotos() {
    _photos.clear();
  }
}
