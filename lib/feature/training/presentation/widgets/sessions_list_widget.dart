import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cohort_bloc/cohort_bloc.dart';
import '../bloc/cohort_bloc/cohort_event.dart';
import '../bloc/cohort_bloc/cohort_state.dart';
import '../bloc/session_bloc/session_bloc.dart';
import '../bloc/session_bloc/session_event.dart';
import '../bloc/session_bloc/session_state.dart';
import '../../domain/entities/session_entity.dart';
import 'session_card_widget.dart';

class SessionsListWidget extends StatefulWidget {
  final String trainingId;
  final Function(String sessionId) onSessionSelected;

  const SessionsListWidget({
    super.key,
    required this.trainingId,
    required this.onSessionSelected,
  });

  @override
  State<SessionsListWidget> createState() => _SessionsListWidgetState();
}

class _SessionsListWidgetState extends State<SessionsListWidget> {
  String? _selectedCohortId;
  String _searchQuery = '';
  int _currentPage = 1;
  int _pageSize = 7;

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
      _currentPage = 1;
    });
    if (cohortId != null) {
      context.read<SessionBloc>().add(
        GetSessionsByCohortEvent(cohortId: cohortId),
      );
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
    if (_selectedCohortId != null) {
      context.read<SessionBloc>().add(
        GetSessionsByCohortEvent(cohortId: _selectedCohortId!),
      );
    }
  }

  List<SessionEntity> _filterSessions(List<SessionEntity> sessions) {
    if (_searchQuery.isEmpty) return sessions;

    return sessions.where((session) {
      return session.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          session.formattedDate.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          session.deliveryMethod.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          session.status.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          "Sessions",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),

        // Filters Row
        Row(
          children: [
            // Filter by cohort text
            const Text(
              'Filter by cohort',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(width: 12),

            BlocBuilder<CohortBloc, CohortState>(
              builder: (context, state) {
                if (state is CohortLoaded) {
                  final cohorts = state.cohortList.cohorts;

                  if (_selectedCohortId == null && cohorts.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _selectedCohortId = cohorts.first.id;
                      });
                      _onCohortSelected(cohorts.first.id);
                    });
                  }

                  return Container(
                    width: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCohortId,
                        isExpanded: true,
                        hint: const Text(
                          'Select cohort',
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey.shade600,
                        ),
                        items: [
                          ...cohorts.map((cohort) {
                            return DropdownMenuItem<String>(
                              value: cohort.id,
                              child: Text(
                                cohort.name,
                                style: const TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            );
                          }).toList(),
                        ],
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCohortId = value;
                          });
                          _onCohortSelected(value);
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(width: 16),

            // Search Bar
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey.shade500,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Sessions List
        BlocBuilder<SessionBloc, SessionState>(
          builder: (context, state) {
            if (state is SessionLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is SessionError) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      'Error: ${state.message}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedCohortId != null) {
                          context.read<SessionBloc>().add(
                            GetSessionsByCohortEvent(
                              cohortId: _selectedCohortId!,
                            ),
                          );
                        }
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is SessionLoaded) {
              final sessions = _filterSessions(state.sessionList.sessions);

              if (sessions.isEmpty) {
                return Center(
                  heightFactor: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No Sessions Available',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No sessions are available in this cohort for attendance tracking. Please add sessions to this cohort first.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  // Session Cards
                  ...sessions.map(
                    (session) => SessionCardWidget(
                      session: session,
                      onViewAttendance: () =>
                          widget.onSessionSelected(session.id),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Pagination
                  if (state.sessionList.totalPages > 1)
                    _buildPagination(
                      colorScheme,
                      textTheme,
                      state.sessionList.totalPages,
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildPagination(
    ColorScheme colorScheme,
    TextTheme textTheme,
    int totalPages,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Showing X dropdown
          Row(
            children: [
              Text('Showing', style: textTheme.bodyMedium),
              const SizedBox(width: 8),
              DropdownButton<int>(
                value: _pageSize,
                items: [5, 7, 10, 15].map((size) {
                  return DropdownMenuItem<int>(
                    value: size,
                    child: Text('$size'),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _pageSize = value;
                      _currentPage = 1;
                    });
                  }
                },
              ),
            ],
          ),

          // Page Numbers
          Row(
            children: List.generate(
              totalPages,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () => _onPageChanged(index + 1),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _currentPage == index + 1
                          ? colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    child: Text(
                      '${index + 1}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: _currentPage == index + 1
                            ? Colors.white
                            : colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
