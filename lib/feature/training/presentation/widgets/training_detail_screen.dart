import 'package:flutter/material.dart';
import 'package:trainer_application/core/widgets/app_drawer.dart';
import 'package:trainer_application/core/widgets/custom_appBar.dart';
import 'package:trainer_application/feature/splash/presentation/pages/splash_screen.dart';
import 'package:trainer_application/feature/training/presentation/widgets/audience_profile_widget.dart';
import 'package:trainer_application/feature/training/presentation/widgets/content_widget.dart';
import 'package:trainer_application/feature/training/presentation/widgets/module_widget.dart';
import 'package:trainer_application/feature/training/presentation/widgets/mysessions_widget.dart';
import 'package:trainer_application/feature/training/presentation/widgets/overview_wiget.dart';
import 'package:trainer_application/feature/training/presentation/widgets/traning_profile_widget.dart';

class TrainingDetailScreen extends StatefulWidget {
  const TrainingDetailScreen({super.key});

  @override
  State<TrainingDetailScreen> createState() => _TrainingDetailScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  int selectedIndex = 0;

  final List<String> tabs = [
    "Overview",
    "Training Profile",
    "Audience Profile",
    "Module",
    "My Sessions",
    "Content",
  ];

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
        title: "Test training",
        onMenuTap: () {
          scaffoldKey.currentState?.openDrawer();
        },
        onNotificationTap: () {},
        onProfileTap: () {},
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            height: 30,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: tabs.length,
              separatorBuilder: (_, __) => const SizedBox(width: 30),
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        _getIconForTab(tabs[index]),
                        size: 20,
                        color: isSelected
                            ? colorTheme.primary
                            : colorTheme.secondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tabs[index],
                        style: TextStyle(
                          color: isSelected
                              ? colorTheme.primary
                              : colorTheme.onSurfaceVariant,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(color: Color.fromARGB(255, 218, 219, 219)),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: _buildContentForTab(selectedIndex),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForTab(String tab) {
    switch (tab) {
      case "Overview":
        return Icons.dashboard_outlined;
      case "Training Profile":
        return Icons.cast_for_education;
      case "Audience Profile":
        return Icons.group_outlined;
      case "Module":
        return Icons.view_module_outlined;
      case "My Sessions":
        return Icons.event_note_outlined;
      case "Content":
        return Icons.menu_book_outlined;
      default:
        return Icons.help_outline;
    }
  }

  Widget _buildContentForTab(int index) {
    switch (index) {
      case 0:
        return const Center(child: OverviewWiget());
      case 1:
        return const Center(child: TraningProfileWidget());
      case 2:
        return const Center(child: AudienceProfileWidget());
      case 3:
        return const Center(child: ModuleWidget());
      case 4:
        return const Center(child: MysessionsWidget());
      case 5:
        return const Center(child: ContentWidget());
      default:
        return const Center(child: Text("No Content"));
    }
  }
}
