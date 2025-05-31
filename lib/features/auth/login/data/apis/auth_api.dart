import '../../../../../core/helpers/constants.dart';
import '../../../../../core/networking/api_client.dart';
import '../models/login_request_body.dart';

class AuthApi {
  final ApiClient _apiClient; // ✅ Use ApiClient Instead of Dio

  AuthApi(this._apiClient);

  Future<dynamic> loginApi(LoginRequestBody loginRequestBody) async {
    final response = await _apiClient.postData(
      url: APIS.LOGIN,
      data: loginRequestBody.toJson(),
    );
    return response!;
  }
}
