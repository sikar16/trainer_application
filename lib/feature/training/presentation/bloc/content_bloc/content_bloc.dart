import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_content_usecase.dart';
import 'content_event.dart';
import 'content_state.dart';

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
