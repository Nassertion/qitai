import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qitai/core/errors/app_exception.dart';

Future<T> handleDioRequest<T>(
  Future<T> Function() request,
) async {
  try {
    return await request();
  } on DioException catch (e) {
    if (kDebugMode) {
      debugPrint('DioException type: ${e.type}');
      debugPrint('Status code: ${e.response?.statusCode}');
      debugPrint('Response data: ${e.response?.data}');
    }

    throw AppException(
      _getDioErrorMessage(e),
    );
  } catch (e) {
    if (e is AppException) {
      rethrow;
    }

    if (kDebugMode) {
      debugPrint('Unexpected error: $e');
    }

    throw const AppException(
      'حدث خطأ غير متوقع',
    );
  }
}

String _getDioErrorMessage(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return 'تحقق من اتصال الإنترنت';

    case DioExceptionType.badResponse:
      return _getStatusCodeMessage(e.response);

    case DioExceptionType.cancel:
      return 'تم إلغاء الطلب';

    case DioExceptionType.badCertificate:
      return 'تعذر التحقق من أمان الاتصال';

    case DioExceptionType.unknown:
      return 'تعذر الاتصال بالخادم';

    case DioExceptionType.transformTimeout:
      return 'تعذر معالجة استجابة الخادم';
  }
}

String _getStatusCodeMessage(Response<dynamic>? response) {
  final statusCode = response?.statusCode;

  final serverMessage = _getServerMessage(response);

  if (serverMessage != null) {
    return serverMessage;
  }

  switch (statusCode) {
    case 401:
      return 'انتهت الجلسة، يرجى تسجيل الدخول مرة أخرى';

    case 403:
      return 'ليس لديك صلاحية لتنفيذ هذا الطلب';

    case 404:
      return 'البيانات المطلوبة غير موجودة';

    case 422:
      return 'البيانات المدخلة غير صحيحة';

    case 429:
      return 'تم تجاوز الحد المسموح من الطلبات، حاول لاحقًا';

    case 500:
    case 501:
    case 502:
    case 503:
    case 504:
      return 'حدث خطأ في الخادم، حاول لاحقًا';

    default:
      return 'خطأ أثناء الاتصال بالخادم';
  }
}

String? _getServerMessage(Response<dynamic>? response) {
  final data = response?.data;

  if (data is Map<String, dynamic>) {
    final message = data['message'];

    if (message is String && message.trim().isNotEmpty) {
      return message;
    }
  }

  return null;
}