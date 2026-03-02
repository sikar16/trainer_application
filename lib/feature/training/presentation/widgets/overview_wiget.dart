import 'package:flutter/material.dart';
import 'package:gheero/core/widgets/custom_dropdown.dart';
import '../../domain/entities/training_entity.dart';
import 'package:intl/intl.dart';

class OverviewWiget extends StatelessWidget {
  final TrainingEntity? training;

  const OverviewWiget({super.key, this.training});

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    String formatDate(String? date) {
      if (date == null || date.isEmpty) return "N/A";
      final parsedDate = DateTime.parse(date);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    }

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Overview",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 16),
                  CostomDropDown(
                    title: "Basic information",
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          training?.title ?? "N/A",
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Rationale:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          training?.rationale ?? "N/A",
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Training Tags:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (training?.trainingTags ?? [])
                              .map(
                                (tag) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorTheme.surfaceContainer,
                                    border: Border.all(
                                      color: colorTheme.surfaceContainer,
                                    ),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: Text(
                                    tag.name,
                                    style: TextStyle(fontSize: 10),
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
                        Text(
                          "Countries:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          training?.zones.isNotEmpty == true
                              ? training!.zones.first.region.country.name
                              : "N/A",
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Regions:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          training?.zones.isNotEmpty == true
                              ? training!.zones.first.region.name
                              : "N/A",
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Zones:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          training?.zones.isNotEmpty == true
                              ? training!.zones.map((z) => z.name).join(", ")
                              : "N/A",
                          style: TextStyle(fontSize: 12),
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
                        Text(
                          "Duration:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          training != null
                              ? "${training!.duration.toStringAsFixed(training!.duration.truncateToDouble() == training!.duration ? 0 : 1)} ${training!.durationType.toLowerCase()}"
                              : "N/A",
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Delivery Method:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          training?.deliveryMethod ?? "N/A",
                          style: TextStyle(fontSize: 12),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          "Start Date:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          formatDate(training?.startDate),
                          style: TextStyle(fontSize: 12),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          "End Date:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          formatDate(training?.endDate),
                          style: TextStyle(fontSize: 12),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          "Training Type:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          training?.trainingType?.name ?? "N/A",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  CostomDropDown(
                    title: "Target Audience",
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Participants:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          training?.totalParticipants.toString() ?? "N/A",
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Gender Distribution:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
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
                        Text(
                          "Age Groups:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          children: (training?.ageGroups ?? [])
                              .asMap()
                              .entries
                              .map(
                                (entry) => Text(
                                  entry.key == 0
                                      ? entry.value.name
                                      : ', ${entry.value.name}',
                                ),
                              )
                              .toList(),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          "Economic Backgrounds:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (training?.economicBackgrounds ?? [])
                              .map((eb) => eb.name)
                              .join(', '),
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Academic Qualifications:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (training?.academicQualifications ?? [])
                              .map((aq) => aq.name)
                              .join(', '),
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Disability Distribution:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (training?.disabilityPercentages ?? [])
                              .map(
                                (dp) => Text(
                                  "${dp.disability.name} (${dp.percentage.toStringAsFixed(0)}%)",
                                ),
                              )
                              .toList(),
                        ),

                        const SizedBox(height: 20),
                        Text(
                          "Marginalized Groups:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          children: (training?.marginalizedGroupPercentages ?? [])
                              .asMap()
                              .entries
                              .map(
                                (entry) => Text(
                                  entry.key == 0
                                      ? "${entry.value.group.name} (${entry.value.percentage.toStringAsFixed(1)}%)"
                                      : ", ${entry.value.group.name} (${entry.value.percentage.toStringAsFixed(1)}%)",
                                ),
                              )
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
                        Text(
                          "Training Purpose:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (training?.trainingPurposes ?? [])
                              .map(
                                (tp) => Text(
                                  tp.name,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Certificate Description:",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          training?.certificateDescription ?? "N/A",
                          style: TextStyle(fontSize: 12),
                        ),
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
