import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gheero/feature/training/domain/usecases/get_modules_usecase.dart';
import 'module_event.dart';
import 'module_state.dart';

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
