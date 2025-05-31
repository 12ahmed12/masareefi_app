import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String access_token;
  final bool? success;
  final String? message;

  LoginResponse({this.message, required this.access_token, this.success});
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
