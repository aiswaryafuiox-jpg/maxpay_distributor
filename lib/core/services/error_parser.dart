class AppException implements Exception {
  final String message;
  
  AppException(this.message);

  @override
  String toString() {
    // Return just the message, no "Exception: " prefix!
    return message;
  }
}
