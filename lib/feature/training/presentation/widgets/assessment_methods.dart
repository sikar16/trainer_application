import 'package:flutter/material.dart';
import 'package:gheero/core/widgets/custom_dropdown.dart';
import '../../domain/entities/module_detail_entity.dart';

class AssessmentMethods extends StatelessWidget {
  final ModuleDetailEntity module;
  final ModuleAssessmentMethodsEntity assessmentMethods;

  const AssessmentMethods({
    super.key,
    required this.module,
    required this.assessmentMethods,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final formativeAssessments = assessmentMethods.assessmentMethods
        .where((method) => method.assessmentSubType == 'FORMATIVE')
        .toList();
    final summativeAssessments = assessmentMethods.assessmentMethods
        .where((method) => method.assessmentSubType == 'SUMMATIVE')
        .toList();

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Assessment Methods",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Methods used to evaluate learning progress and outcomes.",
                      style: textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 16),
                    CostomDropDown(
                      title: "Formative Assessments",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (formativeAssessments.isEmpty)
                            Text(
                              "No formative assessments available",
                              style: textTheme.bodyMedium,
                            )
                          else
                            ...formativeAssessments.map(
                              (assessment) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("•"),
                                    Expanded(
                                      child: Text(
                                        assessment.name,
                                        style: textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    CostomDropDown(
                      title: "Summative Assessments",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (summativeAssessments.isEmpty)
                            Text(
                              "No summative assessments available",
                              style: textTheme.bodyMedium,
                            )
                          else
                            ...summativeAssessments.map(
                              (assessment) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("• "),
                                    Expanded(
                                      child: Text(
                                        assessment.name,
                                        style: textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    CostomDropDown(
                      title: "Other Assessments",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("• "),
                              Expanded(
                                child: Text(
                                  "No other assessments available",
                                  style: textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
