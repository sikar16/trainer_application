import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trainer_application/core/route/route.dart';
import 'package:trainer_application/core/theme/theme.dart';
import 'package:trainer_application/core/theme/util.dart';

import 'package:trainer_application/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:trainer_application/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:trainer_application/feature/auth/domain/usecases/login_usecase.dart';
import 'package:trainer_application/feature/auth/presentation/bloc/login_bloc.dart';
import 'package:trainer_application/feature/profile/data/datasources/profile_remote_data_source.dart';
import 'package:trainer_application/feature/profile/data/repositories/profile_repository_impl.dart';
import 'package:trainer_application/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:trainer_application/feature/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:trainer_application/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:trainer_application/feature/training/data/datasources/training_remote_data_source.dart';
import 'package:trainer_application/feature/training/data/datasources/cohort_remote_data_source.dart';
import 'package:trainer_application/feature/training/data/datasources/session_remote_data_source.dart';
import 'package:trainer_application/feature/training/data/datasources/trainee_remote_data_source.dart';
import 'package:trainer_application/feature/training/data/datasources/attendance_remote_data_source.dart';
import 'package:trainer_application/feature/training/data/repositories/training_repository_impl.dart';
import 'package:trainer_application/feature/training/data/repositories/cohort_repository_impl.dart';
import 'package:trainer_application/feature/training/data/repositories/session_repository_impl.dart';
import 'package:trainer_application/feature/training/data/repositories/trainee_repository_impl.dart';
import 'package:trainer_application/feature/training/data/repositories/attendance_repository_impl.dart';
import 'package:trainer_application/feature/training/domain/usecases/get_trainings_usecase.dart';
import 'package:trainer_application/feature/training/domain/usecases/get_training_by_id_usecase.dart';
import 'package:trainer_application/feature/training/domain/usecases/get_cohorts_usecase.dart';
import 'package:trainer_application/feature/training/domain/usecases/get_sessions_by_cohort_usecase.dart';
import 'package:trainer_application/feature/training/domain/usecases/get_trainees_by_cohort_usecase.dart';
import 'package:trainer_application/feature/training/domain/usecases/get_attendance_by_session_usecase.dart';
import 'package:trainer_application/feature/training/domain/usecases/save_attendance_usecase.dart';
import 'package:trainer_application/feature/training/presentation/bloc/training_bloc/training_bloc.dart';
import 'package:trainer_application/feature/training/presentation/bloc/cohort_bloc/cohort_bloc.dart';
import 'package:trainer_application/feature/training/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:trainer_application/feature/training/presentation/bloc/trainee_bloc/trainee_bloc.dart';
import 'package:trainer_application/feature/training/presentation/bloc/attendance_bloc/attendance_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    final textTheme = createTextTheme(context, "Roboto", "Roboto");
    final MaterialTheme theme = MaterialTheme(textTheme);

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(
            LoginUseCase(AuthRepositoryImpl(AuthRemoteDataSource())),
          ),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(
            getProfileUseCase: GetProfileUseCase(
              ProfileRepositoryImpl(ProfileRemoteDataSource()),
            ),
            editProfileUseCase: EditProfileUseCase(
              ProfileRepositoryImpl(ProfileRemoteDataSource()),
            ),
          ),
        ),
        BlocProvider<TrainingBloc>(
          create: (_) => TrainingBloc(
            getTrainingsUseCase: GetTrainingsUseCase(
              TrainingRepositoryImpl(TrainingRemoteDataSource()),
            ),
            getTrainingByIdUseCase: GetTrainingByIdUseCase(
              TrainingRepositoryImpl(TrainingRemoteDataSource()),
            ),
          ),
        ),
        BlocProvider<CohortBloc>(
          create: (_) => CohortBloc(
            getCohortsUseCase: GetCohortsUseCase(
              CohortRepositoryImpl(CohortRemoteDataSource()),
            ),
          ),
        ),
        BlocProvider<SessionBloc>(
          create: (_) => SessionBloc(
            getSessionsByCohortUseCase: GetSessionsByCohortUseCase(
              SessionRepositoryImpl(SessionRemoteDataSource()),
            ),
          ),
        ),
        BlocProvider<TraineeBloc>(
          create: (_) => TraineeBloc(
            getTraineesByCohortUseCase: GetTraineesByCohortUseCase(
              TraineeRepositoryImpl(TraineeRemoteDataSource()),
            ),
          ),
        ),
        BlocProvider<AttendanceBloc>(
          create: (_) => AttendanceBloc(
            getAttendanceBySessionUseCase: GetAttendanceBySessionUseCase(
              AttendanceRepositoryImpl(AttendanceRemoteDataSource()),
            ),
            saveAttendanceUseCase: SaveAttendanceUseCase(
              AttendanceRepositoryImpl(AttendanceRemoteDataSource()),
            ),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Trainer Application',
        routerConfig: router,
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      ),
    );
  }
}
