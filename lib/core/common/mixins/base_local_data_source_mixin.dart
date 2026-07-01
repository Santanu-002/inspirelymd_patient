import 'package:flutter/foundation.dart';
import 'package:inspirelymd_patient/core/common/models/api_response/api_response.dart';

mixin BaseLocalDataSource {
  /// A wrapper for local database/mock requests that handles catching exceptions
  /// and returning a unified [ApiResponse].
  Future<ApiResponse<T>> performLocalRequest<T>(
    Future<T> Function() call, {
    String? successMessage,
  }) async {
    try {
      final data = await call();
      return ApiResponse<T>(
        success: true,
        message: successMessage ?? 'Success',
        data: data,
      );
    } catch (e, stack) {
      debugPrint('================================================');
      debugPrint('[LocalDatabaseException] Local Request Failed:');
      debugPrint('Exception: $e');
      debugPrint('Stack Trace:\n$stack');
      debugPrint('================================================');

      return ApiResponse.error(success: false, message: e.toString());
    }
  }
}
