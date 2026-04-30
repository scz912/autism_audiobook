class Audiobook {
  final String? audiobookId;
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
    this.audiobookId,
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
      audiobookId: safeString(json['audiobook_id']),
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
    'audiobook_id': audiobookId,
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