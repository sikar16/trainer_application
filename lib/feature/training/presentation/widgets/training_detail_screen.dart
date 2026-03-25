import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gheero/core/widgets/custom_appbar.dart';
import 'package:gheero/feature/training/presentation/widgets/audience_profile_widget.dart';
import 'package:gheero/feature/training/presentation/widgets/content_widget.dart';
import 'package:gheero/feature/training/presentation/widgets/module_widget.dart';
import 'package:gheero/feature/training/presentation/widgets/mysessions_widget.dart';
import 'package:gheero/feature/training/presentation/widgets/overview_wiget.dart';
import 'package:gheero/feature/training/presentation/widgets/traning_profile_widget.dart';
import 'package:go_router/go_router.dart';
import '../bloc/training_bloc/training_bloc.dart';
import '../bloc/training_bloc/training_event.dart';
import '../bloc/training_bloc/training_state.dart';

class TrainingDetailScreen extends StatefulWidget {
  final String trainingId;

  const TrainingDetailScreen({super.key, required this.trainingId});

  @override
  State<TrainingDetailScreen> createState() => _TrainingDetailScreenState();
}

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
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: title,
            showBackButton: true,
            onBackTap: () {
              if (Navigator.of(context).canPop()) {
                context.pop();
              } else {
                context.push('/training');
              }
            },

            onMenuTap: () {},
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
          margin: const EdgeInsets.symmetric(vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
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
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected
                            ? colorTheme.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Row(
                      children: [
                        _getIconForTab(
                          tabs[index],
                          isSelected
                              ? colorTheme.primary
                              : const Color(0xFF565555),
                        ),
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
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: _buildContentForTab(selectedIndex, training),
          ),
        ),
      ],
    );
  }

  Widget _getIconForTab(String tab, Color color) {
    switch (tab) {
      case "Overview":
        return SvgPicture.asset(
          'assets/icons/overview.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      case "Training Profile":
        return SvgPicture.asset(
          'assets/icons/training_profile.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      case "Audience Profile":
        return SvgPicture.asset(
          'assets/icons/audience_profile.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      case "Module":
        return SvgPicture.asset(
          'assets/icons/module.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      case "My Sessions":
        return SvgPicture.asset(
          'assets/icons/sessions.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      case "Content":
        return SvgPicture.asset(
          'assets/icons/content.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      default:
        return Icon(Icons.help_outline, color: color, size: 20);
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
        return Center(
          child: ModuleWidget(
            trainingId: widget.trainingId,
            trainingTitle: training.title ?? "",
          ),
        );
      case 4:
        return Center(child: MysessionsWidget(trainingId: widget.trainingId));
      case 5:
        return Center(child: ContentWidget(trainingId: widget.trainingId));
      default:
        return const Center(child: Text("No Content"));
    }
  }
}
