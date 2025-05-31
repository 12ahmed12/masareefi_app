import '../../../core/models/api_error_model.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final bool success;

  const Authenticated({required this.success});
}

class Unauthenticated extends AuthState {}

class LoginFailure extends AuthState {
  final ApiErrorModel error;

  const LoginFailure(this.error);
}
