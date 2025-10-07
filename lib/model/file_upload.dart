import 'dart:typed_data';

class FileUploadSection {
  final String sectionId;
  final String sectionName;
  final int maxPhotoAllowed;
  FileUploadSection({required this.sectionId, required this.sectionName, required this.maxPhotoAllowed});

  final Map<String, Uint8List> _photos = {};

  Map<String, Uint8List> get photos => _photos;

  List<Uint8List> get uploadedPhotos => _photos.values.toList();

  bool canUploadMore() {
    return _photos.length < maxPhotoAllowed;
  }

  void uploadPhoto(String id, Uint8List photo) {
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
