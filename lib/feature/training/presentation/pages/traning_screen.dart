import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trainer_application/core/widgets/app_drawer.dart';
import 'package:trainer_application/core/widgets/custom_appBar.dart';
import 'package:trainer_application/feature/training/presentation/widgets/custom_card.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),

      appBar: CustomAppBar(
        title: "Training",
        onMenuTap: () {
          scaffoldKey.currentState?.openDrawer();
        },
        onNotificationTap: () {},
        onProfileTap: () {},
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: CustomCard(
                traningName: 'Test training',
                locaton: 'Addis ababa',
                age: '10-15',
                time: '2 days',
                nextpage: 'View training',
                onNextTap: () {
                  context.go('/trainingDetails');
                },
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
