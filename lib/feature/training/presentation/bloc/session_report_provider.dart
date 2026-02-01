import 'package:get_it/get_it.dart';
import '../../data/datasources/session_report_remote_data_source.dart';
import '../../data/repositories/session_report_repository_impl.dart';
import '../../domain/repositories/session_report_repository.dart';
import '../../domain/usecases/get_session_report.dart';
import '../../domain/usecases/create_session_report.dart';
import 'session_report_bloc.dart';

class SessionReportProvider {
  static final GetIt _sl = GetIt.instance;

  static void init() {
    // Data sources
    _sl.registerLazySingleton<SessionReportRemoteDataSource>(
      () => SessionReportRemoteDataSource(_sl()),
    );

    // Repositories
    _sl.registerLazySingleton<SessionReportRepository>(
      () => SessionReportRepositoryImpl(_sl()),
    );

    // Use cases
    _sl.registerLazySingleton<GetSessionReport>(() => GetSessionReport(_sl()));

    _sl.registerLazySingleton<CreateSessionReport>(
      () => CreateSessionReport(_sl()),
    );

    // BLoC
    _sl.registerFactory<SessionReportBloc>(
      () => SessionReportBloc(
        getSessionReport: _sl(),
        createSessionReport: _sl(),
      ),
    );
  }

  static SessionReportBloc get bloc => _sl<SessionReportBloc>();
}
