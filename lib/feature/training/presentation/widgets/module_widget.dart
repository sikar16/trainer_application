import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/module_bloc.dart';
import '../../domain/entities/module_entity.dart';
import '../../../../core/di/injection_container.dart' as sl;
import '../../../../core/widgets/custom_dropdown.dart';

class ModuleWidget extends StatefulWidget {
  const ModuleWidget({super.key});

  @override
  State<ModuleWidget> createState() => _ModuleWidgetState();
}

class _ModuleWidgetState extends State<ModuleWidget> {
  late ModuleBloc _moduleBloc;
  static const String trainingId = 'd4daffc5-7606-4787-b7af-406fce2e61c3';

  @override
  void initState() {
    super.initState();
    _moduleBloc = sl.sl<ModuleBloc>();
    _moduleBloc.add(FetchModules(trainingId));
  }

  @override
  void dispose() {
    _moduleBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

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
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  module.description,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                if (module.trainingTag.name.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      module.trainingTag.name,
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                if (module.trainingTag.description.isNotEmpty)
                  Text(
                    module.trainingTag.description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
