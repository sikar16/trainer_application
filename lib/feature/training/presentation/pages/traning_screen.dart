import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_application/core/widgets/app_drawer.dart';
import 'package:trainer_application/core/widgets/custom_appbar.dart';
import 'package:trainer_application/feature/training/presentation/widgets/custom_card.dart';
import '../bloc/training/training_bloc.dart';
import '../bloc/training/training_event.dart';
import '../bloc/training/training_state.dart';
import '../../domain/entities/training_entity.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _TrainingScreenState extends State<TrainingScreen> {
  final int _currentPage = 1;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    context.read<TrainingBloc>().add(
      GetTrainingsEvent(page: _currentPage, pageSize: _pageSize),
    );
  }

  String _formatZones(List<ZoneEntity> zones) {
    if (zones.isEmpty) return 'N/A';
    return zones.map((zone) => zone.name).join(', ');
  }

  String _formatAgeGroups(List<AgeGroupEntity> ageGroups) {
    if (ageGroups.isEmpty) return 'N/A';
    return ageGroups.map((age) => age.range).join(', ');
  }

  String _formatDuration(double duration, String durationType) {
    final durationStr = duration.toStringAsFixed(
      duration.truncateToDouble() == duration ? 0 : 1,
    );
    return '$durationStr ${durationType.toLowerCase()}';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
        title: "Training",
        onMenuTap: () {
          scaffoldKey.currentState?.openDrawer();
        },
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: BlocBuilder<TrainingBloc, TrainingState>(
        builder: (context, state) {
          if (state is TrainingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TrainingError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading trainings',
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<TrainingBloc>().add(
                          GetTrainingsEvent(
                            page: _currentPage,
                            pageSize: _pageSize,
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is TrainingLoaded) {
            final trainings = state.trainingList.trainings;

            if (trainings.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No trainings available',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<TrainingBloc>().add(
                  GetTrainingsEvent(page: _currentPage, pageSize: _pageSize),
                );
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: trainings.length,
                itemBuilder: (context, index) {
                  final training = trainings[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CustomCard(
                      traningName: training.title,
                      locaton: _formatZones(training.zones),
                      time: _formatDuration(
                        training.duration,
                        training.durationType,
                      ),
                      age: _formatAgeGroups(training.ageGroups),
                      nextpage: 'View training',
                      onNextTap: () {
                        context.go('/trainingDetails/${training.id}');
                      },
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
