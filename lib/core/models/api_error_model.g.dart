// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    ApiErrorModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      code: (json['code'] as num?)?.toInt(),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ErrorData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiErrorModelToJson(ApiErrorModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'code': instance.code,
      'errors': instance.errors,
    };

ErrorData _$ErrorDataFromJson(Map<String, dynamic> json) => ErrorData(
      code: json['code'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ErrorDataToJson(ErrorData instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
