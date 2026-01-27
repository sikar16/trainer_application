import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/feature/training/presentation/widgets/view_report_widget.dart';
import '../bloc/cohort_bloc/cohort_bloc.dart';
import '../bloc/cohort_bloc/cohort_event.dart';
import '../bloc/session_bloc/session_bloc.dart';
import '../bloc/session_bloc/session_event.dart';
import '../bloc/trainee_bloc/trainee_bloc.dart';
import '../bloc/trainee_bloc/trainee_event.dart';
import '../bloc/attendance_bloc/attendance_bloc.dart';
import '../bloc/attendance_bloc/attendance_event.dart';
import '../bloc/attendance_bloc/attendance_state.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/trainee_entity.dart';
import 'cohort_selection_widget.dart';
import 'session_selection_widget.dart';
import 'trainee_data_table_widget.dart';
import 'upload_id_dialog_widget.dart';

class MysessionsWidget extends StatefulWidget {
  final String trainingId;

  const MysessionsWidget({super.key, required this.trainingId});

  @override
  State<MysessionsWidget> createState() => _MysessionsWidgetState();
}

class _MysessionsWidgetState extends State<MysessionsWidget> {
  String? _selectedCohortId;
  String? _selectedSessionId;
  String _searchQuery = '';
  bool _hasSessions = false;
  final Map<String, bool> _attendanceChanges = {};
  Map<String, bool> _initialAttendance = {};
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    context.read<CohortBloc>().add(
      GetCohortsEvent(trainingId: widget.trainingId),
    );
  }

  void _onCohortSelected(String? cohortId) {
    setState(() {
      _selectedCohortId = cohortId;
      _selectedSessionId = null;
    });
    if (cohortId != null) {
      context.read<SessionBloc>().add(
        GetSessionsByCohortEvent(cohortId: cohortId),
      );
      context.read<TraineeBloc>().add(
        GetTraineesByCohortEvent(cohortId: cohortId),
      );
    }
  }

  void _onSessionsLoaded(List<SessionEntity> sessions) {
    if (_selectedSessionId == null && sessions.isNotEmpty) {
      setState(() {
        _selectedSessionId = sessions.first.id;
        _attendanceChanges.clear();
        _initialAttendance.clear();
        _hasUnsavedChanges = false;
      });
      context.read<AttendanceBloc>().add(
        GetAttendanceBySessionEvent(sessions.first.id),
      );
    }
  }

  void _onSessionSelected(String? sessionId) {
    setState(() {
      _selectedSessionId = sessionId;
      _attendanceChanges.clear();
      _initialAttendance.clear();
      _hasUnsavedChanges = false;
    });
    if (sessionId != null) {
      context.read<AttendanceBloc>().add(
        GetAttendanceBySessionEvent(sessionId),
      );
    }
  }

  void _onAttendanceChanged(String traineeId, bool isPresent) {
    setState(() {
      _attendanceChanges[traineeId] = isPresent;
      _hasUnsavedChanges = _attendanceChanges.entries.any(
        (entry) => entry.value != (_initialAttendance[entry.key] ?? true),
      );
    });
  }

  void _onAttendanceLoaded(Map<String, bool> attendanceMap) {
    setState(() {
      _initialAttendance = Map<String, bool>.from(attendanceMap);
      _attendanceChanges.clear();
      _hasUnsavedChanges = false;
    });
  }

  Future<void> _saveAttendance() async {
    if (!_hasUnsavedChanges || _selectedSessionId == null) return;

    final attendanceBloc = context.read<AttendanceBloc>();
    for (var entry in _attendanceChanges.entries) {
      attendanceBloc.add(
        SaveAttendanceEvent(
          sessionId: _selectedSessionId!,
          traineeId: entry.key,
          isPresent: entry.value,
        ),
      );
    }

    await Future.delayed(const Duration(milliseconds: 500));

    attendanceBloc.add(GetAttendanceBySessionEvent(_selectedSessionId!));

    setState(() {
      _attendanceChanges.clear();
      _hasUnsavedChanges = false;
    });

    if (_selectedSessionId != null) {
      context.read<AttendanceBloc>().add(
        GetAttendanceBySessionEvent(_selectedSessionId!),
      );
    }
  }

  void _showUploadIDDialog(BuildContext context, TraineeEntity trainee) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return UploadIDDialogWidget(trainee: trainee);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Attendance",
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            CohortSelectionWidget(
              trainingId: widget.trainingId,
              selectedCohortId: _selectedCohortId,
              onCohortSelected: _onCohortSelected,
            ),

            const SizedBox(height: 20),

            SessionSelectionWidget(
              selectedCohortId: _selectedCohortId,
              selectedSessionId: _selectedSessionId,
              onSessionSelected: _onSessionSelected,
              onSessionsLoaded: _onSessionsLoaded,
              onSessionsStateChanged: (hasSessions) {
                setState(() {
                  _hasSessions = hasSessions;
                });
              },
            ),

            if (_hasSessions) ...[
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: _selectedSessionId != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ViewReportPage(
                                sessionId: _selectedSessionId!,
                              ),
                            ),
                          );
                        }
                      : null,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text("View Report"),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: colorScheme.surface),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    BlocListener<AttendanceBloc, AttendanceState>(
                      listener: (context, state) {},
                      child: ElevatedButton(
                        onPressed: _hasUnsavedChanges ? _saveAttendance : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          backgroundColor: _hasUnsavedChanges
                              ? colorScheme.primary
                              : colorScheme.surfaceContainerHighest,
                          foregroundColor: _hasUnsavedChanges
                              ? colorScheme.onPrimary
                              : colorScheme.onSurfaceVariant,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: SizedBox(
                          child: Text(
                            "Save Attendance",
                            style: textTheme.labelLarge?.copyWith(
                              color: colorScheme.outline,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 24),

                    SizedBox(
                      width: 235,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search students...",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          isDense: true,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],

            BlocListener<AttendanceBloc, AttendanceState>(
              listener: (context, state) {
                if (state is AttendanceLoaded) {
                  final attendanceMap = <String, bool>{};
                  for (var attendance in state.attendanceList.attendance) {
                    attendanceMap[attendance.trainee.id] = attendance.isPresent;
                  }
                  _onAttendanceLoaded(attendanceMap);
                }
              },
              child: TraineeDataTableWidget(
                selectedCohortId: _selectedCohortId,
                selectedSessionId: _selectedSessionId,
                searchQuery: _searchQuery,
                onUploadID: (trainee) => _showUploadIDDialog(context, trainee),
                onAttendanceChanged: _onAttendanceChanged,
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
