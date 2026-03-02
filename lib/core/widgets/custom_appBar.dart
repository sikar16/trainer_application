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
    return Container(
      // margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      // decoration: const BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(color: Color.fromARGB(255, 210, 210, 210)),
      //   ),
      // ),
      child: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        toolbarHeight: 40,
        leadingWidth: 30,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.navigate_before),
                onPressed:
                    onBackTap ??
                    () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go('/training');
                      }
                    },
              )
            : null,
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
