import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/failure/fauiler.dart';

class ErrorHandling {
  static Failure handle(dynamic exception) {
    if (exception is DioException) {
      return _handleRemoteError(exception.toString());
    }
    return Failure(errorMessage: 'Un Excepected Error');
  }

  static Failure _handleRemoteError(String message) {
    final errorMessage = message.trim();
    if (errorMessage.contains('401') ||
        errorMessage.contains('Unauthorized') ||
        errorMessage.contains('Unauthenticated')) {
      return Failure(errorMessage: 'Unauthorized');
    }

    if (errorMessage.contains('403') || errorMessage.contains('Forbidden')) {
      return Failure(errorMessage: 'Forbidden');
    }
    if (errorMessage.contains('404') || errorMessage.contains('Not Found')) {
      return Failure(errorMessage: 'Not Found');
    }
    if (errorMessage.contains('422') ||
        errorMessage.contains('Unprocessable Content')) {
      return Failure(errorMessage: 'Unprocessable Content');
    }
    if (errorMessage.contains('500') ||
        errorMessage.contains('Internal Server Error')) {
      return Failure(errorMessage: 'Internal Server Error');
    }
    if (errorMessage.contains('Socket Exception') ||
        errorMessage.contains('Connection Failed') ||
        errorMessage.contains('HandShakeException')) {
      return Failure(errorMessage: 'Connection Failed');
    }

    if (errorMessage.contains('Timeout') || errorMessage.contains('Deadline')) {
      return Failure(errorMessage: 'Timeout');
    }
    if (errorMessage.contains('TypeError') ||
        errorMessage.contains('FormatException')) {
      return Failure(errorMessage: 'Timeout');
    }
    if (errorMessage.isNotEmpty &&
        !errorMessage.contains('Exception') &&
        !errorMessage.contains('Error')) {
      return Failure(errorMessage: 'Error');
    }
    return Failure(errorMessage: "Error");
  }
}
