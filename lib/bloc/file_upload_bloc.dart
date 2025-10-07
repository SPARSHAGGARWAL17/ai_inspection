import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:ai_inspection/bloc/file_upload_bloc_events.dart';
import 'package:ai_inspection/bloc/file_upload_bloc_state.dart';
import 'package:ai_inspection/model/file_upload.dart';
import 'package:ai_inspection/model/user_details.dart';
import 'package:ai_inspection/services/firebase_upload_file_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart' as path;

class FileUploadBloc extends Bloc<FileUploadEvent, FileUploadState> {
  late Map<String, FileUploadSection> _sections;
  int _currentSectionIndex = 0;
  final FirebaseUploadFileService _fileService;
  final UserDetails userDetails;

  FileUploadBloc({required FirebaseUploadFileService fileService, required this.userDetails})
    : _fileService = fileService,
      super(FileUploadEmptyState()) {
    on<AddPhotoEvent>(_handleAddPhoto);
    on<RemovePhotoEvent>(_handleRemovePhoto);
    on<PrevPageEvent>(_handlePrevPage);
    on<NextPageEvent>(_handleNextPage);
    on<InitializeFileUpload>(_handleInitialize);
    on<SubmitFiles>(_handleSubmitFiles);
  }

  void _handleSubmitFiles(SubmitFiles event, Emitter<FileUploadState> emit) async {
    int totalFiles = _sections.values.fold(0, (sum, section) => sum + section.photos.length) + 1;
    emit(FileUploadInProgress(currentFile: 0, totalFiles: totalFiles));
    final String jobId = 'job_${Uuid().v4()}-${DateTime.now().millisecondsSinceEpoch}';
    final Uint8List userDetailsFile = await _generateTxtFile(userDetails, jobId);
    try {
      String userDetailsPath = '$jobId/user_details.txt';
      await _fileService.uploadFile(userDetails.name, 'user_details.txt', userDetailsFile);
      emit(FileUploadInProgress(currentFile: 1, totalFiles: totalFiles));
      for (var section in _sections.values) {
        for (var entry in section.photos.entries) {
          String path = '${userDetails.name}/photos/${section.sectionId}';
          await _fileService.uploadFile(path, '${entry.key}.jpg', entry.value);
          emit(
            FileUploadInProgress(
              currentFile: (state is FileUploadInProgress) ? (state as FileUploadInProgress).currentFile + 1 : 1,
              totalFiles: totalFiles,
            ),
          );
        }
      }
    } catch (e) {
      emit(FileUploadFailure('File upload failed: $e'));
      return;
    }
    emit(FileUploadSuccess());
  }

  Future<Uint8List> _generateTxtFile(UserDetails userDetails, String jobId) async {
    // Generate a .txt file with user details and job ID
    String content =
        'Job ID: $jobId\n'
        'Name: ${userDetails.name}\n'
        'Email: ${userDetails.email}\n'
        'Phone: ${userDetails.mobileNo}\n'
        'Address: ${userDetails.streetAddress}\n'
        'City: ${userDetails.city}\n'
        'State: ${userDetails.state}\n'
        'Zip Code: ${userDetails.zipCode}\n';
    // Save this content to a .txt file and upload if needed
    if (kIsWeb) {
      return Uint8List.fromList(utf8.encode(content));
    }
    final directory = await path.getApplicationDocumentsDirectory();
    final file = io.File('${directory.path}/$jobId.txt');
    return await file.writeAsString(content).then((_) async => await file.readAsBytes());
  }

  void _handleInitialize(InitializeFileUpload event, Emitter<FileUploadState> emit) {
    _sections = {for (var sec in event.sections) sec.sectionId: sec..clearPhotos()};
    if (_sections.isNotEmpty) {
      _currentSectionIndex = 0;
      final firstSection = _sections.values.elementAt(_currentSectionIndex);
      emit(FileUploadInitial(section: firstSection, nextSectionAvailable: _sections.length > 1, prevSectionAvailable: false));
    } else {
      emit(FileUploadEmptyState());
    }
  }

  void _handleAddPhoto(AddPhotoEvent event, Emitter<FileUploadState> emit) {
    final FileUploadSection? section = _sections[event.sectionId];
    if (section != null) {
      String photoId = '${section.sectionId}_photo_${section.photos.length + 1}';
      section.uploadPhoto(photoId, event.photo);
      emit(
        FileUploadInitial(
          section: section,
          nextSectionAvailable: _sections.length > 1 && _currentSectionIndex < _sections.length - 1,
          prevSectionAvailable: _currentSectionIndex > 0,
        ),
      );
    }
  }

  void _handleRemovePhoto(RemovePhotoEvent event, Emitter<FileUploadState> emit) {
    final section = _sections[event.sectionId];
    if (section != null) {
      section.removePhoto(event.photoId);
      emit(
        FileUploadInitial(
          section: section,
          nextSectionAvailable: _sections.length > 1 && _currentSectionIndex < _sections.length - 1,
          prevSectionAvailable: _currentSectionIndex > 0,
        ),
      );
    }
  }

  void _handlePrevPage(PrevPageEvent event, Emitter<FileUploadState> emit) {
    _currentSectionIndex = (_currentSectionIndex - 1).clamp(0, _sections.length - 1);
    final section = _sections.values.elementAt(_currentSectionIndex);
    emit(
      FileUploadInitial(
        section: section,
        prevSectionAvailable: _currentSectionIndex > 0,
        nextSectionAvailable: _currentSectionIndex < _sections.length - 1,
      ),
    );
  }

  void _handleNextPage(NextPageEvent event, Emitter<FileUploadState> emit) {
    final currentSection = state is FileUploadInitial ? (state as FileUploadInitial).section : _sections.values.elementAt(_currentSectionIndex);
    // if (currentSection.photos.isEmpty) {
    //   emit(ValidationError('Please add at least one photo to proceed.'));
    //   emit(
    //     FileUploadInitial(
    //       section: currentSection,
    //       nextSectionAvailable: _sections.length > 1 && _currentSectionIndex < _sections.length - 1,
    //       prevSectionAvailable: _currentSectionIndex > 0,
    //     ),
    //   );
    //   return;
    // }
    _currentSectionIndex = (_currentSectionIndex + 1).clamp(0, _sections.length - 1);
    final section = _sections.values.elementAt(_currentSectionIndex);
    emit(
      FileUploadInitial(
        section: section,
        prevSectionAvailable: _currentSectionIndex > 0,
        nextSectionAvailable: _currentSectionIndex < _sections.length - 1,
      ),
    );
  }
}
