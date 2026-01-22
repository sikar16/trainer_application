import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/submit_job_application_usecase.dart';

part 'job_application_event.dart';
part 'job_application_state.dart';

class JobApplicationBloc
    extends Bloc<JobApplicationEvent, JobApplicationState> {
  final SubmitJobApplicationUseCase submitJobApplicationUseCase;

  JobApplicationBloc({required this.submitJobApplicationUseCase})
    : super(JobApplicationInitial()) {
    on<SubmitJobApplication>(_onSubmitJobApplication);
  }

  Future<void> _onSubmitJobApplication(
    SubmitJobApplication event,
    Emitter<JobApplicationState> emit,
  ) async {
    emit(JobApplicationLoading());
    try {
      await submitJobApplicationUseCase.call(
        jobId: event.jobId,
        reason: event.reason,
        applicationType: event.applicationType,
      );
      emit(JobApplicationSuccess());
    } catch (e) {
      emit(JobApplicationFailure(e.toString()));
    }
  }
}
