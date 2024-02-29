class TurfTouchException implements Exception {
  final String message;
  TurfTouchException(this.message);

  @override
  String toString() => "Error: $message";
}
