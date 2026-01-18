part of 'module_detail_bloc.dart';

abstract class ModuleDetailEvent extends Equatable {
  const ModuleDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchModuleDetail extends ModuleDetailEvent {
  final String moduleId;

  const FetchModuleDetail(this.moduleId);

  @override
  List<Object> get props => [moduleId];
}
