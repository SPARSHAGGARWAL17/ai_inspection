import 'package:ai_inspection/bloc/file_upload_bloc_events.dart';
import 'package:ai_inspection/bloc/file_upload_bloc_state.dart';
import 'package:ai_inspection/model/file_upload.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FileUploadBloc extends Bloc<FileUploadEvent, FileUploadState> {
  late Map<String, FileUploadSection> _sections;
  int _currentSectionIndex = 0;

  FileUploadBloc() : super(FileUploadEmptyState()) {
    on<AddPhotoEvent>(_handleAddPhoto);
    on<RemovePhotoEvent>(_handleRemovePhoto);
    on<PrevPageEvent>(_handlePrevPage);
    on<NextPageEvent>(_handleNextPage);
    on<InitializeFileUpload>(_handleInitialize);
    on<SubmitFiles>(_handleSubmitFiles);
  }

  void _handleSubmitFiles(SubmitFiles event, Emitter<FileUploadState> emit) async {
    emit(FileUploadInProgress());
    await Future.delayed(const Duration(seconds: 2));
    emit(FileUploadSuccess());
  }

  void _handleInitialize(InitializeFileUpload event, Emitter<FileUploadState> emit) {
    _sections = {for (var sec in event.sections) sec.sectionId: sec};
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
