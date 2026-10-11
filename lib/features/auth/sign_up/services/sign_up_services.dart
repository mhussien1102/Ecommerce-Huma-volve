import 'package:ecommerce_app_huma_volve/core/constants/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/model/sign_up_req_model.dart';

import '../model/sign_up_res_model.dart';

class SignUpServices {
  ApiClient apiClient;
  SignUpServices(this.apiClient);
  Future<SignUpResModel> signUp(SignUpReqModel signupReqModel) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signUpEndPoint,
      data: {
        "email": signupReqModel.email,
        "name": signupReqModel.name,
        "password": signupReqModel.password,
        "avatar": "https://api.lorem.space/image/face?w=640&h=480"
      },
    );
    final jsonData = response.data;
    final dartData = SignUpResModel.fromJson(jsonData);
    return dartData;
  }
}
