import 'package:go_router/go_router.dart';
import 'package:trainer_application/feature/auth/presentation/login_screen.dart';
import 'package:trainer_application/feature/dashborad/presentation/dashboard_screen.dart';
import 'package:trainer_application/feature/splash/presentation/splash_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: "splash",
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: "login",
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: "dashboard",
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);
