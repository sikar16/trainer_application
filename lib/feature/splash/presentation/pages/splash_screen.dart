import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    goToHome();
  }

  Future<void> goToHome() async {
    await Future.delayed(const Duration(seconds: 3)); // 3 seconds splash
    if (mounted) context.go('/login'); // navigate to home
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('asset/images/logo.png', width: 200, height: 100),
            const SizedBox(height: 10),
            SizedBox(width: 30, height: 30, child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
