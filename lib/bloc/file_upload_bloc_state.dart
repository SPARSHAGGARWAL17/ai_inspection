import 'package:ai_inspection/model/file_upload.dart';

abstract class FileUploadState {
  FileUploadState copyWith(FileUploadState currentState) {
    return currentState;
  }
}

class FileUploadEmptyState extends FileUploadState {}

class FileUploadInitial extends FileUploadState {
  final FileUploadSection section;
  bool prevSectionAvailable = false;
  bool nextSectionAvailable = false;
  FileUploadInitial({required this.section, this.nextSectionAvailable = false, this.prevSectionAvailable = false});

  @override
  FileUploadState copyWith(FileUploadState currentState) {
    if (currentState is FileUploadInitial) {
      return FileUploadInitial(
        section: currentState.section,
        nextSectionAvailable: currentState.nextSectionAvailable,
        prevSectionAvailable: currentState.prevSectionAvailable,
      );
    }
    return this;
  }
}

class FileUploadInProgress extends FileUploadState {}

class FileUploadSuccess extends FileUploadState {}

class FileUploadFailure extends FileUploadState {
  final String error;

  FileUploadFailure(this.error);
}
