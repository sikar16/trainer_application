import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onBackTap;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onMenuTap,
    this.onNotificationTap,
    this.onProfileTap,
    this.onBackTap,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(bottom: 10, left: 32, top: 5),
      // decoration: const BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)),
      //   ),
      // ),
      child: AppBar(
        backgroundColor: colorScheme.surface,

        elevation: 0,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: onBackTap ?? () => Navigator.of(context).pop(),
              )
            : null,
        title: Text(title, style: textTheme.titleMedium),
        centerTitle: false,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
