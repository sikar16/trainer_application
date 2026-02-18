import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gheero/core/di/injection_container.dart';
import 'package:gheero/feature/auth/presentation/bloc/login_bloc.dart';
import 'package:gheero/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/training_bloc/training_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/cohort_bloc/cohort_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/trainee_bloc/trainee_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/attendance_bloc/attendance_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/session_report_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/assessment_bloc/assessment_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/survey_completion_bloc/survey_completion_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/assessment_attempt_bloc/assessment_attempt_bloc.dart';

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
        BlocProvider<SessionReportBloc>(create: (_) => sl<SessionReportBloc>()),
        BlocProvider<AssessmentBloc>(create: (_) => sl<AssessmentBloc>()),
        BlocProvider<SurveyCompletionBloc>(
          create: (_) => sl<SurveyCompletionBloc>(),
        ),
        BlocProvider<AssessmentAttemptBloc>(
          create: (_) => sl<AssessmentAttemptBloc>(),
        ),
      ],
      child: child,
    );
  }
}
