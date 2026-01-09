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
import 'package:trainer_application/feature/training/data/repositories/training_repository_impl.dart';
import 'package:trainer_application/feature/training/data/repositories/cohort_repository_impl.dart';
import 'package:trainer_application/feature/training/domain/usecases/get_trainings_usecase.dart';
import 'package:trainer_application/feature/training/domain/usecases/get_training_by_id_usecase.dart';
import 'package:trainer_application/feature/training/domain/usecases/get_cohorts_usecase.dart';
import 'package:trainer_application/feature/training/presentation/bloc/training_bloc.dart';
import 'package:trainer_application/feature/training/presentation/bloc/cohort_bloc.dart';

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
