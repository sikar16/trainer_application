import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Drawer(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 100, horizontal: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Image.asset('asset/images/logo.png', width: 100, height: 100),
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
          ],
        ),
      ),
    );
  }
}
