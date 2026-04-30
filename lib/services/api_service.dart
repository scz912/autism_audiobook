/// API Response wrapper class
class ApiResponse {
  final bool success;
  final String message;
  final dynamic data;
  final String? error;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
  });

  @override
  String toString() {
    return 'ApiResponse(success: $success, message: $message, data: $data, error: $error)';
  }
}