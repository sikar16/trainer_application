import 'package:flutter/material.dart';
import 'package:trainer_application/core/widgets/custom_dropdown.dart';

class OverviewWiget extends StatelessWidget {
  const OverviewWiget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
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
                      SizedBox(height: 10),
                      Text("Test Training"),
                      SizedBox(height: 10),
                      Text("Rationale:", style: textTheme.titleMedium),
                      SizedBox(height: 10),
                      Text("Test Training"),
                      SizedBox(height: 10),
                      Text("Training Tags:", style: textTheme.titleMedium),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Soft Skill",
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Digital Literacy",
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Financial Literacy",
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Data Induction",
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
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
                      Text("Ethiopia:"),

                      const SizedBox(height: 20),
                      Text("Regions:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text("Addis Ababa City Administration"),
                      const SizedBox(height: 20),
                      Text("Zones:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text(
                        "Nifas Silk Lafto Sub City, Yeka Sub City, Bole Sub City",
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
                      Text("Addis Ababa City Administration"),

                      const SizedBox(height: 20),
                      Text("Delivery Method:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text("Blended"),

                      const SizedBox(height: 20),
                      Text("Training Type:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Text("AShort Term Training"),
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
                      Text("50", style: textTheme.bodySmall),
                      const SizedBox(height: 20),

                      Text(
                        "Gender Distribution:",
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: const [
                          Text("Male (50%)"),
                          Text("Female (50%)"),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Text("Age Groups:", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: const [
                          Text("15-17 Years"),
                          Text("18-24 Years"),
                        ],
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
                        children: const [
                          Text("Informal Economy / Subsistence Living"),
                          Text("Rural Economy Dependent"),
                        ],
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
                        children: const [
                          Text("TVET Certificate"),
                          Text("Secondary School"),
                          Text("Middle School"),
                          Text("Informal Education"),
                        ],
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
                        children: const [Text("Skill Development")],
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
                        children: const [Text("N/A")],
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
