import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_attendance_by_session_usecase.dart';
import '../../../domain/usecases/save_attendance_usecase.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final GetAttendanceBySessionUseCase getAttendanceBySessionUseCase;
  final SaveAttendanceUseCase saveAttendanceUseCase;

  AttendanceBloc({
    required this.getAttendanceBySessionUseCase,
    required this.saveAttendanceUseCase,
  }) : super(AttendanceInitial()) {
    on<GetAttendanceBySessionEvent>((event, emit) async {
      emit(AttendanceLoading());
      try {
        final attendanceList = await getAttendanceBySessionUseCase(
          event.sessionId,
        );
        emit(AttendanceLoaded(attendanceList));
      } catch (e) {
        emit(AttendanceError(e.toString()));
      }
    });

    on<SaveAttendanceEvent>((event, emit) async {
      emit(AttendanceLoading());
      try {
        await saveAttendanceUseCase.call(
          sessionId: event.sessionId,
          traineeId: event.traineeId,
          isPresent: event.isPresent,
          comment: event.comment,
        );

        final attendanceList = await getAttendanceBySessionUseCase(
          event.sessionId,
        );

        emit(AttendanceLoaded(attendanceList));
      } catch (e) {
        emit(AttendanceError(e.toString()));
      }
    });
  }
}
