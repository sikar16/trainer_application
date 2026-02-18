import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/trainee_bloc/trainee_bloc.dart';
import '../bloc/trainee_bloc/trainee_state.dart';
import '../bloc/trainee_bloc/trainee_event.dart';
import '../bloc/session_bloc/session_bloc.dart';
import '../bloc/session_bloc/session_state.dart';
import '../bloc/attendance_bloc/attendance_bloc.dart';
import '../bloc/attendance_bloc/attendance_event.dart';
import '../bloc/attendance_bloc/attendance_state.dart';
import '../bloc/survey_completion_bloc/survey_completion_bloc.dart';
import '../bloc/survey_completion_bloc/survey_completion_event.dart';
import '../bloc/survey_completion_bloc/survey_completion_state.dart';
import '../bloc/assessment_bloc/assessment_bloc.dart';
import '../bloc/assessment_bloc/assessment_state.dart';
import '../bloc/assessment_bloc/assessment_event.dart';
import '../bloc/assessment_attempt_bloc/assessment_attempt_bloc.dart';
import '../bloc/assessment_attempt_bloc/assessment_attempt_event.dart';
import '../bloc/assessment_attempt_bloc/assessment_attempt_state.dart';
import '../../domain/entities/trainee_entity.dart';
import '../../domain/entities/assessment_entity.dart';
import '../../domain/entities/assessment_attempt_entity.dart';
import 'common_widgets.dart';
import 'attendance_chip_widget.dart';
import 'upload_id_dialog_widget.dart';

class TraineeDataTableWidget extends StatefulWidget {
  final String? selectedCohortId;
  final String? selectedSessionId;
  final String searchQuery;
  final Function(TraineeEntity) onUploadID;
  final Function(String traineeId, bool isPresent) onAttendanceChanged;
  final Function(String traineeId, String comment)? onCommentChanged;
  final String? selectedSurveyId;
  final String? selectedSurveyName;
  final String? selectedAssessmentId;
  final String? selectedAssessmentName;
  final String trainingId;

  const TraineeDataTableWidget({
    super.key,
    required this.selectedCohortId,
    required this.selectedSessionId,
    required this.searchQuery,
    required this.onUploadID,
    required this.onAttendanceChanged,
    this.onCommentChanged,
    this.selectedSurveyId,
    this.selectedSurveyName,
    this.selectedAssessmentId,
    this.selectedAssessmentName,
    required this.trainingId,
  });

  @override
  State<TraineeDataTableWidget> createState() => _TraineeDataTableWidgetState();
}

class _TraineeDataTableWidgetState extends State<TraineeDataTableWidget> {
  String? _lastSessionId;
  int _currentPage = 1;
  int _pageSize = 10;
  int _totalPages = 1;
  int _totalElements = 0;

  void _loadTrainees() {
    if (widget.selectedCohortId != null) {
      context.read<TraineeBloc>().add(
        GetTraineesByCohortEvent(
          cohortId: widget.selectedCohortId!,
          page: _currentPage,
          pageSize: _pageSize,
        ),
      );
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    _loadTrainees();
  }

  void _onPageSizeChanged(int pageSize) {
    setState(() {
      _pageSize = pageSize;
      _currentPage = 1;
    });
    _loadTrainees();
  }

  @override
  void initState() {
    super.initState();
    _loadTrainees();
    // Load assessments when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AssessmentBloc>().add(
        GetAssessmentsEvent(trainingId: widget.trainingId),
      );
    });
  }

  @override
  void didUpdateWidget(TraineeDataTableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Load assessment attempt data when assessment selection changes
    if (widget.selectedAssessmentId != oldWidget.selectedAssessmentId &&
        widget.selectedAssessmentId != null) {
      context.read<AssessmentAttemptBloc>().add(
        GetAssessmentAttemptsEvent(assessmentId: widget.selectedAssessmentId!),
      );
    }

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
    if (widget.selectedSurveyId != null) {
      context.read<SurveyCompletionBloc>().add(
        GetSurveyCompletionEvent(surveyId: widget.selectedSurveyId!),
      );
    } else {
      context.read<SurveyCompletionBloc>().add(
        const ClearSurveyCompletionEvent(),
      );
    }

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

    return BlocBuilder<SurveyCompletionBloc, SurveyCompletionState>(
      builder: (context, surveyCompletionState) {
        List<String> completedTraineeIds = [];
        bool isSurveyCompletionLoading = false;

        if (surveyCompletionState is SurveyCompletionLoaded) {
          completedTraineeIds = surveyCompletionState.completedTraineeIds;
        } else if (surveyCompletionState is SurveyCompletionLoading &&
            widget.selectedSurveyId != null) {
          isSurveyCompletionLoading = true;
        }

        return BlocBuilder<AssessmentBloc, AssessmentState>(
          builder: (context, assessmentState) {
            AssessmentEntity? selectedAssessment;

            if (assessmentState is AssessmentLoaded &&
                widget.selectedAssessmentId != null) {
              try {
                selectedAssessment = assessmentState.assessments.firstWhere(
                  (assessment) => assessment.id == widget.selectedAssessmentId,
                );

                // Trigger assessment attempt API call
                context.read<AssessmentAttemptBloc>().add(
                  GetAssessmentAttemptsEvent(
                    assessmentId: selectedAssessment.id,
                  ),
                );
              } catch (e) {}
            } else {
              if (widget.selectedAssessmentId == null) {}
              if (assessmentState is! AssessmentLoaded) {}
            }

            return BlocBuilder<TraineeBloc, TraineeState>(
              builder: (context, traineeState) {
                if (traineeState is TraineeLoading) {
                  return CommonCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        _buildCompleteTable(
                          [],
                          {},
                          {},
                          null,
                          colorScheme,
                          completedTraineeIds,
                          isSurveyCompletionLoading: isSurveyCompletionLoading,
                          selectedAssessment,
                          isLoading: true,
                        ),
                        if (_totalPages > 1) _buildPaginationControls(),
                      ],
                    ),
                  );
                }

                if (traineeState is TraineeLoaded) {
                  final trainees = traineeState.traineeList.trainees;
                  _totalPages = traineeState.traineeList.totalPages;
                  _totalElements = traineeState.traineeList.totalElements;
                  String? sessionDate;
                  final sessionState = context.read<SessionBloc>().state;
                  if (sessionState is SessionLoaded) {
                    try {
                      final selectedSession = sessionState.sessionList.sessions
                          .firstWhere((s) => s.id == widget.selectedSessionId);
                      sessionDate = selectedSession.formattedDate;
                    } catch (e) {
                      if (sessionState.sessionList.sessions.isNotEmpty) {
                        sessionDate = sessionState
                            .sessionList
                            .sessions
                            .first
                            .formattedDate;
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
                      Map<String, String> commentMap = {};
                      if (attendanceState is AttendanceLoaded) {
                        for (var attendance
                            in attendanceState.attendanceList.attendance) {
                          attendanceMap[attendance.trainee.id] =
                              attendance.isPresent;
                          if (attendance.comment.isNotEmpty) {
                            commentMap[attendance.trainee.id] =
                                attendance.comment;
                          }
                        }
                      }

                      return CommonCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            _buildCompleteTable(
                              trainees,
                              attendanceMap,
                              commentMap,
                              sessionDate,
                              colorScheme,
                              completedTraineeIds,
                              isSurveyCompletionLoading:
                                  isSurveyCompletionLoading,
                              selectedAssessment,
                            ),
                            if (_totalPages > 1) _buildPaginationControls(),
                          ],
                        ),
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            );
          },
        );
      },
    );
  }

  Widget _buildCompleteTable(
    List trainees,
    Map<String, bool> attendanceMap,
    Map<String, String> commentMap,
    String? sessionDate,
    ColorScheme colorScheme,
    List<String> completedTraineeIds,
    AssessmentEntity? selectedAssessment, {
    bool isSurveyCompletionLoading = false,
    bool isLoading = false,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          DataTable(
            columnSpacing: 16,
            horizontalMargin: 16,
            headingRowHeight: 40,
            dataRowMinHeight: 40,
            dataRowMaxHeight: 60,
            columns: [
              DataColumn(
                label: SizedBox(
                  width: 24,
                  child: Checkbox(value: false, onChanged: null),
                ),
              ),
              DataColumn(
                label: Text(
                  "Full Name",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                label: Text(
                  "Phone Number",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                label: Text(
                  "Date",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                label: Text(
                  "Attendance",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                label: Text(
                  "ID & Consent Form",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              if (widget.selectedSurveyId != null)
                DataColumn(
                  label: Text(
                    "Survey Status",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              if (widget.selectedAssessmentId != null)
                DataColumn(
                  label: Text(
                    "Pre Assessment Score",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              if (widget.selectedAssessmentId != null)
                DataColumn(
                  label: Text(
                    "Post Assessment Score",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
            ],
            rows: isLoading
                ? []
                : trainees
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
                              SizedBox(
                                width: 24,
                                child: Checkbox(value: false, onChanged: null),
                              ),
                            ),
                            DataCell(Text(trainee.fullName)),
                            DataCell(Text(trainee.contactPhone)),
                            DataCell(Text(sessionDate ?? 'N/A')),
                            DataCell(
                              AttendanceChipWidget(
                                initialIsPresent: initialIsPresent,
                                initialComment: commentMap[trainee.id],
                                onChanged: (isPresent) {
                                  widget.onAttendanceChanged(
                                    trainee.id,
                                    isPresent,
                                  );
                                },
                                onCommentChanged:
                                    widget.onCommentChanged != null
                                    ? (comment) => widget.onCommentChanged!(
                                        trainee.id,
                                        comment,
                                      )
                                    : null,
                              ),
                            ),
                            DataCell(
                              _buildDocumentLinksWithEdit(trainee, colorScheme),
                            ),
                            if (widget.selectedSurveyId != null)
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: isSurveyCompletionLoading
                                      ? Text(
                                          "Loading...",
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              completedTraineeIds.contains(
                                                    trainee.id,
                                                  )
                                                  ? Icons.check_circle_outline
                                                  : Icons.cancel_outlined,
                                              size: 20,
                                              color:
                                                  completedTraineeIds.contains(
                                                    trainee.id,
                                                  )
                                                  ? const Color(0xFF16A349)
                                                  : Colors.grey.shade500,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              completedTraineeIds.contains(
                                                    trainee.id,
                                                  )
                                                  ? "Completed"
                                                  : "Not completed",
                                              style: TextStyle(
                                                color:
                                                    completedTraineeIds
                                                        .contains(trainee.id)
                                                    ? const Color(0xFF16A349)
                                                    : Colors.grey.shade500,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            if (widget.selectedAssessmentId != null)
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child:
                                      BlocBuilder<
                                        AssessmentAttemptBloc,
                                        AssessmentAttemptState
                                      >(
                                        builder: (context, attemptState) {
                                          if (attemptState
                                              is AssessmentAttemptLoading) {
                                            return const Text(
                                              "Loading...",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            );
                                          }

                                          if (attemptState
                                              is AssessmentAttemptLoaded) {
                                            final traineeId = trainee.id;
                                            final traineeAttempts = attemptState
                                                .assessmentAttempt
                                                .traineeAttemptsMap;
                                            final traineeAttempt =
                                                traineeAttempts[traineeId];

                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        traineeAttempt
                                                                ?.preAssessmentScore !=
                                                            null
                                                        ? Colors.grey.shade300
                                                        : Colors.grey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          30,
                                                        ), // pill shape
                                                  ),
                                                  child: Text(
                                                    traineeAttempt
                                                            ?.preAssessmentDisplay ??
                                                        "Not taken",
                                                    style: TextStyle(
                                                      color:
                                                          traineeAttempt
                                                                  ?.preAssessmentScore !=
                                                              null
                                                          ? Colors.black87
                                                          : Colors.grey,

                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }

                                          return const Text(
                                            "Not taken",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          );
                                        },
                                      ),
                                ),
                              ),
                            if (widget.selectedAssessmentId != null)
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: BlocBuilder<AssessmentAttemptBloc, AssessmentAttemptState>(
                                    builder: (context, attemptState) {
                                      if (attemptState
                                          is AssessmentAttemptLoading) {
                                        return const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Loading...",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        );
                                      }

                                      String totalAttemptsText = "0";
                                      TraineeAttemptEntity? traineeAttempt;

                                      if (attemptState
                                          is AssessmentAttemptLoaded) {
                                        final traineeId = trainee.id;
                                        final traineeAttempts = attemptState
                                            .assessmentAttempt
                                            .traineeAttemptsMap;
                                        traineeAttempt =
                                            traineeAttempts[traineeId];

                                        if (traineeAttempt != null) {
                                          totalAttemptsText = traineeAttempt
                                              .totalAttempts
                                              .toString();
                                        }
                                      }

                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  traineeAttempt
                                                          ?.postAssessmentScore !=
                                                      null
                                                  ? Colors.green.withOpacity(
                                                      0.25,
                                                    ) // light green like image
                                                  : Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    30,
                                                  ), // pill
                                            ),
                                            child: Text(
                                              traineeAttempt
                                                      ?.postAssessmentDisplay ??
                                                  "Not taken",
                                              style: TextStyle(
                                                color:
                                                    traineeAttempt
                                                            ?.postAssessmentScore !=
                                                        null
                                                    ? Colors.green.shade800
                                                    : Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 4),

                                          Text(
                                            "Attempt $totalAttemptsText/${selectedAssessment?.maxAttempts}",
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        );
                      })
                      .toList(),
          ),
          if (isLoading)
            Container(
              height: 200,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildPaginationControls() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Show:',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: colorScheme.outline),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: DropdownButton<int>(
                        value: _pageSize,
                        underline: const SizedBox(),
                        isDense: true,
                        items: [5, 10, 20, 50].map((size) {
                          return DropdownMenuItem(
                            value: size,
                            child: Text(
                              '$size',
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            _onPageSizeChanged(value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: _currentPage > 1
                        ? () => _onPageChanged(_currentPage - 1)
                        : null,
                    icon: const Icon(Icons.chevron_left, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: _currentPage > 1
                          ? colorScheme.primary
                          : colorScheme.surface,
                      foregroundColor: _currentPage > 1
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                      minimumSize: const Size(32, 32),
                      padding: const EdgeInsets.all(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '$_currentPage',
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _currentPage < _totalPages
                        ? () => _onPageChanged(_currentPage + 1)
                        : null,
                    icon: const Icon(Icons.chevron_right, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: _currentPage < _totalPages
                          ? colorScheme.primary
                          : colorScheme.surface,
                      foregroundColor: _currentPage < _totalPages
                          ? colorScheme.onPrimary
                          : colorScheme.onSurface,
                      minimumSize: const Size(32, 32),
                      padding: const EdgeInsets.all(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentLinksWithEdit(
    TraineeEntity trainee,
    ColorScheme colorScheme,
  ) {
    final documents = <Map<String, dynamic>>[];

    if (trainee.frontIdUrl != null) {
      documents.add({
        'label': 'Front ID',
        'url': trainee.frontIdUrl!,
        'icon': Icons.badge,
      });
    }
    if (trainee.backIdUrl != null) {
      documents.add({
        'label': 'Back ID',
        'url': trainee.backIdUrl!,
        'icon': Icons.badge_outlined,
      });
    }
    if (trainee.consentFormUrl != null) {
      documents.add({
        'label': 'Consent Form',
        'url': trainee.consentFormUrl!,
        'icon': Icons.description,
      });
    }
    if (trainee.signatureUrl != null) {
      documents.add({
        'label': 'Signature',
        'url': trainee.signatureUrl!,
        'icon': Icons.draw,
      });
    }

    final List<Widget> children = [];

    if (documents.isNotEmpty) {
      children.addAll(
        documents.map((doc) {
          return _buildDocumentLinkWithIcon(
            doc['label'],
            doc['url'],
            doc['icon'],
          );
        }).toList(),
      );
    } else {
      children.add(
        Text(
          "No documents",
          style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
        ),
      );
    }

    children.add(const SizedBox(width: 6));

    children.add(
      GestureDetector(
        onTap: () => _showEditDialog(trainee),
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Icon(Icons.edit, size: 16, color: colorScheme.primary),
        ),
      ),
    );

    return Wrap(spacing: 8, runSpacing: 4, children: children);
  }

  Widget _buildDocumentLinkWithIcon(String label, String url, IconData icon) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Could not launch $label')));
          }
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.blue.shade700),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 10,
                decoration: TextDecoration.underline,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(TraineeEntity trainee) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 96,
          height: MediaQuery.of(context).size.height * 0.96,
          child: UploadIDDialogWidget(trainee: trainee),
        ),
      ),
    );
  }
}
