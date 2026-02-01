import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/session_report.dart';
import '../../domain/usecases/get_session_report.dart';
import '../../domain/usecases/create_session_report.dart';
import 'session_report_event.dart';
import 'session_report_state.dart';

class SessionReportBloc extends Bloc<SessionReportEvent, SessionReportState> {
  final GetSessionReport getSessionReport;
  final CreateSessionReport createSessionReport;

  SessionReportBloc({
    required this.getSessionReport,
    required this.createSessionReport,
  }) : super(SessionReportInitial()) {
    on<GetSessionReportEvent>(_onGetSessionReport);
    on<CreateSessionReportEvent>(_onCreateSessionReport);
    on<AddFileEvent>(_onAddFile);
    on<RemoveFileEvent>(_onRemoveFile);
    on<UpdateFileTypeEvent>(_onUpdateFileType);
    on<ClearFilesEvent>(_onClearFiles);
  }

  Future<void> _onGetSessionReport(
    GetSessionReportEvent event,
    Emitter<SessionReportState> emit,
  ) async {
    emit(SessionReportLoading());
    try {
      final report = await getSessionReport(event.sessionId);
      if (report != null) {
        emit(SessionReportLoaded(report));
      } else {
        emit(const SessionReportInitial());
      }
    } catch (e) {
      emit(SessionReportError(e.toString()));
    }
  }

  Future<void> _onCreateSessionReport(
    CreateSessionReportEvent event,
    Emitter<SessionReportState> emit,
  ) async {
    emit(SessionReportLoading());
    try {
      final report = await createSessionReport(event.sessionId, event.reportData);
      if (report != null) {
        emit(SessionReportCreated(report));
      } else {
        emit(const SessionReportError('Failed to create session report'));
      }
    } catch (e) {
      emit(SessionReportError(e.toString()));
    }
  }

  void _onAddFile(
    AddFileEvent event,
    Emitter<SessionReportState> emit,
  ) {
    if (state is FilesUpdated) {
      final currentState = state as FilesUpdated;
      final updatedFiles = List<Map<String, String>>.from(currentState.files)
        ..add(event.file);
      emit(FilesUpdated(updatedFiles, currentState.selectedFileType));
    } else {
      emit(FilesUpdated([event.file], null));
    }
  }

  void _onRemoveFile(
    RemoveFileEvent event,
    Emitter<SessionReportState> emit,
  ) {
    if (state is FilesUpdated) {
      final currentState = state as FilesUpdated;
      final updatedFiles = List<Map<String, String>>.from(currentState.files)
        ..removeAt(event.index);
      emit(FilesUpdated(updatedFiles, currentState.selectedFileType));
    }
  }

  void _onUpdateFileType(
    UpdateFileTypeEvent event,
    Emitter<SessionReportState> emit,
  ) {
    if (state is FilesUpdated) {
      final currentState = state as FilesUpdated;
      emit(FilesUpdated(currentState.files, event.fileType));
    } else {
      emit(FilesUpdated([], event.fileType));
    }
  }

  void _onClearFiles(
    ClearFilesEvent event,
    Emitter<SessionReportState> emit,
  ) {
    if (state is FilesUpdated) {
      final currentState = state as FilesUpdated;
      emit(FilesUpdated([], currentState.selectedFileType));
    }
  }
}
