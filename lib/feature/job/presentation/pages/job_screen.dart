import 'package:flutter/material.dart';
import 'package:training/core/widgets/app_drawer.dart';
import 'package:training/core/widgets/custom_appbar.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _JobScreenState extends State<JobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),

      appBar: CustomAppBar(
        title: "Job",
        onMenuTap: () {
          scaffoldKey.currentState?.openDrawer();
        },
        onNotificationTap: () {},
        onProfileTap: () {},
      ),

      body: SizedBox(child: Text("Job screen")),
    );
  }
}
