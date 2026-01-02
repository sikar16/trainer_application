import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScrollViewWidget extends StatelessWidget {
  const ScrollViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _scrollItem(
                context,
                icon: Icons.dashboard_outlined,
                label: "Overview",
                route: '/overview',
              ),
              const SizedBox(width: 40),
              _scrollItem(
                context,
                icon: Icons.school_outlined, // training/education
                label: "Training Profile",
                route: '/training-profile',
              ),
              const SizedBox(width: 40),
              _scrollItem(
                context,
                icon: Icons.group_outlined, // audience
                label: "Audience Profile",
                route: '/audience-profile',
              ),
              const SizedBox(width: 40),
              _scrollItem(
                context,
                icon: Icons.view_module_outlined, // module
                label: "Module",
                route: '/module',
              ),
              const SizedBox(width: 40),
              _scrollItem(
                context,
                icon: Icons.event_note_outlined, // my sessions
                label: "My Sessions",
                route: '/my-sessions',
              ),
              const SizedBox(width: 40),
              _scrollItem(
                context,
                icon: Icons.menu_book_outlined, // content
                label: "Content",
                route: '/content',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _scrollItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => context.go(route),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorTheme.primary),
          const SizedBox(width: 10),
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(color: colorTheme.primary),
          ),
        ],
      ),
    );
  }
}
