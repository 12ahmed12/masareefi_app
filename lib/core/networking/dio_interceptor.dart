import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../features/auth/cubit/auth_cubit.dart';
import '../constants/app_constants.dart';
import '../di/service_locator.dart';
import '../models/api_error_model.dart';
import '../models/general_api_response.dart';
import '../widgets/custom _toast.dart';

class CustomDioInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print(
        'REQUEST[${options.method}] => url ${options.baseUrl} ${options.path} ${options.data} ${options.queryParameters}');
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    options.queryParameters['ts'] = timestamp;

    //var token = await CacheHelper.getData(key: 'token');
    //print('token-to-send-with-api : $token');
    /*   options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language': lang == 'en' ? 'en-US' : 'ar-EG',
      'userLang': lang == 'en' ? 'en' : 'ar',
    };*/

/*    if (token != null) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }*/

    //print('options >> ${options.headers}');
    //print('options-query >> ${options.queryParameters}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE-DATA ${response.data}');
    //print('RESPONSE-Status ${response.statusCode}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    //print('error-interceptor ${err.type}');
    logger.e(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.baseUrl + err.requestOptions.path} => response: ${err.response}');
    await Sentry.captureException(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.baseUrl + err.requestOptions.path} => response: ${err.response}',
        stackTrace: err.stackTrace);
    if (err.type == DioExceptionType.badResponse) {
      //print('caught-error ${err.response!.statusCode}');
      if (err.response!.statusCode == 200 ||
          err.response!.statusCode == 400 ||
          err.response!.statusCode == 500) {
        ApiErrorModel apiErrorResponse = ApiErrorModel();
        //print('error-data ${err.response!.data}');
        apiErrorResponse = ApiErrorModel.fromJson(err.response!.data);
        //print('not empty-msg >> ${apiErrorResponse.message}');
        showToast(text: apiErrorResponse.message!, state: ToastStates.ERROR);
      } else if (err.response!.statusCode == 401) {
        print('401-unauthorized-go-login');
        showToast(text: '401-unauthorized-go-login', state: ToastStates.ERROR);
        getIt<AuthCubit>().logout();
      } else if (err.response!.statusCode == 405) {
        showToast(text: 'Bad Request', state: ToastStates.ERROR);
      } else if (err.response!.statusCode == 404) {
        showToast(text: 'not found 404', state: ToastStates.ERROR);
      } else {
        GeneralApiResponse generalApiResponse =
            GeneralApiResponse.fromJson(err.response!.data);
        print('in default error ${generalApiResponse.message}');
        showToast(text: generalApiResponse.message!, state: ToastStates.ERROR);
      }
    }
    if (err.type == DioExceptionType.connectionTimeout) {
      print('check your connection');
      showToast(text: 'check your connection', state: ToastStates.ERROR);
    }

    if (err.type == DioExceptionType.connectionError) {
      print('check your connection');
      showToast(text: 'check your connection', state: ToastStates.ERROR);
    }

    if (err.type == DioExceptionType.receiveTimeout) {
      print('unable to connect to the server');
      showToast(text: 'server not work', state: ToastStates.ERROR);
    }

    if (err.type == DioExceptionType.unknown) {
      print('Something went wrong');
      showToast(text: 'something wrong', state: ToastStates.ERROR);
    }

    super.onError(err, handler);
  }

/*  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('API ERROR: ${err.response?.statusCode} - ${err.response?.data}');

    if (err.response?.statusCode == 401) {
      getIt<AuthCubit>().logout();
      throw DioException(
          requestOptions: err.requestOptions, error: "Unauthorized access");
    } else if (err.response?.statusCode == 404) {
      throw DioException(
          requestOptions: err.requestOptions, error: "Not Found");
    } else if (err.type == DioExceptionType.connectionTimeout) {
      throw DioException(
          requestOptions: err.requestOptions, error: "Connection Timeout");
    } else {
      throw DioException(
          requestOptions: err.requestOptions, error: "Something went wrong");
    }
  }*/
}
