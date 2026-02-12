import 'package:gheero/feature/training/presentation/widgets/survye_and_assessment_widget.dart';
import '../bloc/assessment_bloc/assessment_bloc.dart';
import '../../../../../core/network/api_client.dart';

import '../../../../core/snack_bar/snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gheero/feature/training/presentation/widgets/view_report_widget.dart';
import '../bloc/cohort_bloc/cohort_bloc.dart';
import '../bloc/cohort_bloc/cohort_event.dart';
import '../bloc/session_bloc/session_bloc.dart';
import '../bloc/session_bloc/session_event.dart';
import '../bloc/trainee_bloc/trainee_bloc.dart';
import '../bloc/trainee_bloc/trainee_event.dart';
import '../bloc/attendance_bloc/attendance_bloc.dart';
import '../bloc/attendance_bloc/attendance_event.dart';
import '../bloc/attendance_bloc/attendance_state.dart';
import '../bloc/survey_completion_bloc/survey_completion_bloc.dart';
import '../bloc/survey_bloc/survey_bloc.dart';
import '../../data/repositories/survey_completion_repository_impl.dart';
import '../../data/datasources/survey_completion_remote_data_source.dart';
import '../bloc/session_report_bloc.dart';
import '../bloc/session_report_event.dart';
import '../bloc/session_report_state.dart';
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
  bool _hasReport = false;
  final Map<String, bool> _attendanceChanges = {};
  Map<String, bool> _initialAttendance = {};
  Map<String, String> _attendanceComments = {};
  bool _hasUnsavedChanges = false;
  double _surveyAssessmentHeight = 120.0;
  String? _selectedSurveyId;
  String? _selectedSurveyName;
  String? _selectedAssessmentId;
  String? _selectedAssessmentName;

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
        _hasReport = false;
      });
      context.read<AttendanceBloc>().add(
        GetAttendanceBySessionEvent(sessions.first.id),
      );
      context.read<SessionReportBloc>().add(
        GetSessionReportEvent(sessions.first.id),
      );
    }
  }

  void _onSessionSelected(String? sessionId) {
    setState(() {
      _selectedSessionId = sessionId;
      _attendanceChanges.clear();
      _initialAttendance.clear();
      _hasUnsavedChanges = false;
      _hasReport = false;
    });
    if (sessionId != null) {
      context.read<AttendanceBloc>().add(
        GetAttendanceBySessionEvent(sessionId),
      );
      context.read<SessionReportBloc>().add(GetSessionReportEvent(sessionId));
    }
  }

  void _onAttendanceChanged(String traineeId, bool isPresent) {
    setState(() {
      _attendanceChanges[traineeId] = isPresent;
      _hasUnsavedChanges =
          _attendanceChanges.entries.any(
            (entry) => entry.value != (_initialAttendance[entry.key] ?? true),
          ) ||
          _attendanceComments.isNotEmpty;
    });
  }

  void _onCommentChanged(String traineeId, String comment) {
    setState(() {
      if (comment.isNotEmpty) {
        _attendanceComments[traineeId] = comment;
      } else {
        _attendanceComments.remove(traineeId);
      }
      _hasUnsavedChanges =
          _attendanceChanges.entries.any(
            (entry) => entry.value != (_initialAttendance[entry.key] ?? true),
          ) ||
          _attendanceComments.isNotEmpty;
    });
  }

  void _onAttendanceLoaded(
    Map<String, bool> attendanceMap,
    Map<String, String> commentMap,
  ) {
    setState(() {
      _initialAttendance = Map<String, bool>.from(attendanceMap);
      _attendanceComments = Map<String, String>.from(commentMap);
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
          comment: _attendanceComments[entry.key] ?? '',
        ),
      );
    }

    for (var entry in _attendanceComments.entries) {
      if (!_attendanceChanges.containsKey(entry.key)) {
        final currentAttendance = _initialAttendance[entry.key] ?? true;
        attendanceBloc.add(
          SaveAttendanceEvent(
            sessionId: _selectedSessionId!,
            traineeId: entry.key,
            isPresent: currentAttendance,
            comment: entry.value,
          ),
        );
      }
    }

    await Future.delayed(const Duration(milliseconds: 500));

    attendanceBloc.add(GetAttendanceBySessionEvent(_selectedSessionId!));

    setState(() {
      _attendanceChanges.clear();
      _attendanceComments.clear();
      _hasUnsavedChanges = false;
    });

    CustomSnackBar.success(context, 'Attendance saved successfully');

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
            const SizedBox(height: 20),
            SizedBox(
              height: _surveyAssessmentHeight,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => SurveyCompletionBloc(
                      repository: SurveyCompletionRepositoryImpl(
                        SurveyCompletionRemoteDataSource(
                          apiClient: ApiClient(),
                        ),
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => SurveyBloc(apiClient: ApiClient()),
                  ),
                  BlocProvider(
                    create: (context) => AssessmentBloc(apiClient: ApiClient()),
                  ),
                ],
                child: SurveyAndAssessment(
                  trainingId: widget.trainingId,
                  onHeightChanged: (height) {
                    setState(() {
                      _surveyAssessmentHeight = height;
                    });
                  },
                  onSurveySelected: (surveyId, surveyName) {
                    setState(() {
                      _selectedSurveyId = surveyId;
                      _selectedSurveyName = surveyName;
                      _selectedAssessmentId = null;
                      _selectedAssessmentName = null;
                    });
                  },
                  onAssessmentSelected: (assessmentId, assessmentName) {
                    setState(() {
                      _selectedAssessmentId = assessmentId;
                      _selectedAssessmentName = assessmentName;
                      _selectedSurveyId = null;
                      _selectedSurveyName = null;
                    });
                  },
                ),
              ),
            ),
            if (_hasSessions) ...[
              const SizedBox(height: 20),
              BlocListener<SessionReportBloc, SessionReportState>(
                listener: (context, state) {
                  setState(() {
                    _hasReport =
                        state is SessionReportLoaded ||
                        state is SessionReportEmpty;
                  });
                },
                child: Align(
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
                    icon: Icon(_hasReport ? Icons.visibility : Icons.add),
                    label: Text(_hasReport ? "View Report" : "Add Report"),
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
                              color: _hasUnsavedChanges
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurfaceVariant,
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
                  final commentMap = <String, String>{};
                  for (var attendance in state.attendanceList.attendance) {
                    attendanceMap[attendance.trainee.id] = attendance.isPresent;
                    if (attendance.comment.isNotEmpty) {
                      commentMap[attendance.trainee.id] = attendance.comment;
                    }
                  }
                  _onAttendanceLoaded(attendanceMap, commentMap);
                } else if (state is AttendanceError) {
                  CustomSnackBar.error(
                    context,
                    'Failed to save attendance: ${state.message}',
                  );
                }
              },
              child: BlocProvider(
                create: (context) => SurveyCompletionBloc(
                  repository: SurveyCompletionRepositoryImpl(
                    SurveyCompletionRemoteDataSource(apiClient: ApiClient()),
                  ),
                ),
                child: TraineeDataTableWidget(
                  selectedCohortId: _selectedCohortId,
                  selectedSessionId: _selectedSessionId,
                  searchQuery: _searchQuery,
                  onUploadID: (trainee) =>
                      _showUploadIDDialog(context, trainee),
                  onAttendanceChanged: _onAttendanceChanged,
                  onCommentChanged: _onCommentChanged,
                  selectedSurveyId: _selectedSurveyId,
                  selectedSurveyName: _selectedSurveyName,
                  selectedAssessmentId: _selectedAssessmentId,
                  selectedAssessmentName: _selectedAssessmentName,
                ),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
