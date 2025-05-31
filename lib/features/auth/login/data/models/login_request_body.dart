import 'package:json_annotation/json_annotation.dart';

part 'login_request_body.g.dart';

@JsonSerializable()
class LoginRequestBody {
  final String? phoneNumber;
  final String? password;
  final String? clientInterface;

  LoginRequestBody({this.phoneNumber, this.password, this.clientInterface});
  @override
  String toString() {
    return 'LoginRequestBody[phone=$phoneNumber, password=$password, clientInterface=$clientInterface, ]';
  }

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);
}
