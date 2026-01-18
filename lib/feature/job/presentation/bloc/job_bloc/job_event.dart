part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class FetchJobs extends JobEvent {
  final String? status;

  const FetchJobs({this.status});

  @override
  List<Object> get props => [status ?? ''];
}

class LoadMoreJobs extends JobEvent {
  const LoadMoreJobs();
}

class FilterJobsByStatus extends JobEvent {
  final String? status;

  const FilterJobsByStatus(this.status);

  @override
  List<Object> get props => [status ?? ''];
}

class SearchJobs extends JobEvent {
  final String query;

  const SearchJobs(this.query);

  @override
  List<Object> get props => [query];
}
