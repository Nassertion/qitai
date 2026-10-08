import 'package:dio/dio.dart';
import 'package:qitai/core/network/handle_helper_dio.dart';
import 'package:qitai/features/client/auth/data/models/auth_session_model.dart';
import 'package:qitai/features/client/user/account/data/models/user_model.dart';

import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<void> sendOtp(String phone) async {
    return handleDioRequest(() async {
      await dio.post('/auth/send-otp', data: {'phone': phone});
    });
  }

  @override
  Future<AuthSessionModel> verifyOtp({
    required String phone,
    required String code,
  }) async {
    return handleDioRequest(() async {
      final response = await dio.post(
        '/auth/verify-otp',
        data: {'phone': phone, 'code': code},
      );

      return AuthSessionModel.fromJson(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<UserModel> getCurrentUser() async {
    return handleDioRequest(() async {
      final response = await dio.get('/auth/me');

      final data = response.data as Map<String, dynamic>;

      return UserModel.fromJson(data['user'] as Map<String, dynamic>);
    });
  }

  @override
  Future<void> logout() async {
    return handleDioRequest(() async {
      await dio.post('/auth/logout');
    });
  }
}
