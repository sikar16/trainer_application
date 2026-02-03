import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/module_bloc/module_bloc.dart';
import '../bloc/module_bloc/module_event.dart';
import '../bloc/module_bloc/module_state.dart';
import '../../domain/entities/module_entity.dart';
import '../../../../core/di/injection_container.dart' as sl;
import '../../../../core/widgets/custom_dropdown.dart';

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

  @override
  void initState() {
    super.initState();
    _moduleBloc = sl.sl<ModuleBloc>();
    _moduleBloc.add(FetchModules(widget.trainingId));
  }

  @override
  void dispose() {
    _moduleBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ModuleBloc, ModuleState>(
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
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "A concise summary of course modules, outlining their content and structure",
                        style: textTheme.bodyMedium,
                      ),
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
    );
  }

  Widget _buildModuleList(List<ModuleEntity> modules) {
    return Column(
      children: modules.map((module) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CostomDropDown(
            title: module.name,
            onTap: () {
              context.go(
                '/module-detail/${module.id}',
                extra: widget.trainingTitle,
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
