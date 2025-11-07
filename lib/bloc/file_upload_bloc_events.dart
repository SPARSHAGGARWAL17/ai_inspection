// Events

import 'dart:typed_data';

import 'package:ai_inspection/model/file_upload.dart';

abstract class FileUploadEvent {}

class InitializeFileUpload extends FileUploadEvent {
  final List<FileUploadSection> sections;

  InitializeFileUpload(this.sections);
}

class AddPhotoEvent extends FileUploadEvent {
  final String sectionId;
  final Uint8List photo;

  AddPhotoEvent(this.sectionId, this.photo);
}

class RemovePhotoEvent extends FileUploadEvent {
  final String sectionId;
  final String photoId;

  RemovePhotoEvent(this.sectionId, this.photoId);
}

class SubmitFiles extends FileUploadEvent {
  final String note;
  SubmitFiles({required this.note});
}

class PrevPageEvent extends FileUploadEvent {}

class NextPageEvent extends FileUploadEvent {}
