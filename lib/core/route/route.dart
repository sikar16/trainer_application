import 'package:go_router/go_router.dart';
import 'package:trainer_application/feature/auth/presentation/pages/login_screen.dart';
import 'package:trainer_application/feature/dashborad/presentation/pages/dashboard_screen.dart';
import 'package:trainer_application/feature/job/presentation/pages/job_screen.dart';
import 'package:trainer_application/feature/profile/presentation/pages/profile_screen.dart';
import 'package:trainer_application/feature/setting/presentation/pages/setting_screen.dart';
import 'package:trainer_application/feature/splash/presentation/pages/splash_screen.dart';
import 'package:trainer_application/feature/training/presentation/pages/traning_screen.dart';

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
    GoRoute(
      path: '/training',
      name: "training",
      builder: (context, state) => const TraningScreen(),
    ),
    GoRoute(
      path: '/job',
      name: "job",
      builder: (context, state) => const JobScreen(),
    ),
    GoRoute(
      path: '/setting',
      name: "setting",
      builder: (context, state) => const SettingScreen(),
    ),
    GoRoute(
      path: '/profile',
      name: "profile",
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
