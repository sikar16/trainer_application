import 'package:flutter/material.dart';
import 'package:trainer_application/core/widgets/custom_dropdown.dart';

class TraningProfileWidget extends StatelessWidget {
  const TraningProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                  "Traning Profile",
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "The Training Profile section is designed to provide a comprehensive overview of a training program.",
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                CostomDropDown(
                  title: "Keywords",
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 232, 232, 232),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Test key word 1",
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.black, // text color
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 232, 232, 232),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Test key word 1",
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.black, // text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                CostomDropDown(
                  title: "Scope",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("Scope", style: textTheme.bodyLarge)],
                  ),
                ),
                const SizedBox(height: 16),

                CostomDropDown(
                  title: "Attendance Requirement",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "100% minimum attendance required",
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                CostomDropDown(
                  title: "Assessment Result Requirement",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "100% minimum assessment result required",
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                CostomDropDown(
                  title: "Competency Outcomes",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Test", style: textTheme.bodyLarge)],
                  ),
                ),
                const SizedBox(height: 16),

                CostomDropDown(
                  title: "Alignment with Standard",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "EDGE training standard guideline",
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                CostomDropDown(
                  title: "Prior Knowledge",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "No prior knowledge required",
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                CostomDropDown(
                  title: "Learning Style Preferences",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Auditory", style: textTheme.bodyLarge),
                      SizedBox(height: 5),
                      Text("Reading/Writing", style: textTheme.bodyLarge),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                CostomDropDown(
                  title: "Delivery Tools",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Instructor-Led Training (ILT)",
                        style: textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 5),
                      Text("Self-Paced Learning", style: textTheme.bodyLarge),
                      const SizedBox(height: 5),
                      Text(
                        "Collaborative & Social Learning",
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                CostomDropDown(
                  title: "Technological Requirements",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("For Learners", style: textTheme.bodyLarge),
                      const SizedBox(height: 5),
                      Text("Self-Paced Learning", style: textTheme.bodyLarge),
                      const SizedBox(height: 5),
                      Text(
                        "Collaborative & Social Learning",
                        style: textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                CostomDropDown(
                  title: "Training Objectives",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("General Objective", style: textTheme.titleMedium),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: const [
                          Text("No general objective available"),
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
    );
  }
}
