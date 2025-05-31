import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masareefi/core/models/api_error_model.dart';
import 'package:masareefi/core/networking/api_client.dart';
import '../../../../core/helpers/constants.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/di/service_locator.dart';
import '../login/data/repository/auth_repository.dart';
import 'auth_state.dart';
import '../../../../core/helpers/extensions.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  /// ✅ Login with email and password
  void login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      // Simulate API delay for demo
      await Future.delayed(const Duration(seconds: 2));

      // ✅ Validate inputs
      final validationError = _validateLoginInputs(email, password);
      if (validationError != null) {
        emit(LoginFailure(ApiErrorModel(
          message: validationError,
          success: false,
        )));
        return;
      }

      // ✅ Check demo credentials
      if (email.trim().toLowerCase() == "user@masareefi.com" &&
          password.trim() == "123456") {
        // ✅ Create demo token
        const dummyToken =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIiwibmFtZSI6IlVzZXIgVGVzdCIsImVtYWlsIjoidXNlckBtYXNhcmVlZmkuY29tIiwiaWF0IjoxNzM1NjY0NTAwLCJleHAiOjE3MzU3NTA5MDB9.demo_token_for_masareefi_app";

        // ✅ Save token securely
        await SharedPrefHelper.setSecuredString(
            SharedPrefKeys.userApiToken, dummyToken);

        // ✅ Update API client headers
        final apiClient = getIt<ApiClient>();
        apiClient.setTokenIntoHeaderAfterLogin(dummyToken);

        // ✅ Update global login status
        isLoggedInUser = true;

        logger.i('Login successful - Token saved and headers updated');

        emit(Authenticated(success: true));
      } else {
        // ✅ Invalid credentials
        emit(LoginFailure(ApiErrorModel(
          message:
              "بيانات تسجيل الدخول غير صحيحة.\nاستخدم البيانات التجريبية:\nuser@masareefi.com / 123456",
          success: false,
        )));
      }
    } catch (e, stackTrace) {
      logger.e('Login error: $e\nStackTrace: $stackTrace');

      emit(LoginFailure(ApiErrorModel(
        message: "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى",
        success: false,
      )));
    }
  }

  /// ✅ Logout and clear all data
  Future<void> logout() async {
    try {
      // Clear all stored data
      await SharedPrefHelper.clearAllData();
      await SharedPrefHelper.clearAllSecuredData();

      // Reset API client headers
      final apiClient = getIt<ApiClient>();
      apiClient.dio.options.headers.remove('Authorization');

      // Update global login status
      isLoggedInUser = false;

      logger.i('Logout successful - All data cleared');

      emit(Unauthenticated());
    } catch (e) {
      logger.e('Logout error: $e');
      // Even if logout fails, still emit unauthenticated state
      emit(Unauthenticated());
    }
  }

  /// ✅ Check login status on app startup
  Future<void> checkLoginStatus() async {
    try {
      final String? token =
          await SharedPrefHelper.getSecuredString(SharedPrefKeys.userApiToken);

      if (token.isNullOrEmpty()) {
        isLoggedInUser = false;
        emit(Unauthenticated());
        logger.d('User is not authenticated - No token found');
      } else {
        // ✅ Update API client headers with existing token
        final apiClient = getIt<ApiClient>();
        apiClient.setTokenIntoHeaderAfterLogin(token!);

        isLoggedInUser = true;
        emit(Authenticated(success: true));
        logger.d('User is authenticated - Token found and headers updated');
      }
    } catch (e) {
      logger.e('Error checking login status: $e');
      isLoggedInUser = false;
      emit(Unauthenticated());
    }
  }

  /// ✅ Validate login inputs
  String? _validateLoginInputs(String email, String password) {
    email = email.trim();
    password = password.trim();

    if (email.isEmpty) {
      return "يرجى إدخال البريد الإلكتروني";
    }

    if (!email.contains('@') || !email.contains('.')) {
      return "يرجى إدخال بريد إلكتروني صحيح";
    }

    if (password.isEmpty) {
      return "يرجى إدخال كلمة المرور";
    }

    if (password.length < 6) {
      return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
    }

    return null; // No validation errors
  }

  /// ✅ Check if user is currently authenticated
  bool get isAuthenticated => state is Authenticated;

  /// ✅ Get current auth state
  AuthState get currentState => state;
}
