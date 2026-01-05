import 'package:flutter/material.dart';
import 'package:trainer_application/core/widgets/custom_dropdown.dart';
import '../../domain/entities/training_entity.dart';

class OverviewWiget extends StatelessWidget {
  final TrainingEntity? training;

  const OverviewWiget({super.key, this.training});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Overview",
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "A concise summary of the course, outlining its purpose, scope, and key features",
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                CostomDropDown(
                  title: "Basic information",
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text(training?.title ?? "N/A"),
                      const SizedBox(height: 10),
                      Text("Rationale:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text(training?.rationale ?? "N/A"),
                      const SizedBox(height: 10),
                      Text("Training Tags:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (training?.trainingTags ?? [])
                            .map(
                              (tag) => ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  tag.name,
                                  style: textTheme.bodySmall?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                CostomDropDown(
                  title: "Location",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Countries:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text(
                        training?.zones.isNotEmpty == true
                            ? training!.zones.first.region.country.name
                            : "N/A",
                      ),
                      const SizedBox(height: 20),
                      Text("Regions:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text(
                        training?.zones.isNotEmpty == true
                            ? training!.zones.first.region.name
                            : "N/A",
                      ),
                      const SizedBox(height: 20),
                      Text("Zones:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text(
                        training?.zones.isNotEmpty == true
                            ? training!.zones.map((z) => z.name).join(", ")
                            : "N/A",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                CostomDropDown(
                  title: "Training Details",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Duration:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text(
                        training != null
                            ? "${training!.duration.toStringAsFixed(training!.duration.truncateToDouble() == training!.duration ? 0 : 1)} ${training!.durationType.toLowerCase()}"
                            : "N/A",
                      ),
                      const SizedBox(height: 20),
                      Text("Delivery Method:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text(training?.deliveryMethod ?? "N/A"),
                      const SizedBox(height: 20),
                      Text("Training Type:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text(training?.trainingType?.name ?? "N/A"),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                CostomDropDown(
                  title: "Target Audience",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Participants:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text(
                        training?.totalParticipants.toString() ?? "N/A",
                        style: textTheme.bodySmall,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Gender Distribution:",
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (training?.genderPercentages ?? [])
                            .map(
                              (gp) => Text(
                                "${gp.gender} (${gp.percentage.toStringAsFixed(0)}%)",
                              ),
                            )
                            .toList(),
                      ),

                      const SizedBox(height: 20),
                      Text("Age Groups:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (training?.ageGroups ?? [])
                            .map((age) => Text(age.name))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Economic Backgrounds:",
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (training?.economicBackgrounds ?? [])
                            .map((eb) => Text(eb.name))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Academic Qualifications:",
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (training?.academicQualifications ?? [])
                            .map((aq) => Text(aq.name))
                            .toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                CostomDropDown(
                  title: "Purpose of the Training",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Training Purpose:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: (training?.trainingPurposes ?? [])
                            .map((tp) => Text(tp.name))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Certificate Description:",
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Text(training?.certificateDescription ?? "N/A"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
