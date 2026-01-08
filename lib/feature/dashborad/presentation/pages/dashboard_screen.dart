import 'package:flutter/material.dart';
import 'package:trainer_application/core/widgets/app_drawer.dart';
import 'package:trainer_application/core/widgets/custom_appbar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),

      appBar: CustomAppBar(
        title: "Dashboard",
        onMenuTap: () {
          scaffoldKey.currentState?.openDrawer();
        },
        onNotificationTap: () {},
        onProfileTap: () {},
      ),

      body: const Center(child: Text("Dashboard Content")),
    );
  }
}
