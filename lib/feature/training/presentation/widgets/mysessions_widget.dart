import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/session_bloc/session_bloc.dart';
import '../bloc/session_bloc/session_state.dart';
import 'sessions_list_widget.dart';
import 'attendance_page_widget.dart';

class MysessionsWidget extends StatefulWidget {
  final String trainingId;

  const MysessionsWidget({super.key, required this.trainingId});

  @override
  State<MysessionsWidget> createState() => _MysessionsWidgetState();
}

class _MysessionsWidgetState extends State<MysessionsWidget> {
  @override
  Widget build(BuildContext context) {
    return SessionsListWidget(
      trainingId: widget.trainingId,
      onSessionSelected: (sessionId) {
        final sessionState = context.read<SessionBloc>().state;
        if (sessionState is SessionLoaded) {
          final session = sessionState.sessionList.sessions
              .where((s) => s.id == sessionId)
              .firstOrNull;

          if (session != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AttendancePageWidget(
                  session: session,
                  trainingId: widget.trainingId,
                ),
              ),
            );
          }
        }
      },
    );
  }
}
