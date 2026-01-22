import 'package:dio/dio.dart';
import '../constant/env.dart';
import '../storage/storage_service.dart';

class ApiClient {
  late final Dio _mainApi;
  late final Dio _curriculumApi;

  ApiClient() {
    _mainApi = Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: Duration(milliseconds: Env.connectTimeout),
        receiveTimeout: Duration(milliseconds: Env.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) =>
            true, // Don't throw exceptions for any status code
      ),
    );

    _curriculumApi = Dio(
      BaseOptions(
        baseUrl: Env.curriculumBaseUrl,
        connectTimeout: Duration(milliseconds: Env.connectTimeout),
        receiveTimeout: Duration(milliseconds: Env.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) =>
            true, // Don't throw exceptions for any status code
      ),
    );

    _initializeAuthToken();
  }

  // Automatically add token to both APIs if exists
  Future<void> _initializeAuthToken() async {
    final token = await StorageService.getToken();
    if (token != null) {
      _mainApi.options.headers['Authorization'] = 'Bearer $token';
      _curriculumApi.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  // =========================
  // MAIN API METHODS
  // =========================
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _mainApi.get<T>(path, queryParameters: queryParameters, options: options);

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _mainApi.post<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _mainApi.put<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _mainApi.patch<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _mainApi.delete<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  // =========================
  // CURRICULUM API METHODS
  // =========================
  Future<Response<T>> getCurriculum<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _curriculumApi.get<T>(
    path,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> postCurriculum<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _curriculumApi.post<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> putCurriculum<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _curriculumApi.put<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> patchCurriculum<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _curriculumApi.patch<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> deleteCurriculum<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _curriculumApi.delete<T>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  // =========================
  // HELPERS
  // =========================
  void setAuthToken(String token) {
    _mainApi.options.headers['Authorization'] = 'Bearer $token';
    _curriculumApi.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _mainApi.options.headers.remove('Authorization');
    _curriculumApi.options.headers.remove('Authorization');
  }

  void setLocale(String languageCode) {
    _mainApi.options.headers['Accept-Language'] = languageCode;
    _curriculumApi.options.headers['Accept-Language'] = languageCode;
  }

  void updateHeaders(Map<String, dynamic> headers) {
    _mainApi.options.headers.addAll(headers);
    _curriculumApi.options.headers.addAll(headers);
  }

  void removeHeaders(List<String> keys) {
    for (final key in keys) {
      _mainApi.options.headers.remove(key);
      _curriculumApi.options.headers.remove(key);
    }
  }

  // Access underlying Dio instances if needed
  Dio get mainApi => _mainApi;
  Dio get curriculumApi => _curriculumApi;
}
