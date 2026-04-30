import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../models/audiobook.dart';
import '../models/content_item.dart';
import '../models/content_summary.dart';
import 'api_service.dart';


class DatabaseService {
  static bool _isGettingAudiobook = false;

  static const String baseUrl = AppConfig.databaseApiUrl;

  /// Check internet connectivity
  static Future<bool> _hasNetworkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Get standard API headers
  static Map<String, String> _getHeaders({String? sessionToken}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (sessionToken != null) {
      headers['Authorization'] = 'Bearer $sessionToken';
    }

    return headers;
  }

  /// Get audiobook by ID
  static Future<ApiResponse> getAudiobookData(String audiobookId) async {
    try {
      if (_isGettingAudiobook) {
        return ApiResponse(
          success: false,
          message: 'Request already in progress',
          error: 'DUPLICATE_REQUEST',
        );
      }

      _isGettingAudiobook = true;

      bool hasConnection = await _hasNetworkConnection();
      if (!hasConnection) {
        return ApiResponse(
          success: false,
          message: 'No internet connection. Please check your network settings.',
          error: 'No connectivity',
        );
      }

      final prefs = await SharedPreferences.getInstance();
      final sessionToken = prefs.getString('session_token');

      final response = await http
          .post(
        Uri.parse('$baseUrl/audiobooks/$audiobookId'),
        headers: _getHeaders(sessionToken: sessionToken),
      )
          .timeout(const Duration(seconds: 30));

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == 'SUCCESS') {
        return ApiResponse(
          success: true,
          message: data['message'],
          data: Audiobook.fromJson(data['data']),
        );
      } else {
        return ApiResponse(
          success: false,
          message: data['message'] ?? 'Failed to get audiobook data',
          error: data['error_code'] ?? 'AUDIOBOOK_FAILED',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: Unable to get audiobook data.',
        error: e.toString(),
      );
    } finally {
      _isGettingAudiobook = false;
    }
  }

  static Future<ApiResponse> getContentSummary() async {
    try {
      bool hasConnection = await _hasNetworkConnection();
      if (!hasConnection) {
        return ApiResponse(
          success: false,
          message: 'No internet connection. Please check your network settings.',
          error: 'NO_CONNECTIVITY',
        );
      }

      final response = await http
          .post(
        Uri.parse('$baseUrl/content/summary'),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(const Duration(seconds: 30));

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == 'SUCCESS') {
        return ApiResponse(
          success: true,
          message: data['message'],
          data: ContentSummary.fromJson(data['data']),
        );
      } else {
        return ApiResponse(
          success: false,
          message: data['message'] ?? 'Failed to get content summary',
          error: data['error_code'] ?? 'CONTENT_SUMMARY_FAILED',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: Unable to get content summary.',
        error: e.toString(),
      );
    }
  }

  static Future<ApiResponse> getContentList() async {
    try {
      bool hasConnection = await _hasNetworkConnection();
      if (!hasConnection) {
        return ApiResponse(
          success: false,
          message: 'No internet connection. Please check your network settings.',
          error: 'NO_CONNECTIVITY',
        );
      }

      final response = await http
          .post(
        Uri.parse('$baseUrl/content/list'),
        headers: {'Content-Type': 'application/json'},
      )
          .timeout(const Duration(seconds: 30));

      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['status'] == 'SUCCESS') {
        final List<dynamic> items = data['data']['items'] ?? [];
        return ApiResponse(
          success: true,
          message: data['message'],
          data: items.map((e) => ContentItem.fromJson(e)).toList(),
        );
      } else {
        return ApiResponse(
          success: false,
          message: data['message'] ?? 'Failed to get content list',
          error: data['error_code'] ?? 'CONTENT_LIST_FAILED',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: Unable to get content list.',
        error: e.toString(),
      );
    }
  }
  }