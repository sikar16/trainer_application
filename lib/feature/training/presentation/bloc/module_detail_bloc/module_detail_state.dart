part of 'module_detail_bloc.dart';

abstract class ModuleDetailState extends Equatable {
  const ModuleDetailState();

  @override
  List<Object> get props => [];
}

class ModuleDetailInitial extends ModuleDetailState {}

class ModuleDetailLoading extends ModuleDetailState {}

class ModuleDetailLoaded extends ModuleDetailState {
  final ModuleProfileEntity moduleProfile;
  final ModuleAssessmentMethodsEntity assessmentMethods;

  const ModuleDetailLoaded(this.moduleProfile, this.assessmentMethods);

  @override
  List<Object> get props => [moduleProfile, assessmentMethods];
}

class ModuleDetailError extends ModuleDetailState {
  final String message;

  const ModuleDetailError(this.message);

  @override
  List<Object> get props => [message];
}
