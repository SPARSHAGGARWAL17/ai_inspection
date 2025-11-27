import 'package:ai_inspection/bloc/generate_report/generate_report_event.dart';
import 'package:ai_inspection/bloc/generate_report/generate_report_state.dart';
import 'package:ai_inspection/services/api_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateReportBloc extends Bloc<GenerateReportEvent, GenerateReportState> {
  GenerateReportBloc() : super(InitialGenerateReportState()) {
    on<GenerateReportRequested>((event, emit) async {
      emit(GenerateReportInProgress());
      try {
        final success = await ApiServices().generateReport();
        if (success) {
          emit(GenerateReportSuccess());
        } else {
          emit(GenerateReportFailure());
        }
      } catch (e) {
        emit(GenerateReportFailure());
      }
    });
  }
}
