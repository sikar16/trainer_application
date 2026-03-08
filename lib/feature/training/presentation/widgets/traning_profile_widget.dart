import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gheero/core/widgets/custom_dropdown.dart';
import '../../domain/entities/training_entity.dart';
import '../../domain/entities/training_profile_entity.dart';
import '../../domain/usecases/get_training_profile_usecase.dart';
import '../bloc/training_profile_bloc/training_profile_bloc.dart';
import '../../../../core/di/injection_container.dart' as sl;

class TraningProfileWidget extends StatefulWidget {
  final TrainingEntity? training;

  const TraningProfileWidget({super.key, this.training});

  @override
  State<TraningProfileWidget> createState() => _TraningProfileWidgetState();
}

class _TraningProfileWidgetState extends State<TraningProfileWidget> {
  late TrainingProfileBloc _trainingProfileBloc;

  @override
  void initState() {
    super.initState();
    _trainingProfileBloc = TrainingProfileBloc(
      sl.sl<GetTrainingProfileUseCase>(),
    );
    if (widget.training?.id != null) {
      _trainingProfileBloc.add(FetchTrainingProfile(widget.training!.id));
    }
  }

  @override
  void dispose() {
    _trainingProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TrainingProfileBloc, TrainingProfileState>(
      bloc: _trainingProfileBloc,
      builder: (context, state) {
        if (state is TrainingProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TrainingProfileError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is TrainingProfileLoaded) {
          return _buildProfileContent(
            context,
            state.trainingProfile,
            textTheme,
          );
        }
        return _buildProfileContent(context, null, textTheme);
      },
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    TrainingProfileResponseEntity? trainingProfile,
    TextTheme textTheme,
  ) {
    final colorTheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Traning Profile",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  CostomDropDown(
                    title: "Keywords",
                    content: trainingProfile != null
                        ? Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: trainingProfile.trainingProfile.keywords
                                .map(
                                  (keyword) => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorTheme.surfaceContainer,
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    child: Text(
                                      keyword,
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    232,
                                    232,
                                    232,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    232,
                                    232,
                                    232,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                  ),

                  const SizedBox(height: 8),
                  CostomDropDown(
                    title: "Scope",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          trainingProfile?.trainingProfile.scope ?? "",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  CostomDropDown(
                    title: "Attendance Requirement",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${trainingProfile?.trainingProfile.attendanceRequirementPercentage ?? 100}% minimum attendance required",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  CostomDropDown(
                    title: "Assessment Result Requirement",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${trainingProfile?.trainingProfile.assessmentResultPercentage ?? 100}% minimum assessment result required",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  CostomDropDown(
                    title: "Competency Outcomes",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trainingProfile
                                  ?.trainingProfile
                                  .professionalBackground ??
                              '',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  CostomDropDown(
                    title: "Alignment with Standard",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          (trainingProfile
                                      ?.trainingProfile
                                      .alignmentsWithStandard ??
                                  [])
                              .map(
                                (alignment) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "• ",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Expanded(
                                        child: Text(
                                          alignment.name,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  const SizedBox(height: 8),

                  CostomDropDown(
                    title: "Prior Knowledge",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trainingProfile
                                      ?.trainingProfile
                                      .priorKnowledgeList
                                      .isEmpty ==
                                  false
                              ? trainingProfile!
                                    .trainingProfile
                                    .priorKnowledgeList
                                    .join(", ")
                              : "No prior knowledge required",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  CostomDropDown(
                    title: "Learning Style Preferences",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          (trainingProfile
                                      ?.trainingProfile
                                      .learnerStylePreferences ??
                                  [])
                              .map(
                                (style) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "• ",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Expanded(
                                        child: Text(
                                          style.name,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  const SizedBox(height: 8),

                  CostomDropDown(
                    title: "Delivery Tools",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          (trainingProfile?.trainingProfile.deliveryTools ?? [])
                              .map(
                                (tool) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "• ",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Expanded(
                                        child: Text(
                                          tool.name,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                  ),
                  const SizedBox(height: 8),

                  CostomDropDown(
                    title: "Technological Requirements",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "For Learners",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        if (trainingProfile
                                ?.trainingProfile
                                .learnerTechnologicalRequirements !=
                            null)
                          ...trainingProfile!
                              .trainingProfile
                              .learnerTechnologicalRequirements
                              .map(
                                (req) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("• ", style: textTheme.bodyLarge),
                                      Expanded(
                                        child: Text(
                                          req.name,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),

                        const SizedBox(height: 30),

                        Text(
                          "For Instructors",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        if (trainingProfile
                                ?.trainingProfile
                                .instructorTechnologicalRequirements !=
                            null)
                          ...trainingProfile!
                              .trainingProfile
                              .instructorTechnologicalRequirements
                              .map(
                                (req) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("• ", style: textTheme.bodyLarge),
                                      Expanded(
                                        child: Text(
                                          req.name,
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  CostomDropDown(
                    title: "Training Objectives",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "General Objective",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: const [
                            Text(
                              "No general objective available",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
