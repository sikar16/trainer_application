import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gheero/core/widgets/show_logout_warning_dialog.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: const AppMenu(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with logo
          Row(
            children: [
              Image.asset('assets/images/gheero.png', width: 40, height: 40),
              const SizedBox(width: 8),
              Image.asset('assets/images/gheeroH.png', width: 50, height: 35),
            ],
          ),
          const SizedBox(height: 20),

          // Menu items
          _MenuItem(
            icon: Icons.cast_for_education,
            title: 'Trainings',
            onTap: () => context.push('/training'),
          ),
          _MenuItem(
            icon: Icons.work_outline,
            title: 'Job',
            onTap: () => context.push('/job'),
          ),
          _MenuItem(
            icon: Icons.person_outline,
            title: 'Profile',
            onTap: () => context.push('/profile'),
          ),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          // Logout
          _MenuItem(
            icon: Icons.logout_outlined,
            title: 'Logout',
            onTap: () => showLogoutWarningDialog(context),
            isLogout: true,
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: isLogout ? Colors.red : Colors.grey[700],
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: isLogout ? Colors.red : Colors.black87,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isLogout ? Colors.red : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
