abstract class GenerateReportState {}

class InitialGenerateReportState extends GenerateReportState {}

class GenerateReportInProgress extends GenerateReportState {}

class GenerateReportSuccess extends GenerateReportState {}

class GenerateReportFailure extends GenerateReportState {}