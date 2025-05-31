// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      message: json['message'] as String?,
      access_token: json['access_token'] as String,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'success': instance.success,
      'message': instance.message,
    };
