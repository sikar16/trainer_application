import 'package:flutter/material.dart';
import '../../domain/entities/session_entity.dart';
import 'common_widgets.dart';

class SessionInfoCardWidget extends StatelessWidget {
  final List<SessionEntity> sessions;
  final String? selectedSessionId;

  const SessionInfoCardWidget({
    super.key,
    required this.sessions,
    required this.selectedSessionId,
  });

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) return const SizedBox.shrink();

    SessionEntity selectedSession;
    if (selectedSessionId != null) {
      try {
        selectedSession = sessions.firstWhere(
          (session) => session.id == selectedSessionId,
        );
      } catch (e) {
        selectedSession = sessions.first;
      }
    } else {
      selectedSession = sessions.first;
    }

    return CommonCard(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoColumn(
              title: selectedSession.name,
              subtitle: "Cohort: ${selectedSession.cohort.name}",
            ),
            const SizedBox(width: 32),
            InfoColumn(
              title: "Date",
              subtitle: selectedSession.formattedDate,
              icon: Icons.calendar_today_outlined,
            ),
            const SizedBox(width: 32),
            InfoColumn(
              title: "Time",
              subtitle: selectedSession.formattedTime,
            ),
            const SizedBox(width: 32),
            InfoColumn(
              title: "Location",
              subtitle: selectedSession.trainingVenue?.location ??
                  selectedSession.trainingVenue?.name ??
                  "N/A",
            ),
          ],
        ),
      ),
    );
  }
}
