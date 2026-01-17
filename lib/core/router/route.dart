import 'package:go_router/go_router.dart';
import 'package:training/core/router/error_page.dart';
import 'package:training/core/storage/storage_service.dart';
import 'package:training/feature/auth/presentation/pages/login_screen.dart';
import 'package:training/feature/dashborad/presentation/pages/dashboard_screen.dart';
import 'package:training/feature/job/presentation/pages/job_screen.dart';
import 'package:training/feature/profile/presentation/pages/profile_screen.dart';
import 'package:training/feature/setting/presentation/pages/setting_screen.dart';
import 'package:training/feature/splash/presentation/pages/splash_screen.dart';
import 'package:training/feature/training/presentation/pages/traning_screen.dart';
import 'package:training/feature/job/presentation/widgets/job_detail_screen.dart';
import 'package:training/feature/training/presentation/widgets/training_detail_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  // Error page
  errorBuilder: (context, state) => ErrorPage(error: state.error),
  redirect: (context, state) async {
    final token = await StorageService.getToken();
    if (token == null) return '/login';
    if (state.path == '/splash') return null;
    return null;
  },
  routes: [
    // public routes
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
    // private routes
    GoRoute(
      path: '/dashboard',
      name: "dashboard",
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/training',
      name: "training",
      builder: (context, state) => const TrainingScreen(),
    ),
    GoRoute(
      path: '/job_detail',
      name: "job_detail",
      builder: (context, state) => const JobDetailScreen(),
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
    GoRoute(
      path: '/trainingDetails/:id',
      name: "trainingDetails",
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return TrainingDetailScreen(trainingId: id);
      },
    ),
  ],
);
