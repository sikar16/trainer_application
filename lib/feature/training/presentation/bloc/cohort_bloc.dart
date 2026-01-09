import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_cohorts_usecase.dart';
import 'cohort_event.dart';
import 'cohort_state.dart';

class CohortBloc extends Bloc<CohortEvent, CohortState> {
  final GetCohortsUseCase getCohortsUseCase;

  CohortBloc({
    required this.getCohortsUseCase,
  }) : super(CohortInitial()) {
    on<GetCohortsEvent>((event, emit) async {
      emit(CohortLoading());
      try {
        final cohortList = await getCohortsUseCase(
          trainingId: event.trainingId,
          page: event.page,
          pageSize: event.pageSize,
        );
        emit(CohortLoaded(cohortList));
      } catch (e) {
        emit(CohortError(e.toString()));
      }
    });
  }
}
