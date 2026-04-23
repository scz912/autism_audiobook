import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'app_config.dart';
import 'api_service.dart';

class Audiobook {
  final int? id;
  final String title;
  final String? author;
  final String? description;
  final String? category;
  final String? difficulty;
  final String? contentText;
  final String? audioFile;
  final String? coverImage;
  final int? durationMinutes;
  final String? language;
  final String? ageGroup;
  final bool isGenerated;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Audiobook({
    this.id,
    required this.title,
    this.author,
    this.description,
    this.category,
    this.difficulty,
    this.contentText,
    this.audioFile,
    this.coverImage,
    this.durationMinutes,
    this.language,
    this.ageGroup,
    this.isGenerated = false,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Audiobook.fromJson(Map<String, dynamic> json) {
    bool safeBool(dynamic value, [bool defaultValue = false]) {
      if (value == null) return defaultValue;
      if (value is bool) return value;
      if (value is int) return value == 1;
      if (value is String) {
        final lower = value.toLowerCase();
        return lower == '1' || lower == 'true';
      }
      return defaultValue;
    }

    int? safeInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    String safeString(dynamic value, [String defaultValue = '']) {
      if (value == null) return defaultValue;
      if (value is String) return value;
      return value.toString();
    }

    return Audiobook(
      id: safeInt(json['audiobook_id']),
      title: safeString(json['title']),
      author: safeString(json['author']),
      description: safeString(json['description']),
      category: safeString(json['category']),
      difficulty: safeString(json['difficulty']),
      contentText: safeString(json['content_text']),
      audioFile: safeString(json['audio_file']),
      coverImage: safeString(json['cover_image']),
      durationMinutes: safeInt(json['duration_minutes']),
      language: safeString(json['language']),
      ageGroup: safeString(json['age_group']),
      isGenerated: safeBool(json['is_generated']),
      status: safeString(json['status']),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'audiobook_id': id,
    'title': title,
    'author': author,
    'description': description,
    'category': category,
    'difficulty': difficulty,
    'content_text': contentText,
    'audio_file': audioFile,
    'cover_image': coverImage,
    'duration_minutes': durationMinutes,
    'language': language,
    'age_group': ageGroup,
    'is_generated': isGenerated,
    'status': status,
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };
}

class ContentSummary {
  final int totalItems;
  final int audioFiles;
  final int textFiles;
  final int aiGenerated;

  ContentSummary({
    required this.totalItems,
    required this.audioFiles,
    required this.textFiles,
    required this.aiGenerated,
  });

  factory ContentSummary.fromJson(Map<String, dynamic> json) {
    int safeInt(dynamic value, [int defaultValue = 0]) {
      if (value == null) return defaultValue;
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? defaultValue;
      return defaultValue;
    }

    return ContentSummary(
      totalItems: safeInt(json['total_items']),
      audioFiles: safeInt(json['audio_files']),
      textFiles: safeInt(json['text_files']),
      aiGenerated: safeInt(json['ai_generated']),
    );
  }
}

class ContentItem {
  final int? id;
  final String title;
  final String? author;
  final String? description;
  final String? topic;
  final String? category;
  final String? difficulty;
  final String? type;
  final String? contentText;
  final String? audioFile;
  final String? sourceFile;
  final String? coverImage;
  final int? durationMinutes;
  final String? language;
  final String? ageGroup;
  final String? tags;
  final bool isGenerated;
  final bool isUserUploaded;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  ContentItem({
    this.id,
    required this.title,
    this.author,
    this.description,
    this.topic,
    this.category,
    this.difficulty,
    this.type,
    this.contentText,
    this.audioFile,
    this.sourceFile,
    this.coverImage,
    this.durationMinutes,
    this.language,
    this.ageGroup,
    this.tags,
    this.isGenerated = false,
    this.isUserUploaded = true,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    bool safeBool(dynamic value, [bool defaultValue = false]) {
      if (value == null) return defaultValue;
      if (value is bool) return value;
      if (value is int) return value == 1;
      if (value is String) {
        final lower = value.toLowerCase();
        return lower == '1' || lower == 'true';
      }
      return defaultValue;
    }

    int? safeInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    String safeString(dynamic value, [String defaultValue = '']) {
      if (value == null) return defaultValue;
      if (value is String) return value;
      return value.toString();
    }

    return ContentItem(
      id: safeInt(json['content_id']),
      title: safeString(json['title']),
      author: safeString(json['author']),
      description: safeString(json['description']),
      topic: safeString(json['topic']),
      category: safeString(json['category']),
      difficulty: safeString(json['difficulty']),
      type: safeString(json['type']),
      contentText: safeString(json['content_text']),
      audioFile: safeString(json['audio_file']),
      sourceFile: safeString(json['source_file']),
      coverImage: safeString(json['cover_image']),
      durationMinutes: safeInt(json['duration_minutes']),
      language: safeString(json['language']),
      ageGroup: safeString(json['age_group']),
      tags: safeString(json['tags']),
      isGenerated: safeBool(json['is_generated']),
      isUserUploaded: safeBool(json['is_user_uploaded'], true),
      status: safeString(json['status']),
      createdAt: safeString(json['created_at']),
      updatedAt: safeString(json['updated_at']),
    );
  }

  List<String> get tagList {
    if (tags == null || tags!.trim().isEmpty) return [];
    return tags!
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }
}


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
  static Future<ApiResponse> getAudiobookData(int audiobookId) async {
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

      /*
      if (sessionToken == null) {
        return ApiResponse(
          success: false,
          message: 'No active session. Please login again.',
          error: 'NO_SESSION',
        );
      }
      */


      final body = {
      };


      final response = await http
          .post(
        Uri.parse('$baseUrl/audiobooks/$audiobookId'),
        headers: _getHeaders(sessionToken: sessionToken),
        body: json.encode(body),
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
          .get(
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
          .get(
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