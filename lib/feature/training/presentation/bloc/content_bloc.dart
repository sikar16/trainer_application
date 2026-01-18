import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/content_entity.dart';
import '../../domain/usecases/get_content_usecase.dart';

// Events
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

// States
abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object> get props => [];
}

class ContentInitial extends ContentState {}

class ContentLoading extends ContentState {}

class ContentLoaded extends ContentState {
  final ContentResponseEntity contentResponse;

  const ContentLoaded(this.contentResponse);

  @override
  List<Object> get props => [contentResponse];
}

class ContentError extends ContentState {
  final String message;

  const ContentError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final GetContentUseCase _getContentUseCase;

  ContentBloc(this._getContentUseCase) : super(ContentInitial()) {
    on<FetchContent>(_onFetchContent);
    on<SearchContent>(_onSearchContent);
  }

  Future<void> _onFetchContent(
    FetchContent event,
    Emitter<ContentState> emit,
  ) async {
    emit(ContentLoading());
    try {
      final contentResponse = await _getContentUseCase(
        trainingId: event.trainingId,
        page: event.page,
        pageSize: event.pageSize,
        searchQuery: event.searchQuery,
      );
      emit(ContentLoaded(contentResponse));
    } catch (e) {
      emit(ContentError(e.toString()));
    }
  }

  Future<void> _onSearchContent(
    SearchContent event,
    Emitter<ContentState> emit,
  ) async {
    emit(ContentLoading());
    try {
      final contentResponse = await _getContentUseCase(
        trainingId: event.trainingId,
        page: 1,
        pageSize: 10,
        searchQuery: event.searchQuery,
      );
      emit(ContentLoaded(contentResponse));
    } catch (e) {
      emit(ContentError(e.toString()));
    }
  }
}
