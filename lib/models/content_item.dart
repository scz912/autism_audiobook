class ContentItem {
  final String? audiobookId;
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
    this.audiobookId,
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
      audiobookId: safeString(json['audiobook_id']),
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
