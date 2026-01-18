import 'package:equatable/equatable.dart';

abstract class ContentEvent extends Equatable {
  const ContentEvent();

  @override
  List<Object> get props => [];
}

class FetchContent extends ContentEvent {
  final String trainingId;
  final int page;
  final int pageSize;
  final String? searchQuery;

  const FetchContent({
    required this.trainingId,
    this.page = 1,
    this.pageSize = 10,
    this.searchQuery,
  });

  @override
  List<Object> get props => [trainingId, page, pageSize, searchQuery ?? ''];
}

class SearchContent extends ContentEvent {
  final String trainingId;
  final String searchQuery;

  const SearchContent({required this.trainingId, required this.searchQuery});

  @override
  List<Object> get props => [trainingId, searchQuery];
}
