import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/job_entity.dart';
import '../../../domain/usecases/get_jobs_usecase.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final GetJobsUseCase _getJobsUseCase;

  JobBloc(this._getJobsUseCase) : super(JobInitial()) {
    on<FetchJobs>(_onFetchJobs);
    on<LoadMoreJobs>(_onLoadMoreJobs);
    on<FilterJobsByStatus>(_onFilterJobsByStatus);
    on<SearchJobs>(_onSearchJobs);
  }

  Future<void> _onFetchJobs(FetchJobs event, Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      final jobResponse = await _getJobsUseCase.call(
        page: 1,
        pageSize: 10,
        status: event.status,
      );
      emit(
        JobLoaded(
          jobs: jobResponse.jobs,
          currentPage: 1,
          totalPages: jobResponse.totalPages,
          totalElements: jobResponse.totalElements,
          hasReachedMax: jobResponse.jobs.length >= jobResponse.totalElements,
          currentStatus: event.status,
        ),
      );
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }

  Future<void> _onLoadMoreJobs(
    LoadMoreJobs event,
    Emitter<JobState> emit,
  ) async {
    if (state is JobLoaded && !(state as JobLoaded).hasReachedMax) {
      final currentState = state as JobLoaded;
      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final jobResponse = await _getJobsUseCase.call(
          page: currentState.currentPage + 1,
          pageSize: 10,
          status: currentState.currentStatus,
        );

        final updatedJobs = List<JobEntity>.from(currentState.jobs)
          ..addAll(jobResponse.jobs);

        emit(
          JobLoaded(
            jobs: updatedJobs,
            currentPage: currentState.currentPage + 1,
            totalPages: jobResponse.totalPages,
            totalElements: jobResponse.totalElements,
            hasReachedMax: updatedJobs.length >= jobResponse.totalElements,
            currentStatus: currentState.currentStatus,
          ),
        );
      } catch (e) {
        emit(JobError(e.toString()));
      }
    }
  }

  Future<void> _onFilterJobsByStatus(
    FilterJobsByStatus event,
    Emitter<JobState> emit,
  ) async {
    emit(JobLoading());
    try {
      final jobResponse = await _getJobsUseCase.call(
        page: 1,
        pageSize: 10,
        status: event.status,
      );
      emit(
        JobLoaded(
          jobs: jobResponse.jobs,
          currentPage: 1,
          totalPages: jobResponse.totalPages,
          totalElements: jobResponse.totalElements,
          hasReachedMax: jobResponse.jobs.length >= jobResponse.totalElements,
          currentStatus: event.status,
        ),
      );
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }

  Future<void> _onSearchJobs(SearchJobs event, Emitter<JobState> emit) async {
    emit(JobLoading());
    try {
      final jobResponse = await _getJobsUseCase.call(
        page: 1,
        pageSize: 10,
        search: event.query,
      );
      emit(
        JobLoaded(
          jobs: jobResponse.jobs,
          currentPage: 1,
          totalPages: jobResponse.totalPages,
          totalElements: jobResponse.totalElements,
          hasReachedMax: jobResponse.jobs.length >= jobResponse.totalElements,
          searchQuery: event.query,
        ),
      );
    } catch (e) {
      emit(JobError(e.toString()));
    }
  }
}
