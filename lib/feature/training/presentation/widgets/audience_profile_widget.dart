import 'package:flutter/material.dart';
import 'package:trainer_application/core/widgets/custom_dropdown.dart';
import '../../domain/entities/training_entity.dart';

class AudienceProfileWidget extends StatelessWidget {
  final TrainingEntity? training;

  const AudienceProfileWidget({super.key, this.training});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Learning Level", style: textTheme.titleMedium),
                        const SizedBox(height: 10),
                        Text("Intermediate"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CostomDropDown(
                    title: "Prerequisites",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Language", style: textTheme.titleMedium),
                        const SizedBox(height: 10),
                        Text('Amharic'),
                        const SizedBox(height: 20),
                        Text("Education Level", style: textTheme.titleMedium),
                        const SizedBox(height: 10),
                        Text("Secondary School"),
                        const SizedBox(height: 20),
                        Text("Work Experience", style: textTheme.titleMedium),
                        const SizedBox(height: 10),
                        Text("Volunteer Work"),
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
