import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:training/core/widgets/app_drawer.dart';
import 'package:training/core/widgets/custom_appbar.dart';
import 'package:training/feature/training/presentation/widgets/audience_profile_widget.dart';
import 'package:training/feature/training/presentation/widgets/content_widget.dart';
import 'package:training/feature/training/presentation/widgets/module_widget.dart';
import 'package:training/feature/training/presentation/widgets/mysessions_widget.dart';
import 'package:training/feature/training/presentation/widgets/overview_wiget.dart';
import 'package:training/feature/training/presentation/widgets/traning_profile_widget.dart';
import '../bloc/training_bloc/training_bloc.dart';
import '../bloc/training_bloc/training_event.dart';
import '../bloc/training_bloc/training_state.dart';

class TrainingDetailScreen extends StatefulWidget {
  final String trainingId;

  const TrainingDetailScreen({super.key, required this.trainingId});

  @override
  State<TrainingDetailScreen> createState() => _TrainingDetailScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  int selectedIndex = 0;

  final List<String> tabs = [
    "Overview",
    "Training Profile",
    "Audience Profile",
    "Module",
    "My Sessions",
    "Content",
  ];

  @override
  void initState() {
    super.initState();
    context.read<TrainingBloc>().add(GetTrainingByIdEvent(widget.trainingId));
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TrainingBloc, TrainingState>(
      builder: (context, state) {
        String title = "Training Details";
        if (state is TrainingDetailLoaded) {
          title = state.training.title;
        }

        return Scaffold(
          key: scaffoldKey,
          drawer: const AppDrawer(),
          appBar: CustomAppBar(
            title: title,
            showBackButton: true,
            onBackTap: () {
              if (GoRouter.of(context).canPop()) {
                context.pop();
              } else {
                context.go('/training');
              }
            },

            onNotificationTap: () {},
            onProfileTap: () {},
          ),
          body: _buildBody(context, state, colorTheme, textTheme),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    TrainingState state,
    ColorScheme colorTheme,
    TextTheme textTheme,
  ) {
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
              Icon(Icons.error_outline, size: 48, color: colorTheme.error),
              const SizedBox(height: 16),
              Text('Error loading training', style: textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                state.message,
                style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<TrainingBloc>().add(
                    GetTrainingByIdEvent(widget.trainingId),
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

    if (state is TrainingDetailLoaded) {
      return _buildTabsContent(context, state.training, colorTheme);
    }

    return const SizedBox();
  }

  Widget _buildTabsContent(
    BuildContext context,
    dynamic training,
    ColorScheme colorTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          height: 30,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: tabs.length,
            separatorBuilder: (_, _) => const SizedBox(width: 30),
            itemBuilder: (context, index) {
              final isSelected = index == selectedIndex;
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      _getIconForTab(tabs[index]),
                      size: 20,
                      color: isSelected
                          ? colorTheme.primary
                          : colorTheme.secondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tabs[index],
                      style: TextStyle(
                        color: isSelected
                            ? colorTheme.primary
                            : colorTheme.onSurfaceVariant,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(color: Color.fromARGB(255, 218, 219, 219)),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: _buildContentForTab(selectedIndex, training),
          ),
        ),
      ],
    );
  }

  IconData _getIconForTab(String tab) {
    switch (tab) {
      case "Overview":
        return Icons.dashboard_outlined;
      case "Training Profile":
        return Icons.cast_for_education;
      case "Audience Profile":
        return Icons.group_outlined;
      case "Module":
        return Icons.view_module_outlined;
      case "My Sessions":
        return Icons.event_note_outlined;
      case "Content":
        return Icons.menu_book_outlined;
      default:
        return Icons.help_outline;
    }
  }

  Widget _buildContentForTab(int index, dynamic training) {
    switch (index) {
      case 0:
        return Center(child: OverviewWiget(training: training));
      case 1:
        return Center(child: TraningProfileWidget(training: training));
      case 2:
        return Center(child: AudienceProfileWidget(training: training));
      case 3:
        return const Center(child: ModuleWidget());
      case 4:
        return Center(child: MysessionsWidget(trainingId: widget.trainingId));
      case 5:
        return const Center(child: ContentWidget());
      default:
        return const Center(child: Text("No Content"));
    }
  }
}
