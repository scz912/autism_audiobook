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