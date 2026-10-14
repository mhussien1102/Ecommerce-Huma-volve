import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';

import '../models/login_model.dart';
import '../models/sign_up_model.dart';
import '../models/sign_up_req_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({
    required String email,
    required String password,
  });

  Future<SignUpModel> signUp(SignUpReqModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.loginEndPoint,
      data: {"email": email, "password": password},
    );
    return LoginModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<SignUpModel> signUp(SignUpReqModel request) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signUpEndPoint,
      data: {
        "email": request.email,
        "name": request.name,
        "password": request.password,
        "avatar": "https://api.lorem.space/image/face?w=640&h=480",
      },
    );
    return SignUpModel.fromJson(response.data as Map<String, dynamic>);
  }
}