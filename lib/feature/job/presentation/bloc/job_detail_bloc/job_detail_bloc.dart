import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/job_detail_entity.dart';
import '../../../domain/usecases/get_job_detail_usecase.dart';

part 'job_detail_event.dart';
part 'job_detail_state.dart';

class JobDetailBloc extends Bloc<JobDetailEvent, JobDetailState> {
  final GetJobDetailUseCase _getJobDetailUseCase;

  JobDetailBloc(this._getJobDetailUseCase) : super(JobDetailInitial()) {
    on<FetchJobDetail>(_onFetchJobDetail);
  }

  Future<void> _onFetchJobDetail(
    FetchJobDetail event,
    Emitter<JobDetailState> emit,
  ) async {
    emit(JobDetailLoading());
    try {
      final jobDetail = await _getJobDetailUseCase.call(event.jobId);
      emit(JobDetailLoaded(jobDetail));
    } catch (e) {
      emit(JobDetailError(e.toString()));
    }
  }
}
