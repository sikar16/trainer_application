import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gheero/feature/training/domain/entities/module_detail_entity.dart';
import 'package:gheero/feature/training/domain/usecases/get_module_detail_usecase.dart';
import 'package:gheero/feature/training/domain/usecases/get_module_assessment_methods_usecase.dart';

part 'module_detail_event.dart';
part 'module_detail_state.dart';

class ModuleDetailBloc extends Bloc<ModuleDetailEvent, ModuleDetailState> {
  final GetModuleDetailUseCase _getModuleDetailUseCase;
  final GetModuleAssessmentMethodsUseCase _getModuleAssessmentMethodsUseCase;

  ModuleDetailBloc(
    this._getModuleDetailUseCase,
    this._getModuleAssessmentMethodsUseCase,
  ) : super(ModuleDetailInitial()) {
    on<FetchModuleDetail>(_onFetchModuleDetail);
  }

  Future<void> _onFetchModuleDetail(
    FetchModuleDetail event,
    Emitter<ModuleDetailState> emit,
  ) async {
    emit(ModuleDetailLoading());
    try {
      final moduleProfile = await _getModuleDetailUseCase(event.moduleId);
      final assessmentMethods = await _getModuleAssessmentMethodsUseCase(
        event.moduleId,
      );
      emit(ModuleDetailLoaded(moduleProfile, assessmentMethods));
    } catch (e) {
      emit(ModuleDetailError(e.toString()));
    }
  }
}
