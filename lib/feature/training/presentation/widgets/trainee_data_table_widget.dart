import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/trainee_bloc/trainee_bloc.dart';
import '../bloc/trainee_bloc/trainee_state.dart';
import '../bloc/session_bloc/session_bloc.dart';
import '../bloc/session_bloc/session_state.dart';
import '../bloc/attendance_bloc/attendance_bloc.dart';
import '../bloc/attendance_bloc/attendance_event.dart';
import '../bloc/attendance_bloc/attendance_state.dart';
import '../../domain/entities/trainee_entity.dart';
import 'common_widgets.dart';
import 'attendance_chip_widget.dart';

class TraineeDataTableWidget extends StatefulWidget {
  final String? selectedCohortId;
  final String? selectedSessionId;
  final String searchQuery;
  final Function(TraineeEntity) onUploadID;
  final Function(String traineeId, bool isPresent) onAttendanceChanged;

  const TraineeDataTableWidget({
    super.key,
    required this.selectedCohortId,
    required this.selectedSessionId,
    required this.searchQuery,
    required this.onUploadID,
    required this.onAttendanceChanged,
  });

  @override
  State<TraineeDataTableWidget> createState() => _TraineeDataTableWidgetState();
}

class _TraineeDataTableWidgetState extends State<TraineeDataTableWidget> {
  String? _lastSessionId;

  @override
  void didUpdateWidget(TraineeDataTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedSessionId != null &&
        widget.selectedSessionId != _lastSessionId) {
      _lastSessionId = widget.selectedSessionId;
      context.read<AttendanceBloc>().add(
        GetAttendanceBySessionEvent(widget.selectedSessionId!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (widget.selectedCohortId == null || widget.selectedSessionId == null) {
      return const SizedBox.shrink();
    }

    if (_lastSessionId != widget.selectedSessionId) {
      _lastSessionId = widget.selectedSessionId;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AttendanceBloc>().add(
          GetAttendanceBySessionEvent(widget.selectedSessionId!),
        );
      });
    }

    return BlocBuilder<TraineeBloc, TraineeState>(
      builder: (context, traineeState) {
        if (traineeState is TraineeLoading) {
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

        if (traineeState is TraineeLoaded) {
          final trainees = traineeState.traineeList.trainees;
          String? sessionDate;
          final sessionState = context.read<SessionBloc>().state;
          if (sessionState is SessionLoaded) {
            try {
              final selectedSession = sessionState.sessionList.sessions
                  .firstWhere((s) => s.id == widget.selectedSessionId);
              sessionDate = selectedSession.formattedDate;
            } catch (e) {
              if (sessionState.sessionList.sessions.isNotEmpty) {
                sessionDate =
                    sessionState.sessionList.sessions.first.formattedDate;
              }
            }
          }

          if (trainees.isEmpty) {
            return CommonCard(
              padding: const EdgeInsets.all(20),
              child: const Text('No trainees available'),
            );
          }

          return BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, attendanceState) {
              Map<String, bool> attendanceMap = {};
              if (attendanceState is AttendanceLoaded) {
                for (var attendance
                    in attendanceState.attendanceList.attendance) {
                  attendanceMap[attendance.trainee.id] = attendance.isPresent;
                }
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
                          if (widget.searchQuery.isEmpty) return true;
                          return trainee.fullName.toLowerCase().contains(
                                widget.searchQuery,
                              ) ||
                              trainee.contactPhone.contains(widget.searchQuery);
                        })
                        .map((trainee) {
                          final initialIsPresent =
                              attendanceMap[trainee.id] ?? true;
                          return DataRow(
                            cells: [
                              const DataCell(
                                Checkbox(value: false, onChanged: null),
                              ),
                              DataCell(Text(trainee.fullName)),
                              DataCell(Text(trainee.contactPhone)),
                              DataCell(Text(sessionDate ?? 'N/A')),
                              DataCell(
                                AttendanceChipWidget(
                                  initialIsPresent: initialIsPresent,
                                  onChanged: (isPresent) {
                                    widget.onAttendanceChanged(
                                      trainee.id,
                                      isPresent,
                                    );
                                  },
                                ),
                              ),
                              DataCell(
                                OutlinedButton.icon(
                                  onPressed: () => widget.onUploadID(trainee),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                        color: colorScheme.surface,
                                      ),
                                    ),
                                    backgroundColor:
                                        colorScheme.primaryContainer,
                                    foregroundColor:
                                        colorScheme.onPrimaryContainer,
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
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
