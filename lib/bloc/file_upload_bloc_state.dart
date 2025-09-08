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

class ValidationError extends FileUploadState {
  final String error;

  ValidationError(this.error);
}

class FileUploadInProgress extends FileUploadState {
  final int currentFile;
  final int totalFiles;
  FileUploadInProgress({this.currentFile = 0, this.totalFiles = 0});
}

class FileUploadSuccess extends FileUploadState {}

class FileUploadFailure extends FileUploadState {
  final String error;

  FileUploadFailure(this.error);
}
