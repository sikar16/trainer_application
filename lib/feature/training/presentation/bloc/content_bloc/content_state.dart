import 'package:equatable/equatable.dart';
import '../../../domain/entities/content_entity.dart';

abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object> get props => [];
}

class ContentInitial extends ContentState {}

class ContentLoading extends ContentState {}

class ContentLoaded extends ContentState {
  final ContentResponseEntity contentResponse;

  const ContentLoaded(this.contentResponse);

  @override
  List<Object> get props => [contentResponse];
}

class ContentError extends ContentState {
  final String message;

  const ContentError(this.message);

  @override
  List<Object> get props => [message];
}
