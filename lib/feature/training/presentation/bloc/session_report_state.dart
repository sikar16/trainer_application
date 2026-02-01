import 'package:equatable/equatable.dart';
import '../../domain/entities/session_report.dart';

abstract class SessionReportState extends Equatable {
  const SessionReportState();

  @override
  List<Object?> get props => [];
}

class SessionReportInitial extends SessionReportState {
  const SessionReportInitial();
}

class SessionReportLoading extends SessionReportState {
  const SessionReportLoading();
}

class SessionReportLoaded extends SessionReportState {
  final SessionReport report;

  const SessionReportLoaded(this.report);

  @override
  List<Object?> get props => [report];
}

class SessionReportCreated extends SessionReportState {
  final SessionReport report;

  const SessionReportCreated(this.report);

  @override
  List<Object?> get props => [report];
}

class SessionReportError extends SessionReportState {
  final String message;

  const SessionReportError(this.message);

  @override
  List<Object?> get props => [message];
}

class FilesUpdated extends SessionReportState {
  final List<Map<String, String>> files;
  final String? selectedFileType;

  const FilesUpdated(this.files, this.selectedFileType);

  @override
  List<Object?> get props => [files, selectedFileType];
}
