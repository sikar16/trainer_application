import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final VoidCallback? onBackTap;
  final bool showBackButton;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onMenuTap,
    this.onNotificationTap,
    this.onProfileTap,
    this.onBackTap,
    this.showBackButton = false,
    this.automaticallyImplyLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: automaticallyImplyLeading,
          titleSpacing: 0,
          leading: showBackButton
              ? IconButton(
                  icon: const Icon(Icons.navigate_before),
                  onPressed:
                      onBackTap ??
                      () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.push('/training');
                        }
                      },
                )
              : null,
          title: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),

          centerTitle: false,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
