import 'package:get_it/get_it.dart';
import 'package:training/feature/auth/domain/usecases/login_usecase.dart';
import 'package:training/feature/auth/domain/repositories/auth_repository.dart';
import 'package:training/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:training/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:training/feature/auth/presentation/bloc/login_bloc.dart';

import 'package:training/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:training/feature/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:training/feature/profile/domain/usecases/logout_usecase.dart';
import 'package:training/feature/profile/domain/repositories/profile_repository.dart';
import 'package:training/feature/profile/data/repositories/profile_repository_impl.dart';
import 'package:training/feature/profile/data/datasources/profile_remote_data_source.dart';
import 'package:training/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:training/feature/training/data/datasources/attendance_remote_data_source.dart';
import 'package:training/feature/training/data/datasources/cohort_remote_data_source.dart';
import 'package:training/feature/training/data/datasources/session_remote_data_source.dart';
import 'package:training/feature/training/data/datasources/trainee_remote_data_source.dart';
import 'package:training/feature/training/data/datasources/training_remote_data_source.dart';
import 'package:training/feature/training/data/repositories/attendance_repository_impl.dart';
import 'package:training/feature/training/data/repositories/cohort_repository_impl.dart';
import 'package:training/feature/training/data/repositories/session_repository_impl.dart';
import 'package:training/feature/training/data/repositories/trainee_repository_impl.dart';
import 'package:training/feature/training/data/repositories/training_repository_impl.dart';
import 'package:training/feature/training/domain/repositories/attendance_repository.dart';
import 'package:training/feature/training/domain/repositories/cohort_repository.dart';
import 'package:training/feature/training/domain/repositories/session_repository.dart';
import 'package:training/feature/training/domain/repositories/trainee_repository.dart';
import 'package:training/feature/training/domain/repositories/training_repository.dart';
import 'package:training/feature/training/domain/usecases/get_attendance_by_session_usecase.dart';
import 'package:training/feature/training/domain/usecases/get_cohorts_usecase.dart';
import 'package:training/feature/training/domain/usecases/get_sessions_by_cohort_usecase.dart';
import 'package:training/feature/training/domain/usecases/get_trainees_by_cohort_usecase.dart';
import 'package:training/feature/training/domain/usecases/get_training_by_id_usecase.dart';
import 'package:training/feature/training/domain/usecases/get_trainings_usecase.dart';
import 'package:training/feature/training/domain/usecases/save_attendance_usecase.dart';
import 'package:training/feature/training/data/datasources/training_profile_remote_data_source.dart';
import 'package:training/feature/training/data/repositories/training_profile_repository_impl.dart';
import 'package:training/feature/training/domain/repositories/training_profile_repository.dart';
import 'package:training/feature/training/domain/usecases/get_training_profile_usecase.dart';
import 'package:training/feature/training/data/datasources/audience_profile_remote_data_source.dart';
import 'package:training/feature/training/data/repositories/audience_profile_repository_impl.dart';
import 'package:training/feature/training/domain/repositories/audience_profile_repository.dart';
import 'package:training/feature/training/domain/usecases/get_audience_profile_usecase.dart';

import 'package:training/feature/training/presentation/bloc/attendance_bloc/attendance_bloc.dart';
import 'package:training/feature/training/presentation/bloc/cohort_bloc/cohort_bloc.dart';
import 'package:training/feature/training/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:training/feature/training/presentation/bloc/trainee_bloc/trainee_bloc.dart';
import 'package:training/feature/training/presentation/bloc/training_bloc/training_bloc.dart';
import 'package:training/feature/training/presentation/bloc/training_profile_bloc.dart';
import 'package:training/feature/training/presentation/bloc/audience_profile_bloc.dart';
import 'package:training/feature/job/data/datasources/job_remote_data_source.dart';
import 'package:training/feature/job/data/repositories/job_repository_impl.dart';
import 'package:training/feature/job/domain/repositories/job_repository.dart';
import 'package:training/feature/job/domain/usecases/get_jobs_usecase.dart';
import 'package:training/feature/job/presentation/bloc/job_bloc.dart';
import 'package:training/feature/training/data/datasources/module_remote_data_source.dart';
import 'package:training/feature/training/data/repositories/module_repository_impl.dart';
import 'package:training/feature/training/domain/repositories/module_repository.dart';
import 'package:training/feature/training/domain/usecases/get_modules_usecase.dart';
import 'package:training/feature/training/presentation/bloc/module_bloc.dart';

import '../network/api_client.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  /* =======================
     CORE
  ======================= */
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  /* =======================
     DATA SOURCES
  ======================= */
  // Auth/Profile
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(sl()),
  );

  // Training
  sl.registerLazySingleton<AttendanceRemoteDataSource>(
    () => AttendanceRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton<CohortRemoteDataSource>(
    () => CohortRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton<SessionRemoteDataSource>(
    () => SessionRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton<TraineeRemoteDataSource>(
    () => TraineeRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton<TrainingRemoteDataSource>(
    () => TrainingRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton<TrainingProfileRemoteDataSource>(
    () => TrainingProfileRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AudienceProfileRemoteDataSource>(
    () => AudienceProfileRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<JobRemoteDataSource>(
    () => JobRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ModuleRemoteDataSource>(
    () => ModuleRemoteDataSourceImpl(sl()),
  );

  /* =======================
     REPOSITORIES
  ======================= */
  // Auth/Profile
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  // Training
  sl.registerLazySingleton<AttendanceRepository>(
    () => AttendanceRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CohortRepository>(() => CohortRepositoryImpl(sl()));
  sl.registerLazySingleton<SessionRepository>(
    () => SessionRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TraineeRepository>(
    () => TraineeRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TrainingRepository>(
    () => TrainingRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TrainingProfileRepository>(
    () => TrainingProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AudienceProfileRepository>(
    () => AudienceProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<JobRepository>(() => JobRepositoryImpl(sl()));
  sl.registerLazySingleton<ModuleRepository>(() => ModuleRepositoryImpl(sl()));

  /* =======================
     USE CASES
  ======================= */
  // Auth/Profile
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton<EditProfileUseCase>(() => EditProfileUseCase(sl()));
  sl.registerLazySingleton<LogoutUseCase>(() => LogoutUseCase(sl()));

  // Training
  sl.registerLazySingleton<GetAttendanceBySessionUseCase>(
    () => GetAttendanceBySessionUseCase(sl()),
  );
  sl.registerLazySingleton<SaveAttendanceUseCase>(
    () => SaveAttendanceUseCase(sl()),
  );
  sl.registerLazySingleton<GetCohortsUseCase>(() => GetCohortsUseCase(sl()));
  sl.registerLazySingleton<GetSessionsByCohortUseCase>(
    () => GetSessionsByCohortUseCase(sl()),
  );
  sl.registerLazySingleton<GetTraineesByCohortUseCase>(
    () => GetTraineesByCohortUseCase(sl()),
  );
  sl.registerLazySingleton<GetTrainingsUseCase>(
    () => GetTrainingsUseCase(sl()),
  );
  sl.registerLazySingleton<GetTrainingByIdUseCase>(
    () => GetTrainingByIdUseCase(sl()),
  );
  sl.registerLazySingleton<GetTrainingProfileUseCase>(
    () => GetTrainingProfileUseCase(sl()),
  );
  sl.registerLazySingleton<GetAudienceProfileUseCase>(
    () => GetAudienceProfileUseCase(sl()),
  );
  sl.registerLazySingleton<GetJobsUseCase>(() => GetJobsUseCase(sl()));
  sl.registerLazySingleton<GetModulesUseCase>(() => GetModulesUseCase(sl()));

  /* =======================
     BLOCS
  ======================= */
  // Auth/Profile
  sl.registerFactory<LoginBloc>(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      getProfileUseCase: sl(),
      editProfileUseCase: sl(),
      logoutUseCase: sl(),
    ),
  );

  // Training
  sl.registerFactory<TrainingBloc>(
    () => TrainingBloc(getTrainingsUseCase: sl(), getTrainingByIdUseCase: sl()),
  );
  sl.registerFactory<CohortBloc>(() => CohortBloc(getCohortsUseCase: sl()));
  sl.registerFactory<SessionBloc>(
    () => SessionBloc(getSessionsByCohortUseCase: sl()),
  );
  sl.registerFactory<TraineeBloc>(
    () => TraineeBloc(getTraineesByCohortUseCase: sl()),
  );
  sl.registerFactory<AttendanceBloc>(
    () => AttendanceBloc(
      getAttendanceBySessionUseCase: sl(),
      saveAttendanceUseCase: sl(),
    ),
  );
  sl.registerFactory<TrainingProfileBloc>(() => TrainingProfileBloc(sl()));
  sl.registerFactory<AudienceProfileBloc>(() => AudienceProfileBloc(sl()));
  sl.registerFactory<JobBloc>(() => JobBloc(sl()));
  sl.registerFactory<ModuleBloc>(() => ModuleBloc(sl()));
}
