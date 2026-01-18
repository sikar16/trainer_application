part of 'job_bloc.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final List<JobEntity> jobs;
  final int currentPage;
  final int totalPages;
  final int totalElements;
  final bool hasReachedMax;
  final String? currentStatus;
  final String? searchQuery;
  final bool isLoadingMore;

  const JobLoaded({
    required this.jobs,
    required this.currentPage,
    required this.totalPages,
    required this.totalElements,
    required this.hasReachedMax,
    this.currentStatus,
    this.searchQuery,
    this.isLoadingMore = false,
  });

  JobLoaded copyWith({
    List<JobEntity>? jobs,
    int? currentPage,
    int? totalPages,
    int? totalElements,
    bool? hasReachedMax,
    String? currentStatus,
    String? searchQuery,
    bool? isLoadingMore,
  }) {
    return JobLoaded(
      jobs: jobs ?? this.jobs,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalElements: totalElements ?? this.totalElements,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentStatus: currentStatus ?? this.currentStatus,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [
    jobs,
    currentPage,
    totalPages,
    totalElements,
    hasReachedMax,
    currentStatus ?? '',
    searchQuery ?? '',
    isLoadingMore,
  ];
}

class JobError extends JobState {
  final String message;

  const JobError(this.message);

  @override
  List<Object> get props => [message];
}
