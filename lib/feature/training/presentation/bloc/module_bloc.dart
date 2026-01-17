import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/module_entity.dart';
import '../../domain/usecases/get_modules_usecase.dart';

// Events
abstract class ModuleEvent extends Equatable {
  const ModuleEvent();

  @override
  List<Object> get props => [];
}

class FetchModules extends ModuleEvent {
  final String trainingId;

  const FetchModules(this.trainingId);

  @override
  List<Object> get props => [trainingId];
}

// States
abstract class ModuleState extends Equatable {
  const ModuleState();

  @override
  List<Object> get props => [];
}

class ModuleInitial extends ModuleState {}

class ModuleLoading extends ModuleState {}

class ModuleLoaded extends ModuleState {
  final List<ModuleEntity> modules;

  const ModuleLoaded(this.modules);

  @override
  List<Object> get props => [modules];
}

class ModuleError extends ModuleState {
  final String message;

  const ModuleError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final GetModulesUseCase _getModulesUseCase;

  ModuleBloc(this._getModulesUseCase) : super(ModuleInitial()) {
    on<FetchModules>(_onFetchModules);
  }

  Future<void> _onFetchModules(
    FetchModules event,
    Emitter<ModuleState> emit,
  ) async {
    emit(ModuleLoading());
    try {
      final moduleResponse = await _getModulesUseCase.call(event.trainingId);
      emit(ModuleLoaded(moduleResponse.modules));
    } catch (e) {
      emit(ModuleError(e.toString()));
    }
  }
}
