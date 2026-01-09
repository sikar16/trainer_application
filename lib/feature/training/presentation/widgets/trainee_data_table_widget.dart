import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/trainee_bloc.dart';
import '../bloc/trainee_event.dart';
import '../bloc/trainee_state.dart';
import '../bloc/session_bloc.dart';
import '../bloc/session_state.dart';
import '../../domain/entities/trainee_entity.dart';
import 'common_widgets.dart';
import 'attendance_chip_widget.dart';

class TraineeDataTableWidget extends StatelessWidget {
  final String? selectedCohortId;
  final String? selectedSessionId;
  final String searchQuery;
  final Function(TraineeEntity) onUploadID;

  const TraineeDataTableWidget({
    super.key,
    required this.selectedCohortId,
    required this.selectedSessionId,
    required this.searchQuery,
    required this.onUploadID,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedCohortId == null) return const SizedBox.shrink();

    return BlocBuilder<TraineeBloc, TraineeState>(
      builder: (context, state) {
        if (state is TraineeLoading) {
          return CommonCard(
            padding: EdgeInsets.zero,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (state is TraineeError) {
          return CommonCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {
                    context.read<TraineeBloc>().add(
                          GetTraineesByCohortEvent(
                            cohortId: selectedCohortId!,
                          ),
                        );
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is TraineeLoaded) {
          final trainees = state.traineeList.trainees;
          String? sessionDate;
          // Get session date from SessionBloc state
          final sessionState = context.read<SessionBloc>().state;
          if (sessionState is SessionLoaded) {
            try {
              final selectedSession = sessionState.sessionList.sessions
                  .firstWhere((s) => s.id == selectedSessionId);
              sessionDate = selectedSession.formattedDate;
            } catch (e) {
              if (sessionState.sessionList.sessions.isNotEmpty) {
                sessionDate = sessionState.sessionList.sessions.first.formattedDate;
              }
            }
          }

          if (trainees.isEmpty) {
            return CommonCard(
              padding: const EdgeInsets.all(20),
              child: const Text('No trainees available'),
            );
          }

          return CommonCard(
            padding: EdgeInsets.zero,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Checkbox(value: false, onChanged: null),
                  ),
                  DataColumn(label: Text("Full Name")),
                  DataColumn(label: Text("Phone Number")),
                  DataColumn(label: Text("Date")),
                  DataColumn(label: Text("Attendance")),
                  DataColumn(label: Text("ID & Consent Form")),
                ],
                rows: trainees
                    .where((trainee) {
                      if (searchQuery.isEmpty) return true;
                      return trainee.fullName.toLowerCase().contains(
                            searchQuery,
                          ) ||
                          trainee.contactPhone.contains(searchQuery);
                    })
                    .map((trainee) {
                      return DataRow(
                        cells: [
                          const DataCell(
                            Checkbox(value: false, onChanged: null),
                          ),
                          DataCell(Text(trainee.fullName)),
                          DataCell(Text(trainee.contactPhone)),
                          DataCell(Text(sessionDate ?? 'N/A')),
                          const DataCell(AttendanceChipWidget()),
                          DataCell(
                            OutlinedButton.icon(
                              onPressed: () => onUploadID(trainee),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: const Color.fromARGB(
                                      255,
                                      255,
                                      255,
                                      255,
                                    ),
                                  ),
                                ),
                                backgroundColor: const Color(0xFFE7F9EE),
                                foregroundColor: const Color(0xFF137333),
                              ),
                              icon: const Icon(Icons.badge_outlined),
                              label: const Text("Add ID & Consent"),
                            ),
                          ),
                        ],
                      );
                    })
                    .toList(),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
