import 'package:go_router/go_router.dart';
import 'package:gheero/core/router/error_page.dart';
import 'package:gheero/core/storage/storage_service.dart';
import 'package:gheero/feature/auth/presentation/pages/login_screen.dart';
import 'package:gheero/feature/dashborad/presentation/pages/dashboard_screen.dart';
import 'package:gheero/feature/job/presentation/pages/job_screen.dart';
import 'package:gheero/feature/profile/presentation/pages/profile_screen.dart';
import 'package:gheero/feature/setting/presentation/pages/setting_screen.dart';
import 'package:gheero/feature/splash/presentation/pages/splash_screen.dart';
import 'package:gheero/feature/training/presentation/pages/traning_screen.dart';
import 'package:gheero/feature/job/presentation/widgets/job_detail_screen.dart';
import 'package:gheero/feature/training/presentation/widgets/module_detail.dart';
import 'package:gheero/feature/training/presentation/widgets/training_detail_screen.dart';

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
    //module-detail
    GoRoute(
      path: '/module-detail/:moduleId',
      name: "module-detail",
      builder: (context, state) {
        final trainingTitle = state.extra as String? ?? '';
        return ModuleDetail(
          moduleId: state.pathParameters['moduleId']!,
          trainingTitle: trainingTitle,
        );
      },
    ),
    GoRoute(
      path: '/job_detail/:jobId',
      name: "job_detail",
      builder: (context, state) {
        final isApplied = state.uri.queryParameters['applied'] == 'true';
        return JobDetailScreen(
          jobId: state.pathParameters['jobId']!,
          isApplied: isApplied,
        );
      },
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
