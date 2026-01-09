import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_sessions_by_cohort_usecase.dart';
import 'session_event.dart';
import 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final GetSessionsByCohortUseCase getSessionsByCohortUseCase;

  SessionBloc({required this.getSessionsByCohortUseCase})
    : super(SessionInitial()) {
    on<GetSessionsByCohortEvent>((event, emit) async {
      emit(SessionLoading());
      try {
        final sessionList = await getSessionsByCohortUseCase(
          cohortId: event.cohortId,
          page: event.page,
          pageSize: event.pageSize,
        );
        emit(SessionLoaded(sessionList));
      } catch (e) {
        emit(SessionError(e.toString()));
      }
    });
  }
}
