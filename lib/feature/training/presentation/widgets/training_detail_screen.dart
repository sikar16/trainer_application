import 'package:flutter/material.dart';
import 'package:trainer_application/core/widgets/app_drawer.dart';
import 'package:trainer_application/core/widgets/custom_appBar.dart';
import 'package:trainer_application/feature/job/presentation/pages/job_screen.dart';

class TrainingDetailScreen extends StatelessWidget {
  const TrainingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Container(child: Text("Trainig detail")),
    );
  }
}
