import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_trainings_usecase.dart';
import 'training_event.dart';
import 'training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  final GetTrainingsUseCase getTrainingsUseCase;

  TrainingBloc({required this.getTrainingsUseCase}) : super(TrainingInitial()) {
    on<GetTrainingsEvent>((event, emit) async {
      emit(TrainingLoading());
      try {
        final trainingList = await getTrainingsUseCase(
          page: event.page,
          pageSize: event.pageSize,
        );
        emit(TrainingLoaded(trainingList));
      } catch (e) {
        emit(TrainingError(e.toString()));
      }
    });
  }
}
