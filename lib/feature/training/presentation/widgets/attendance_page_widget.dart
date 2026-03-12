import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/attendance_bloc/attendance_bloc.dart';
import '../bloc/attendance_bloc/attendance_event.dart';
import '../bloc/attendance_bloc/attendance_state.dart';
import '../bloc/trainee_bloc/trainee_bloc.dart';
import '../bloc/trainee_bloc/trainee_event.dart';
import '../bloc/trainee_bloc/trainee_state.dart';
import '../bloc/session_report_bloc.dart';
import '../bloc/session_report_event.dart';
import '../bloc/session_report_state.dart';
import '../../domain/entities/session_entity.dart';
import 'trainee_data_table_widget.dart';
import 'survye_and_assessment_widget.dart';
import 'upload_id_dialog_widget.dart';

class AttendancePageWidget extends StatefulWidget {
  final SessionEntity session;
  final String trainingId;

  const AttendancePageWidget({
    super.key,
    required this.session,
    required this.trainingId,
  });

  @override
  State<AttendancePageWidget> createState() => _AttendancePageWidgetState();
}

class _AttendancePageWidgetState extends State<AttendancePageWidget> {
  final Map<String, bool> _attendanceChanges = {};
  bool _hasReport = false;
  String? _selectedSurveyId;
  String? _selectedSurveyName;
  String? _selectedAssessmentId;
  String? _selectedAssessmentName;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<AttendanceBloc>().add(
      GetAttendanceBySessionEvent(widget.session.id),
    );
    context.read<TraineeBloc>().add(
      GetTraineesByCohortEvent(cohortId: widget.session.cohort.id),
    );
    context.read<SessionReportBloc>().add(
      GetSessionReportEvent(widget.session.id),
    );
  }

  void _onAttendanceChanged(String traineeId, bool isPresent) {
    setState(() {
      _attendanceChanges[traineeId] = isPresent;
    });
  }

  void _onAttendanceLoaded(Map<String, bool> attendanceMap) {
    setState(() {
      _attendanceChanges.clear();
    });
  }

  void _onSurveySelected(String? surveyId, String? surveyName) {
    setState(() {
      _selectedSurveyId = surveyId;
      _selectedSurveyName = surveyName;
    });
  }

  void _onAssessmentSelected(String? assessmentId, String? assessmentName) {
    setState(() {
      _selectedAssessmentId = assessmentId;
      _selectedAssessmentName = assessmentName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSessionDetailsCard(colorScheme, textTheme),
            const SizedBox(height: 20),
            _buildActionBar(colorScheme, textTheme),
            const SizedBox(height: 20),
            _buildAttendanceTable(colorScheme, textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionDetailsCard(
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Session ',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(widget.session.name, style: TextStyle(fontSize: 12)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      Icon(Icons.calendar_month, size: 20),
                      SizedBox(width: 4),
                      Text(
                        widget.session.formattedDate,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),

                  Text(
                    widget.session.formattedTime,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),

                  Text(
                    widget.session.trainingVenue?.location ??
                        widget.session.trainingVenue?.name ??
                        'N/A',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(widget.session.status),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _getStatusDotColor(widget.session.status),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.session.status,
                          style: textTheme.bodySmall?.copyWith(
                            color: _getStatusTextColor(widget.session.status),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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

  Widget _buildActionBar(ColorScheme colorScheme, TextTheme textTheme) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.copy_all, color: colorScheme.primary),
              Text(
                'Bulk Action',
                style: TextStyle(fontSize: 12, color: colorScheme.primary),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: SizedBox(
                  height: 32,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 4,
                        ), // reduce gap
                        child: const Icon(Icons.search, size: 18),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 0,
                        minHeight: 0,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      isDense: true,
                    ),
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              BlocListener<SessionReportBloc, SessionReportState>(
                listener: (context, state) {
                  setState(() {
                    _hasReport =
                        state is SessionReportLoaded ||
                        state is SessionReportEmpty;
                  });
                },
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    _hasReport ? Icons.visibility : Icons.add,
                    size: 14,
                  ),
                  label: Text(
                    _hasReport ? 'View Report' : 'Add Report',
                    style: const TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SurveyAndAssessment(
            trainingId: widget.trainingId,
            onSurveySelected: _onSurveySelected,
            onAssessmentSelected: _onAssessmentSelected,
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceTable(ColorScheme colorScheme, TextTheme textTheme) {
    return BlocListener<AttendanceBloc, AttendanceState>(
      listener: (context, state) {
        if (state is AttendanceLoaded) {
          final attendanceMap = <String, bool>{};
          for (var attendance in state.attendanceList.attendance) {
            attendanceMap[attendance.trainee.id] = attendance.isPresent;
          }
          _onAttendanceLoaded(attendanceMap);
        }
      },

      child: BlocBuilder<TraineeBloc, TraineeState>(
        builder: (context, traineeState) {
          if (traineeState is TraineeLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (traineeState is TraineeError) {
            return Center(
              child: Text(
                'Error loading trainees: ${traineeState.message}',
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
              ),
            );
          }

          if (traineeState is TraineeLoaded) {
            final trainees = traineeState.traineeList.trainees;

            if (trainees.isEmpty) {
              return Center(
                child: Text(
                  'No trainees found',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  TraineeDataTableWidget(
                    selectedCohortId: widget.session.cohort.id,
                    selectedSessionId: widget.session.id,
                    searchQuery: '',

                    onUploadID: (trainee) {},
                    onAttendanceChanged: (traineeId, isPresent) {
                      _onAttendanceChanged(traineeId, isPresent);
                    },
                    onAddIdAndConsent: (trainee) {
                      _showUploadIdDialog(trainee);
                    },
                    trainingId: widget.trainingId,
                    disableTraineeLoading: true,
                    selectedSurveyId: _selectedSurveyId,
                    selectedSurveyName: _selectedSurveyName,
                    selectedAssessmentId: _selectedAssessmentId,
                    selectedAssessmentName: _selectedAssessmentName,
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showUploadIdDialog(trainee) {
    showDialog(
      context: context,
      builder: (context) =>
          Dialog(child: UploadIDDialogWidget(trainee: trainee)),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'scheduled':
      return const Color(0xFFE8F0FB);
    case 'completed':
      return const Color(0xFFE9F7EF);
    case 'cancelled':
      return const Color(0xFFFDEAEA);
    case 'in progress':
      return const Color(0xFFFFF7E6);
    default:
      return Colors.grey;
  }
}

Color _getStatusDotColor(String status) {
  switch (status.toLowerCase()) {
    case 'scheduled':
      return Colors.blue.shade300;
    case 'completed':
      return Colors.green.shade300;
    case 'cancelled':
      return Colors.red.shade300;
    case 'in progress':
      return Colors.orange.shade300;
    default:
      return Colors.grey.shade300;
  }
}

Color _getStatusTextColor(String status) {
  switch (status.toLowerCase()) {
    case 'scheduled':
      return Colors.blue.shade700;

    case 'completed':
      return Colors.green.shade700;

    case 'cancelled':
      return Colors.red.shade700;

    case 'in progress':
      return Colors.orange.shade700;

    default:
      return Colors.grey.shade700;
  }
}
