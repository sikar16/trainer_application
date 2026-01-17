import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/training_profile_entity.dart';
import '../../domain/usecases/get_training_profile_usecase.dart';

part 'training_profile_event.dart';
part 'training_profile_state.dart';

class TrainingProfileBloc
    extends Bloc<TrainingProfileEvent, TrainingProfileState> {
  final GetTrainingProfileUseCase _getTrainingProfileUseCase;

  TrainingProfileBloc(this._getTrainingProfileUseCase)
    : super(TrainingProfileInitial()) {
    on<FetchTrainingProfile>(_onFetchTrainingProfile);
  }

  Future<void> _onFetchTrainingProfile(
    FetchTrainingProfile event,
    Emitter<TrainingProfileState> emit,
  ) async {
    emit(TrainingProfileLoading());
    try {
      final trainingProfile = await _getTrainingProfileUseCase(
        event.trainingId,
      );
      emit(TrainingProfileLoaded(trainingProfile));
    } catch (e) {
      emit(TrainingProfileError(e.toString()));
    }
  }
}
