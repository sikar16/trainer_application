import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/module_detail_bloc/module_detail_bloc.dart';
import '../../../../core/di/injection_container.dart' as sl;
import 'module_information.dart';
import 'assessment_methods.dart';

enum TopTab { info, assessment }

class ModuleDetail extends StatelessWidget {
  final String moduleId;
  final String trainingTitle;

  const ModuleDetail({
    super.key,
    required this.moduleId,
    required this.trainingTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl.sl<ModuleDetailBloc>()..add(FetchModuleDetail(moduleId)),
      child: ModuleDetailView(trainingTitle: trainingTitle),
    );
  }
}

class ModuleDetailView extends StatefulWidget {
  final String trainingTitle;

  const ModuleDetailView({super.key, required this.trainingTitle});

  @override
  State<ModuleDetailView> createState() => _ModuleDetailViewState();
}

class _ModuleDetailViewState extends State<ModuleDetailView> {
  TopTab selectedTopTab = TopTab.info;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trainingTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/training');
            }
          },
        ),
      ),
      body: BlocBuilder<ModuleDetailBloc, ModuleDetailState>(
        builder: (context, state) {
          if (state is ModuleDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ModuleDetailError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error loading module details',
                    style: textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(state.message, style: textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final moduleId =
                          context
                              .findAncestorWidgetOfExactType<ModuleDetail>()
                              ?.moduleId ??
                          '';
                      context.read<ModuleDetailBloc>().add(
                        FetchModuleDetail(moduleId),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is ModuleDetailLoaded) {
            final module = state.moduleProfile.moduleProfile;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(16),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Text(
                  //           widget.trainingTitle,
                  //           style: textTheme.labelMedium,
                  //         ),
                  //       ),
                  //       const SizedBox(width: 10),
                  //       Text("•", style: textTheme.labelMedium),
                  //       const SizedBox(width: 10),
                  //       Expanded(
                  //         child: Text(
                  //           module.name,
                  //           style: textTheme.labelMedium,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _buildTopTabs(),
                  ),
                  const SizedBox(height: 20),
                  selectedTopTab == TopTab.info
                      ? ModuleInformation(module: module)
                      : AssessmentMethods(
                          module: module,
                          assessmentMethods: state.assessmentMethods,
                        ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTopTabs() {
    return Row(
      children: [
        _topTab('Module Information', TopTab.info),
        const SizedBox(width: 32),
        _topTab('Assessment Methods', TopTab.assessment),
      ],
    );
  }

  Widget _topTab(String title, TopTab tab) {
    final bool selected = selectedTopTab == tab;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTopTab = tab;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: selected ? primaryColor : Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            width: selected ? 120 : 0,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}
