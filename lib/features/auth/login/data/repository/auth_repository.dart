import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/helpers/constants.dart';
import '../../../../../core/models/api_error_model.dart';
import '../apis/auth_api.dart';
import '../models/login_request_body.dart';
import '../models/login_response.dart';

class AuthRepository {
  final AuthApi authApi;
  AuthRepository(this.authApi);

  Future<Either<ApiErrorModel, LoginResponse>> login(
      LoginRequestBody loginRequestBody) async {
    try {
      final response = await authApi.loginApi(loginRequestBody);

      if (response.data is! Map<String, dynamic>) {
        throw Exception("Invalid response format");
      }

      final loginResponse = LoginResponse.fromJson(response.data);
      return Right(loginResponse);
    } on DioException catch (e) {
      logger.e('repo-dio-exception $e');

      if (e.response?.data != null) {
        try {
          final apiError = ApiErrorModel.fromJson(e.response!.data);
          return Left(apiError);
        } catch (parseError) {
          logger.e('Failed to parse API error: $parseError');
        }
      }

      return Left(ApiErrorModel(
        message: e.message ?? "Something went wrong",
        code: e.response?.statusCode,
        success: false,
        errors: [],
      ));
    } catch (e, stacktrace) {
      logger.e("Unexpected error in login: $e\n$stacktrace");
      return Left(ApiErrorModel(
        message: "Unexpected error occurred",
        success: false,
        errors: [],
      ));
    }
  }
}
