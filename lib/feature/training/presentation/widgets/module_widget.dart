import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/module_bloc/module_bloc.dart';
import '../bloc/module_bloc/module_event.dart';
import '../bloc/module_bloc/module_state.dart';
import '../bloc/lesson_bloc/lesson_bloc.dart';
import '../bloc/lesson_bloc/lesson_state.dart';
import '../../domain/entities/module_entity.dart';
import '../../domain/entities/lesson_entity.dart';
import '../../domain/repositories/lesson_repository.dart';
import '../../domain/repositories/module_repository.dart';
import '../../../../core/di/injection_container.dart' as sl;
import '../../../../core/widgets/custom_dropdown.dart';
import 'lesson_details_dialog.dart';

class ModuleWidget extends StatefulWidget {
  final String trainingId;
  final String trainingTitle;

  const ModuleWidget({
    super.key,
    required this.trainingId,
    required this.trainingTitle,
  });

  @override
  State<ModuleWidget> createState() => _ModuleWidgetState();
}

class _ModuleWidgetState extends State<ModuleWidget> {
  late ModuleBloc _moduleBloc;
  late LessonBloc _lessonBloc;
  final Map<String, List<LessonEntity>> _moduleLessons = {};
  final Map<String, ModuleEntity> _moduleDetails = {};

  @override
  void initState() {
    super.initState();
    _moduleBloc = sl.sl<ModuleBloc>();
    _lessonBloc = sl.sl<LessonBloc>();
    _moduleBloc.add(FetchModules(widget.trainingId));
  }

  @override
  void dispose() {
    _moduleBloc.close();
    _lessonBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _moduleBloc),
        BlocProvider.value(value: _lessonBloc),
      ],
      child: BlocListener<LessonBloc, LessonState>(
        bloc: _lessonBloc,
        listener: (context, state) {
          if (state is LessonLoaded) {
            // We need to track which module these lessons belong to
            // For now, we'll store the latest lessons and let modules use them
            setState(() {
              // This will be updated when we implement proper module-specific tracking
            });
          }
        },
        child: BlocBuilder<ModuleBloc, ModuleState>(
          bloc: _moduleBloc,
          builder: (context, state) {
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
                            "Modules",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Text(
                          //   "A concise summary of course modules, outlining their content and structure",
                          //   style: textTheme.bodyMedium,
                          // ),
                          const SizedBox(height: 16),
                          if (state is ModuleLoading)
                            const Center(child: CircularProgressIndicator())
                          else if (state is ModuleError)
                            Center(child: Text('Error: ${state.message}'))
                          else if (state is ModuleLoaded)
                            _buildModuleList(state.modules),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildModuleList(List<ModuleEntity> modules) {
    return Column(
      children: modules.map((module) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CostomDropDown(
            title: module.name,
            groupKey: 'modules',
            content: _buildModuleContent(module),
            onTap: () {
              context.push(
                '/module-detail/${module.id}',
                extra: widget.trainingTitle,
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildModuleContent(ModuleEntity module) {
    // Fetch module details if it might have child modules
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchModuleDetailsIfNeeded(module);
    });

    return FutureBuilder(
      future: _fetchLessonsForModuleOnce(module.id),
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lessons section
            if (snapshot.connectionState == ConnectionState.waiting)
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Center(child: CircularProgressIndicator()),
                ],
              )
            else if (snapshot.hasError)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text('Error: ${snapshot.error}'),
                ],
              )
            else if (snapshot.hasData && snapshot.data!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  ...snapshot.data!.map((lesson) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () => _showLessonDetails(context, lesson),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson.name,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                lesson.objective,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'No lessons available',
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                ],
              ),

            // Child modules section
            if (_moduleDetails.containsKey(module.id)) ...[
              if (_moduleDetails[module.id]!.childModules.isNotEmpty) ...[
                const SizedBox(height: 16),

                const SizedBox(height: 8),
                ..._moduleDetails[module.id]!.childModules.map((childModule) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CostomDropDown(
                      title: childModule.name,
                      fontSize: 12,
                      groupKey: 'child-modules',
                      content: FutureBuilder(
                        future: _fetchLessonsForModuleOnce(childModule.id),
                        builder: (context, snapshot) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lessons for Sub-Module',
                                style: TextStyle(fontSize: 10),
                              ),
                              const SizedBox(height: 8),
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                const Center(child: CircularProgressIndicator())
                              else if (snapshot.hasError)
                                Text('Error: ${snapshot.error}')
                              else if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty)
                                ...snapshot.data!.map((lesson) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: InkWell(
                                      onTap: () =>
                                          _showLessonDetails(context, lesson),
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              lesson.name,
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              lesson.objective,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                              else
                                Text(
                                  'No sub-module lessons added yet',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[500],
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      onTap: () {
                        context.push(
                          '/module-detail/${childModule.id}',
                          extra: widget.trainingTitle,
                        );
                      },
                    ),
                  );
                }),
              ] else ...[
                const SizedBox(height: 16),

                const SizedBox(height: 8),
                Text(
                  'No sub-modules added yet',
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ],
            ],
          ],
        );
      },
    );
  }

  Future<List<LessonEntity>> _fetchLessonsForModuleOnce(String moduleId) async {
    if (_moduleLessons.containsKey(moduleId)) {
      return _moduleLessons[moduleId]!;
    }

    try {
      final lessonRepository = sl.sl<LessonRepository>();
      final response = await lessonRepository.getLessonsByModule(moduleId);

      _moduleLessons[moduleId] = response.lessons;
      return response.lessons;
    } catch (e) {
      return [];
    }
  }

  void _showLessonDetails(BuildContext context, LessonEntity lesson) {
    showDialog(
      context: context,
      builder: (context) => LessonDetailsDialog(lesson: lesson),
    );
  }

  Future<void> _fetchModuleDetailsIfNeeded(ModuleEntity module) async {
    if (_moduleDetails.containsKey(module.id)) {
      return;
    }

    try {
      final moduleRepository = sl.sl<ModuleRepository>();
      final response = await moduleRepository.getModuleById(module.id);

      _moduleDetails[module.id] = response.modules.first;
    } catch (e) {
      // Handle error silently for now
    }
  }
}
