import 'package:get_it/get_it.dart';
import 'package:gheero/feature/auth/domain/usecases/login_usecase.dart';
import 'package:gheero/feature/auth/domain/repositories/auth_repository.dart';
import 'package:gheero/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:gheero/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:gheero/feature/auth/presentation/bloc/login_bloc.dart';

import 'package:gheero/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:gheero/feature/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:gheero/feature/profile/domain/usecases/logout_usecase.dart';
import 'package:gheero/feature/profile/domain/repositories/profile_repository.dart';
import 'package:gheero/feature/profile/data/repositories/profile_repository_impl.dart';
import 'package:gheero/feature/profile/data/datasources/profile_remote_data_source.dart';
import 'package:gheero/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:gheero/feature/training/data/datasources/attendance_remote_data_source.dart';
import 'package:gheero/feature/training/data/datasources/cohort_remote_data_source.dart';
import 'package:gheero/feature/training/data/datasources/session_remote_data_source.dart';
import 'package:gheero/feature/training/data/datasources/trainee_remote_data_source.dart';
import 'package:gheero/feature/training/data/datasources/training_remote_data_source.dart';
import 'package:gheero/feature/training/data/repositories/attendance_repository_impl.dart';
import 'package:gheero/feature/training/data/repositories/cohort_repository_impl.dart';
import 'package:gheero/feature/training/data/repositories/session_repository_impl.dart';
import 'package:gheero/feature/training/data/repositories/trainee_repository_impl.dart';
import 'package:gheero/feature/training/data/repositories/training_repository_impl.dart';
import 'package:gheero/feature/training/domain/repositories/attendance_repository.dart';
import 'package:gheero/feature/training/domain/repositories/cohort_repository.dart';
import 'package:gheero/feature/training/domain/repositories/session_repository.dart';
import 'package:gheero/feature/training/domain/repositories/trainee_repository.dart';
import 'package:gheero/feature/training/domain/repositories/training_repository.dart';
import 'package:gheero/feature/training/domain/usecases/get_attendance_by_session_usecase.dart';
import 'package:gheero/feature/training/domain/usecases/get_cohorts_usecase.dart';
import 'package:gheero/feature/training/domain/usecases/get_sessions_by_cohort_usecase.dart';
import 'package:gheero/feature/training/domain/usecases/get_trainees_by_cohort_usecase.dart';
import 'package:gheero/feature/training/domain/usecases/get_training_by_id_usecase.dart';
import 'package:gheero/feature/training/domain/usecases/get_trainings_usecase.dart';
import 'package:gheero/feature/training/domain/usecases/save_attendance_usecase.dart';
import 'package:gheero/feature/training/data/datasources/training_profile_remote_data_source.dart';
import 'package:gheero/feature/training/data/repositories/training_profile_repository_impl.dart';
import 'package:gheero/feature/training/domain/repositories/training_profile_repository.dart';
import 'package:gheero/feature/training/domain/usecases/get_training_profile_usecase.dart';
import 'package:gheero/feature/training/data/datasources/audience_profile_remote_data_source.dart';
import 'package:gheero/feature/training/data/repositories/audience_profile_repository_impl.dart';
import 'package:gheero/feature/training/domain/repositories/audience_profile_repository.dart';
import 'package:gheero/feature/training/domain/usecases/get_audience_profile_usecase.dart';

import 'package:gheero/feature/training/presentation/bloc/attendance_bloc/attendance_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/cohort_bloc/cohort_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/trainee_bloc/trainee_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/training_bloc/training_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/training_profile_bloc/training_profile_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/audience_profile_bloc/audience_profile_bloc.dart';
import 'package:gheero/feature/job/data/datasources/job_remote_data_source.dart';
import 'package:gheero/feature/job/data/repositories/job_repository_impl.dart';
import 'package:gheero/feature/job/domain/repositories/job_repository.dart';
import 'package:gheero/feature/job/domain/usecases/get_jobs_usecase.dart';
import 'package:gheero/feature/job/presentation/bloc/job_bloc/job_bloc.dart';
import 'package:gheero/feature/job/data/datasources/job_detail_remote_data_source.dart';
import 'package:gheero/feature/job/data/repositories/job_detail_repository_impl.dart';
import 'package:gheero/feature/job/domain/repositories/job_detail_repository.dart';
import 'package:gheero/feature/job/domain/usecases/get_job_detail_usecase.dart';
import 'package:gheero/feature/job/presentation/bloc/job_detail_bloc/job_detail_bloc.dart';
import 'package:gheero/feature/job/presentation/bloc/job_application_bloc/job_application_bloc.dart';
import 'package:gheero/feature/job/data/datasources/job_application_remote_data_source.dart';
import 'package:gheero/feature/job/data/repositories/job_application_repository_impl.dart';
import 'package:gheero/feature/job/domain/repositories/job_application_repository.dart';
import 'package:gheero/feature/job/domain/usecases/submit_job_application_usecase.dart';
import 'package:gheero/feature/job/data/datasources/application_remote_data_source.dart';
import 'package:gheero/feature/job/data/repositories/application_repository_impl.dart';
import 'package:gheero/feature/job/domain/repositories/application_repository.dart';
import 'package:gheero/feature/job/domain/usecases/get_applications_usecase.dart';
import 'package:gheero/feature/training/data/datasources/module_remote_data_source.dart';
import 'package:gheero/feature/training/data/repositories/module_repository_impl.dart';
import 'package:gheero/feature/training/domain/repositories/module_repository.dart';
import 'package:gheero/feature/training/domain/usecases/get_modules_usecase.dart';
import 'package:gheero/feature/training/presentation/bloc/module_bloc/module_bloc.dart';
import 'package:gheero/feature/training/data/datasources/module_detail_remote_data_source.dart';
import 'package:gheero/feature/training/data/repositories/module_detail_repository_impl.dart';
import 'package:gheero/feature/training/domain/repositories/module_detail_repository.dart';
import 'package:gheero/feature/training/domain/usecases/get_module_detail_usecase.dart';
import 'package:gheero/feature/training/presentation/bloc/module_detail_bloc/module_detail_bloc.dart';

import 'package:gheero/feature/training/data/datasources/module_assessment_methods_remote_data_source.dart';
import 'package:gheero/feature/training/data/repositories/module_assessment_methods_repository_impl.dart';
import 'package:gheero/feature/training/domain/repositories/module_assessment_methods_repository.dart';
import 'package:gheero/feature/training/domain/usecases/get_module_assessment_methods_usecase.dart';

import 'package:gheero/feature/training/data/datasources/assessment_remote_data_source.dart';
import 'package:gheero/feature/training/data/repositories/assessment_repository_impl.dart';
import 'package:gheero/feature/training/domain/repositories/assessment_repository.dart';
import 'package:gheero/feature/training/domain/usecases/get_assessments_usecase.dart';
import 'package:gheero/feature/training/presentation/bloc/assessment_bloc/assessment_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/survey_completion_bloc/survey_completion_bloc.dart';
import 'package:gheero/feature/training/presentation/bloc/assessment_attempt_bloc/assessment_attempt_bloc.dart';
import 'package:gheero/feature/training/data/datasources/survey_completion_remote_data_source.dart';
import 'package:gheero/feature/training/data/repositories/survey_completion_repository_impl.dart';
import 'package:gheero/feature/training/domain/repositories/survey_completion_repository.dart';
import 'package:gheero/feature/training/domain/usecases/get_survey_completion_usecase.dart';
import 'package:gheero/feature/training/data/datasources/assessment_attempt_remote_data_source.dart';
import 'package:gheero/feature/training/data/repositories/assessment_attempt_repository_impl.dart';
import 'package:gheero/feature/training/domain/repositories/assessment_attempt_repository.dart';
import 'package:gheero/feature/training/domain/usecases/get_assessment_attempts_usecase.dart';

import 'package:gheero/feature/training/data/datasources/content_remote_data_source.dart';
import 'package:gheero/feature/training/data/repositories/content_repository_impl.dart';
import 'package:gheero/feature/training/domain/repositories/content_repository.dart';
import 'package:gheero/feature/training/domain/usecases/get_content_usecase.dart';
import 'package:gheero/feature/training/presentation/bloc/content_bloc/content_bloc.dart';
import 'package:gheero/feature/training/data/datasources/session_report_remote_data_source.dart';
import 'package:gheero/feature/training/data/repositories/session_report_repository_impl.dart';
import 'package:gheero/feature/training/domain/repositories/session_report_repository.dart';
import 'package:gheero/feature/training/domain/usecases/get_session_report.dart';
import 'package:gheero/feature/training/domain/usecases/create_session_report.dart';
import 'package:gheero/feature/training/presentation/bloc/session_report_bloc.dart';

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
  sl.registerLazySingleton<JobDetailRemoteDataSource>(
    () => JobDetailRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<JobApplicationRemoteDataSource>(
    () => JobApplicationRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ApplicationRemoteDataSource>(
    () => ApplicationRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ModuleRemoteDataSource>(
    () => ModuleRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ModuleDetailRemoteDataSource>(
    () => ModuleDetailRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ModuleAssessmentMethodsRemoteDataSource>(
    () => ModuleAssessmentMethodsRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ContentRemoteDataSource>(
    () => ContentRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<SessionReportRemoteDataSource>(
    () => SessionReportRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<AssessmentRemoteDataSource>(
    () => AssessmentRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton<SurveyCompletionRemoteDataSource>(
    () => SurveyCompletionRemoteDataSource(apiClient: sl()),
  );
  sl.registerLazySingleton<AssessmentAttemptRemoteDataSource>(
    () => AssessmentAttemptRemoteDataSource(apiClient: sl()),
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
  sl.registerLazySingleton<JobDetailRepository>(
    () => JobDetailRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<JobApplicationRepository>(
    () => JobApplicationRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ApplicationRepository>(
    () => ApplicationRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ModuleRepository>(() => ModuleRepositoryImpl(sl()));
  sl.registerLazySingleton<ModuleDetailRepository>(
    () => ModuleDetailRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ModuleAssessmentMethodsRepository>(
    () => ModuleAssessmentMethodsRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ContentRepository>(
    () => ContentRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<SessionReportRepository>(
    () => SessionReportRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AssessmentRepository>(
    () => AssessmentRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SurveyCompletionRepository>(
    () => SurveyCompletionRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AssessmentAttemptRepository>(
    () => AssessmentAttemptRepositoryImpl(sl()),
  );

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
  sl.registerLazySingleton<GetJobDetailUseCase>(
    () => GetJobDetailUseCase(sl()),
  );
  sl.registerLazySingleton<SubmitJobApplicationUseCase>(
    () => SubmitJobApplicationUseCase(sl()),
  );
  sl.registerLazySingleton<GetApplicationsUseCase>(
    () => GetApplicationsUseCase(sl()),
  );
  sl.registerLazySingleton<GetModulesUseCase>(() => GetModulesUseCase(sl()));
  sl.registerLazySingleton<GetModuleDetailUseCase>(
    () => GetModuleDetailUseCase(sl()),
  );
  sl.registerLazySingleton<GetModuleAssessmentMethodsUseCase>(
    () => GetModuleAssessmentMethodsUseCase(sl()),
  );
  sl.registerLazySingleton<GetContentUseCase>(() => GetContentUseCase(sl()));
  sl.registerLazySingleton<GetSessionReport>(() => GetSessionReport(sl()));
  sl.registerLazySingleton<CreateSessionReport>(
    () => CreateSessionReport(sl()),
  );
  sl.registerLazySingleton<GetAssessmentsUseCase>(
    () => GetAssessmentsUseCase(sl()),
  );
  sl.registerLazySingleton<GetSurveyCompletionUseCase>(
    () => GetSurveyCompletionUseCase(sl()),
  );
  sl.registerLazySingleton<GetAssessmentAttemptsUseCase>(
    () => GetAssessmentAttemptsUseCase(sl()),
  );

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
  sl.registerFactory<JobDetailBloc>(() => JobDetailBloc(sl()));
  sl.registerFactory<JobApplicationBloc>(
    () => JobApplicationBloc(submitJobApplicationUseCase: sl()),
  );
  sl.registerFactory<ModuleBloc>(() => ModuleBloc(sl()));
  sl.registerFactory<ModuleDetailBloc>(() => ModuleDetailBloc(sl(), sl()));
  sl.registerFactory<ContentBloc>(() => ContentBloc(sl()));
  sl.registerFactory<SessionReportBloc>(
    () => SessionReportBloc(getSessionReport: sl(), createSessionReport: sl()),
  );
  sl.registerFactory<AssessmentBloc>(
    () => AssessmentBloc(assessmentRepository: sl()),
  );
  sl.registerFactory<SurveyCompletionBloc>(
    () => SurveyCompletionBloc(repository: sl()),
  );
  sl.registerFactory<AssessmentAttemptBloc>(
    () => AssessmentAttemptBloc(repository: sl()),
  );
}
