import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training/core/di/injection_container.dart';
import 'package:training/feature/auth/presentation/bloc/login_bloc.dart';
import 'package:training/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:training/feature/training/presentation/bloc/training_bloc/training_bloc.dart';
import 'package:training/feature/training/presentation/bloc/cohort_bloc/cohort_bloc.dart';
import 'package:training/feature/training/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:training/feature/training/presentation/bloc/trainee_bloc/trainee_bloc.dart';
import 'package:training/feature/training/presentation/bloc/attendance_bloc/attendance_bloc.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;

  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LoginBloc>()),
        BlocProvider<ProfileBloc>(create: (_) => sl<ProfileBloc>()),
        BlocProvider<TrainingBloc>(create: (_) => sl<TrainingBloc>()),
        BlocProvider<CohortBloc>(create: (_) => sl<CohortBloc>()),
        BlocProvider<SessionBloc>(create: (_) => sl<SessionBloc>()),
        BlocProvider<TraineeBloc>(create: (_) => sl<TraineeBloc>()),
        BlocProvider<AttendanceBloc>(create: (_) => sl<AttendanceBloc>()),
      ],
      child: child,
    );
  }
}
