import 'package:equatable/equatable.dart';

abstract class SessionReportEvent extends Equatable {
  const SessionReportEvent();

  @override
  List<Object?> get props => [];
}

class GetSessionReportEvent extends SessionReportEvent {
  final String sessionId;

  const GetSessionReportEvent(this.sessionId);

  @override
  List<Object?> get props => [sessionId];
}

class CreateSessionReportEvent extends SessionReportEvent {
  final String sessionId;
  final Map<String, dynamic> reportData;

  const CreateSessionReportEvent(this.sessionId, this.reportData);

  @override
  List<Object?> get props => [sessionId, reportData];
}

class AddFileEvent extends SessionReportEvent {
  final Map<String, String> file;

  const AddFileEvent(this.file);

  @override
  List<Object?> get props => [file];
}

class RemoveFileEvent extends SessionReportEvent {
  final int index;

  const RemoveFileEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateFileTypeEvent extends SessionReportEvent {
  final String? fileType;

  const UpdateFileTypeEvent(this.fileType);

  @override
  List<Object?> get props => [fileType];
}

class ClearFilesEvent extends SessionReportEvent {
  const ClearFilesEvent();
}
