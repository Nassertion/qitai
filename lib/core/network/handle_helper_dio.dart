import 'package:dio/dio.dart';

Future<T> handleDioRequest<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioException catch (e) {
    print("🚨 DioException type: ${e.type}");
    print("🚨 Status code: ${e.response?.statusCode}");
    print("🚨 Response data: ${e.response?.data}");
    print("🚨 Error message: ${e.message}");

    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout) {
      throw Exception("تحقق من اتصال الإنترنت");
    } else if (e.response?.statusCode == 429) {
      throw Exception("تم تجاوز الحد المسموح من الطلبات، حاول لاحقاً");
    } else {
      final serverMessage = e.response?.data is Map<String, dynamic>
          ? e.response?.data['message']
          : null;

      throw Exception(serverMessage ?? "خطأ أثناء الاتصال بالخادم");
    }
  } catch (e) {
    print("🚨 Unknown error: $e");
    throw Exception("حدث خطأ غير متوقع: $e");
  }
}
