import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gheero/core/widgets/custom_dropdown.dart';
import '../../domain/entities/training_entity.dart';
import '../../domain/entities/audience_profile_entity.dart';
import '../../domain/usecases/get_audience_profile_usecase.dart';
import '../bloc/audience_profile_bloc/audience_profile_bloc.dart';
import '../../../../core/di/injection_container.dart' as sl;

class AudienceProfileWidget extends StatefulWidget {
  final TrainingEntity? training;

  const AudienceProfileWidget({super.key, this.training});

  @override
  State<AudienceProfileWidget> createState() => _AudienceProfileWidgetState();
}

class _AudienceProfileWidgetState extends State<AudienceProfileWidget> {
  late AudienceProfileBloc _audienceProfileBloc;

  @override
  void initState() {
    super.initState();
    _audienceProfileBloc = AudienceProfileBloc(
      sl.sl<GetAudienceProfileUseCase>(),
    );
    if (widget.training?.id != null) {
      _audienceProfileBloc.add(FetchAudienceProfile(widget.training!.id));
    }
  }

  @override
  void dispose() {
    _audienceProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<AudienceProfileBloc, AudienceProfileState>(
      bloc: _audienceProfileBloc,
      builder: (context, state) {
        if (state is AudienceProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AudienceProfileError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is AudienceProfileLoaded) {
          return _buildProfileContent(
            context,
            state.audienceProfile,
            textTheme,
          );
        }
        return _buildProfileContent(context, null, textTheme);
      },
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    AudienceProfileResponseEntity? audienceProfile,
    TextTheme textTheme,
  ) {
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
                    "Audience Profile",
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "A concise summary of the course audience, outlining their learning level and prerequisites",
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  CostomDropDown(
                    title: "Learner Characteristics",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Learning Level",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (audienceProfile
                                ?.audienceProfile
                                ?.learnerLevel
                                ?.name !=
                            null)
                          Text(
                            audienceProfile!
                                .audienceProfile!
                                .learnerLevel!
                                .name!,
                            style: textTheme.bodyLarge,
                          ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CostomDropDown(
                    title: "Prerequisites",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Language",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (audienceProfile?.audienceProfile?.language?.name !=
                            null)
                          Text(
                            audienceProfile!.audienceProfile!.language!.name!,
                            style: textTheme.bodyLarge,
                          ),
                        const SizedBox(height: 20),

                        Text(
                          "Education Level",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (audienceProfile
                                ?.audienceProfile
                                ?.educationLevel
                                ?.name !=
                            null)
                          Text(
                            audienceProfile!
                                .audienceProfile!
                                .educationLevel!
                                .name!,
                            style: textTheme.bodyLarge,
                          ),
                        const SizedBox(height: 20),

                        Text(
                          "Work Experience",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (audienceProfile
                                ?.audienceProfile
                                ?.workExperience
                                ?.name !=
                            null)
                          Text(
                            audienceProfile!
                                .audienceProfile!
                                .workExperience!
                                .name!,
                            style: textTheme.bodyLarge,
                          ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
