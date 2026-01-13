import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:training/core/widgets/showLogoutWarningDialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Image.asset('asset/images/gheero.png', width: 60, height: 60),
                Image.asset('asset/images/gheeroH.png', width: 70, height: 50),
              ],
            ),
            ListTile(
              leading: const Icon(Icons.dashboard_outlined),
              title: const Text('Dashboard'),
              onTap: () {
                context.go('/dashboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.cast_for_education),
              title: const Text('Training'),
              onTap: () {
                context.go('/training');
              },
            ),
            ListTile(
              leading: const Icon(Icons.work_outline),
              title: const Text('Job'),
              onTap: () {
                context.go('/job');
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () {
                context.go('/setting');
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
              onTap: () {
                showLogoutWarningDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
