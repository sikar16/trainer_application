import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/trainee_model.dart';

class TraineeRemoteDataSource {
  final ApiClient apiClient;

  TraineeRemoteDataSource({required this.apiClient});

  Future<TraineeListModel> getTraineesByCohort({
    required String cohortId,
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await apiClient.get(
        '/api/cohort/$cohortId/trainees',
        queryParameters: {'page': page, 'pageSize': pageSize},
      );

      final data = response.data;
      return TraineeListModel.fromJson(data);
    } catch (e) {
      debugPrint('getTraineesByCohort error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateTraineeId({
    required String pendingTraineeId,
    required String idType,
    required File idFrontFile,
    File? idBackFile,
  }) async {
    try {
      final Map<String, dynamic> requestData = {
        'pendingTraineeId': pendingTraineeId,
        'idType': idType,
      };

      final Map<String, MultipartFile> files = {
        'idFrontFile': await MultipartFile.fromFile(
          idFrontFile.path,
          filename: idFrontFile.path.split('/').last,
        ),
      };

      if (idBackFile != null) {
        files['idBackFile'] = await MultipartFile.fromFile(
          idBackFile.path,
          filename: idBackFile.path.split('/').last,
        );
      }

      final response = await apiClient.postMultipart(
        '/api/pending-trainee/update-id',
        data: requestData,
        files: files,
      );

      return response.data;
    } catch (e) {
      debugPrint('updateTraineeId error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> uploadConsentForm({
    required String pendingTraineeId,
    required File consentFormFile,
  }) async {
    try {
      final Map<String, dynamic> requestData = {
        'pendingTraineeId': pendingTraineeId,
      };

      final Map<String, MultipartFile> files = {
        'consentFormFile': await MultipartFile.fromFile(
          consentFormFile.path,
          filename: consentFormFile.path.split('/').last,
        ),
      };

      final response = await apiClient.postMultipart(
        '/api/pending-trainee/upload-consent',
        data: requestData,
        files: files,
      );

      return response.data;
    } catch (e) {
      debugPrint('uploadConsentForm error: $e');
      rethrow;
    }
  }
}
