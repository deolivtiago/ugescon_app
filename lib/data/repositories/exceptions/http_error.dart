class HttpError implements Exception {
  final String error;

  HttpError({required this.error});

  factory HttpError.fromMap(Map errors) => HttpError(error: errors.toString());
}
