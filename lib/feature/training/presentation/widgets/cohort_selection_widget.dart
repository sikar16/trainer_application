import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cohort_bloc/cohort_bloc.dart';
import '../bloc/cohort_bloc/cohort_event.dart';
import '../bloc/cohort_bloc/cohort_state.dart';
import 'common_widgets.dart';

class CohortSelectionWidget extends StatelessWidget {
  final String trainingId;
  final String? selectedCohortId;
  final Function(String?) onCohortSelected;

  const CohortSelectionWidget({
    super.key,
    required this.trainingId,
    required this.selectedCohortId,
    required this.onCohortSelected,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    
    return BlocListener<CohortBloc, CohortState>(
      listener: (context, state) {
        if (state is CohortLoaded && selectedCohortId == null) {
          final cohorts = state.cohortList.cohorts;
          if (cohorts.isNotEmpty) {
            onCohortSelected(cohorts.first.id);
          }
        }
      },
      child: BlocBuilder<CohortBloc, CohortState>(
        builder: (context, state) {
          if (state is CohortLoading) {
            return CommonCard(
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (state is CohortError) {
            return CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Cohorts"),
                  const SizedBox(height: 12),
                  Text(
                    'Error: ${state.message}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      context.read<CohortBloc>().add(
                        GetCohortsEvent(trainingId: trainingId),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CohortLoaded) {
            final cohorts = state.cohortList.cohorts;
            if (cohorts.isEmpty) {
              return CommonCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Cohorts"),
                    const SizedBox(height: 12),
                    const Text('No cohorts available'),
                  ],
                ),
              );
            }

            return CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Cohorts"),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: cohorts.map((cohort) {
                        final isSelected = selectedCohortId == cohort.id;
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: PillButton(
                            label: cohort.name,
                            selected: isSelected,
                            onTap: () {
                              onCohortSelected(isSelected ? null : cohort.id);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }

          return CommonCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Cohorts"),
                const SizedBox(height: 12),
                const Text('Loading...'),
              ],
            ),
          );
        },
      ),
    );
  }
}
