import 'package:flutter/material.dart';
import 'package:gheero/core/widgets/custom_dropdown.dart';
import '../../domain/entities/module_detail_entity.dart';

class ModuleInformation extends StatelessWidget {
  final ModuleDetailEntity module;

  const ModuleInformation({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Module Information",
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Detailed information about the module's content, teaching methods, and resources.",
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    CostomDropDown(
                      title: "Key Concepts",
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            module.keyConcepts.isNotEmpty
                                ? module.keyConcepts
                                : "No key concepts available",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    CostomDropDown(
                      title: "Learning Resources",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Primary Materials",
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          ...module.primaryMaterials.map(
                            (material) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: colorTheme.primary,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      material.isNotEmpty
                                          ? material
                                          : "Not specified",
                                      style: textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Secondary Materials",
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          ...module.secondaryMaterials.map(
                            (material) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: colorTheme.primary,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      material.isNotEmpty
                                          ? material
                                          : "Not specified",
                                      style: textTheme.bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("Digital Tools", style: textTheme.titleMedium),
                          const SizedBox(height: 10),
                          ...module.digitalTools.map(
                            (tool) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: colorTheme.primary,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      tool.isNotEmpty ? tool : "Not specified",
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

                    //Instructional Methods
                    CostomDropDown(
                      title: "Instructional Methods",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Methods", style: textTheme.titleMedium),
                          const SizedBox(height: 10),
                          Text(
                            module.instructionMethods
                                .map((method) => method.name)
                                .join(', '),
                            style: textTheme.bodyMedium,
                          ),

                          const SizedBox(height: 10),
                          Text(
                            "Technology Integration",
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(12),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(module.technologyIntegration.name),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Differentiation Strategies",
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            module.differentationStrategies.isNotEmpty
                                ? module.differentationStrategies
                                : "No differentiation strategies available",
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    CostomDropDown(
                      title: "Teaching Strategies",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            module.teachingStrategy.isNotEmpty
                                ? module.teachingStrategy
                                : "No teaching strategies available",
                            style: textTheme.bodyMedium,
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    CostomDropDown(
                      title: "Inclusion Strategies",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            module.inclusionStrategy.isNotEmpty
                                ? module.inclusionStrategy
                                : "No inclusion strategies available",
                            style: textTheme.bodyMedium,
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    CostomDropDown(
                      title: "Estimated Duration",
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${module.duration.toStringAsFixed(0)} ${module.durationType.toLowerCase()}",
                            style: textTheme.bodyMedium,
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
      ),
    );
    ;
  }
}
