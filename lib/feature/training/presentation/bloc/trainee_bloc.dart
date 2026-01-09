import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_trainees_by_cohort_usecase.dart';
import 'trainee_event.dart';
import 'trainee_state.dart';

class TraineeBloc extends Bloc<TraineeEvent, TraineeState> {
  final GetTraineesByCohortUseCase getTraineesByCohortUseCase;

  TraineeBloc({
    required this.getTraineesByCohortUseCase,
  }) : super(TraineeInitial()) {
    on<GetTraineesByCohortEvent>((event, emit) async {
      emit(TraineeLoading());
      try {
        final traineeList = await getTraineesByCohortUseCase(
          cohortId: event.cohortId,
          page: event.page,
          pageSize: event.pageSize,
        );
        emit(TraineeLoaded(traineeList));
      } catch (e) {
        emit(TraineeError(e.toString()));
      }
    });
  }
}
