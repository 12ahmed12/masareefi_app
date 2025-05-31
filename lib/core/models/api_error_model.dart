import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final bool? success;
  final String? message;
  final int? code;
  final List<ErrorData>? errors;

  ApiErrorModel({
    this.success,
    this.message,
    this.code,
    this.errors,
  });

  @override
  String toString() {
    return 'ApiErrorModel[success=$success, code=$code, message=$message, errors=$errors, ]';
  }

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  /// Returns a String containing all the error messages
  String getAllErrorMessages() {
    if (errors == null || errors is List && (errors as List).isEmpty) {
      return message!;
    }

    if (errors is Map<String, dynamic>) {
      final errorMessage =
          (errors as Map<String, dynamic>).entries.map((entry) {
        final value = entry.value;
        return "${value.join(',')}";
      }).join('\n');

      return errorMessage;
    } else if (errors is List) {
      return (errors as List).join('\n');
    }

    return message! ?? "Unknown Error occurred";
  }
}

@JsonSerializable()
class ErrorData {
  final String code;
  final String message;

  ErrorData({required this.code, required this.message});

  factory ErrorData.fromJson(Map<String, dynamic> json) =>
      _$ErrorDataFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDataToJson(this);
}
