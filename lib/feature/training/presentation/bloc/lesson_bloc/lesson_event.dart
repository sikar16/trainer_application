import 'package:equatable/equatable.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object> get props => [];
}

class FetchLessons extends LessonEvent {
  final String moduleId;

  const FetchLessons(this.moduleId);

  @override
  List<Object> get props => [moduleId];
}
