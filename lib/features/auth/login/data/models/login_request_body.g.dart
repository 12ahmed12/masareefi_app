// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestBody _$LoginRequestBodyFromJson(Map<String, dynamic> json) =>
    LoginRequestBody(
      phoneNumber: json['phoneNumber'] as String?,
      password: json['password'] as String?,
      clientInterface: json['clientInterface'] as String?,
    );

Map<String, dynamic> _$LoginRequestBodyToJson(LoginRequestBody instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'password': instance.password,
      'clientInterface': instance.clientInterface,
    };
