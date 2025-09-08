import 'dart:io';

import 'package:ai_inspection/bloc/usecase/usecase.i.dart';
import 'package:ai_inspection/services/firebase_upload_file_service.dart';

class UploadFileUseCase implements UseCase<void, UploadFileParams> {
  final FirebaseUploadFileService fileService;

  UploadFileUseCase({required this.fileService});

  @override
  Future<void> execute(UploadFileParams params) async {
    // await fileService.uploadFile(params.path, params.file);
    return;
  }
}

class UploadFileParams {
  final String jobId;
  final File file;
  final String path;

  UploadFileParams({required this.jobId, required this.file, required this.path});
}
