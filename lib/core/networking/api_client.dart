import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../helpers/constants.dart';
import '../helpers/shared_pref_helper.dart';
import 'dio_interceptor.dart';

class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://api.test.eye-psp.eye-apps.com/',
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 40),
        ));

  Future<void> initialize() async {
    await _addDioHeaders();
    _addDioInterceptor();
  }

  Dio get dio => _dio;

  Future<void> _addDioHeaders() async {
    _dio.options.headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userApiToken)}',
    };
  }

  void _addDioInterceptor() {
    _dio.interceptors.add(CustomDioInterceptors());
    _dio.interceptors.add(AwesomeDioInterceptor(
      logRequestTimeout: false,
      logRequestHeaders: true,
      logResponseHeaders: false,
      logger: debugPrint,
    ));
  }

  void setTokenIntoHeaderAfterLogin(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userApiToken, token);
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Response?> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    print('url ${url + query.toString()}');
    dio.options.headers = {
      'Content-Type': 'application/json',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  Future<Response?> postDataFiles({
    required String url,
    required Object? data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'multipart/form-data',
    };

    return await dio.post(
      url,
      data: data,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
  }

  Future<Response?> postData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
    };

    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  Future<Response?> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
      'Content-Type': 'text/plain',
    };

    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
