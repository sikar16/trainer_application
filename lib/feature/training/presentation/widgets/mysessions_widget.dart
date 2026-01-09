import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainer_application/feature/training/presentation/widgets/view_report_widget.dart';
import '../bloc/cohort_bloc.dart';
import '../bloc/cohort_event.dart';
import '../bloc/session_bloc.dart';
import '../bloc/session_event.dart';
import '../bloc/trainee_bloc.dart';
import '../bloc/trainee_event.dart';
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
      _selectedSessionId = null; // Reset session when cohort changes
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
      });
    }
  }

  void _onSessionSelected(String? sessionId) {
    setState(() {
      _selectedSessionId = sessionId;
    });
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
            ),

            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ViewReportPage()),
                  );
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text("View Report"),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFE7F9EE),
                  foregroundColor: const Color(0xFF137333),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: const Color.fromARGB(255, 255, 255, 255),
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
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: SizedBox(
                      child: Text(
                        "Save Attendance",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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

            TraineeDataTableWidget(
              selectedCohortId: _selectedCohortId,
              selectedSessionId: _selectedSessionId,
              searchQuery: _searchQuery,
              onUploadID: (trainee) => _showUploadIDDialog(context, trainee),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
