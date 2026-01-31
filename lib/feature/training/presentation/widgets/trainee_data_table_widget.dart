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
import '../../domain/entities/trainee_entity.dart';
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

  const TraineeDataTableWidget({
    super.key,
    required this.selectedCohortId,
    required this.selectedSessionId,
    required this.searchQuery,
    required this.onUploadID,
    required this.onAttendanceChanged,
    this.onCommentChanged,
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
  }

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
            child: Column(
              children: [
                _buildCompleteTable(
                  [],
                  {},
                  {},
                  null,
                  colorScheme,
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
              Map<String, String> commentMap = {};
              if (attendanceState is AttendanceLoaded) {
                for (var attendance
                    in attendanceState.attendanceList.attendance) {
                  attendanceMap[attendance.trainee.id] = attendance.isPresent;
                  if (attendance.comment.isNotEmpty) {
                    commentMap[attendance.trainee.id] = attendance.comment;
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
  }

  Widget _buildCompleteTable(
    List trainees,
    Map<String, bool> attendanceMap,
    Map<String, String> commentMap,
    String? sessionDate,
    ColorScheme colorScheme, {
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
            columns: const [
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
    final startItem = ((_currentPage - 1) * _pageSize) + 1;
    final endItem = (_currentPage * _pageSize).clamp(1, _totalElements);

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
