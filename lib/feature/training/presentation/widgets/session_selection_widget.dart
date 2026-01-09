import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/session/session_bloc.dart';
import '../bloc/session/session_event.dart';
import '../bloc/session/session_state.dart';
import '../../domain/entities/session_entity.dart';
import 'common_widgets.dart';
import 'session_info_card_widget.dart';

class SessionSelectionWidget extends StatelessWidget {
  final String? selectedCohortId;
  final String? selectedSessionId;
  final Function(String?) onSessionSelected;
  final Function(List<SessionEntity>) onSessionsLoaded;
  final Function(bool hasSessions)? onSessionsStateChanged;

  const SessionSelectionWidget({
    super.key,
    required this.selectedCohortId,
    required this.selectedSessionId,
    required this.onSessionSelected,
    required this.onSessionsLoaded,
    this.onSessionsStateChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedCohortId == null) return const SizedBox.shrink();

    return BlocListener<SessionBloc, SessionState>(
      listener: (context, state) {
        if (state is SessionLoaded) {
          onSessionsLoaded(state.sessionList.sessions);
          if (onSessionsStateChanged != null) {
            onSessionsStateChanged!(state.sessionList.sessions.isNotEmpty);
          }
        } else if (state is SessionLoading) {
          if (onSessionsStateChanged != null) {
            onSessionsStateChanged!(false);
          }
        } else if (state is SessionError) {
          if (onSessionsStateChanged != null) {
            onSessionsStateChanged!(false);
          }
        }
      },
      child: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          if (state is SessionLoading) {
            return CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sessions"),
                  const SizedBox(height: 12),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is SessionError) {
            return CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sessions"),
                  const SizedBox(height: 12),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      context.read<SessionBloc>().add(
                        GetSessionsByCohortEvent(cohortId: selectedCohortId!),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is SessionLoaded) {
            final sessions = state.sessionList.sessions;
            if (sessions.isEmpty) {
              return CommonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sessions",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No Sessions Available',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No sessions are available in this cohort for attendance tracking. Please add sessions to this cohort first.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                CommonCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Sessions"),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: sessions.map((session) {
                            final isSelected = selectedSessionId == session.id;
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: PillButton(
                                label: session.name,
                                selected: isSelected,
                                onTap: () {
                                  onSessionSelected(
                                    isSelected ? null : session.id,
                                  );
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SessionInfoCardWidget(
                  sessions: sessions,
                  selectedSessionId: selectedSessionId,
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
