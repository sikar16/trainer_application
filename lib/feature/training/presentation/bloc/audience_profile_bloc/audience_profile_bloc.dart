import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/audience_profile_entity.dart';
import '../../../domain/usecases/get_audience_profile_usecase.dart';

part 'audience_profile_event.dart';
part 'audience_profile_state.dart';

class AudienceProfileBloc
    extends Bloc<AudienceProfileEvent, AudienceProfileState> {
  final GetAudienceProfileUseCase _getAudienceProfileUseCase;

  AudienceProfileBloc(this._getAudienceProfileUseCase)
    : super(AudienceProfileInitial()) {
    on<FetchAudienceProfile>(_onFetchAudienceProfile);
  }

  Future<void> _onFetchAudienceProfile(
    FetchAudienceProfile event,
    Emitter<AudienceProfileState> emit,
  ) async {
    emit(AudienceProfileLoading());
    try {
      final audienceProfile = await _getAudienceProfileUseCase(
        event.trainingId,
      );
      emit(AudienceProfileLoaded(audienceProfile));
    } catch (e) {
      emit(AudienceProfileError(e.toString()));
    }
  }
}
