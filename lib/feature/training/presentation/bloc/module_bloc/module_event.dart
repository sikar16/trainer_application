import 'package:equatable/equatable.dart';

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
