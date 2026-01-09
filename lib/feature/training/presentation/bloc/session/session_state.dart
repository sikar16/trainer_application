import '../../../domain/entities/session_entity.dart';

abstract class SessionState {}

class SessionInitial extends SessionState {}

class SessionLoading extends SessionState {}

class SessionLoaded extends SessionState {
  final SessionListEntity sessionList;

  SessionLoaded(this.sessionList);
}

class SessionError extends SessionState {
  final String message;

  SessionError(this.message);
}
