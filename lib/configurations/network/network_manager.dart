import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tatpar_orange/features/authentication/blocs/auth_cubit.dart';

import 'api_constants.dart';
import 'api_response.dart';
import 'application_error.dart';
import 'network_request.dart';

class NetworkManager {
  static final NetworkManager instance = NetworkManager();

  final Dio _dio = Dio();

  NetworkManager() {
    initDio();
  }

  void initDio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (
      RequestOptions options,
      RequestInterceptorHandler handler,
    ) async {
      // Authorization
      final bool isAuthorized = options.extra['isAuthorized'] as bool;
      if (isAuthorized) {
        final token = AuthCubit.instance.state.authToken;
        options.headers['Authorization'] = 'Token $token';
      }
      // Language
      // todo add language interceptor
      // final AppLocale locale = Get.find<LocalizationService>().currentLocale;
      // if (locale.languageCode != null) {
      //   options.headers['Accept-Language'] = locale.languageCode;
      // }
      return handler.next(options);
    }));
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        compact: false));
  }

  Future<bool> isInternetAvailable() async {
    bool connectivityResult = await InternetConnection().hasInternetAccess;
    return connectivityResult;
  }

  Future<ApiResponse<T>> perform<T>(NetworkRequest request) async {
    try {
      if (!(await isInternetAvailable())) {
        return ApiResponse.failed(ApplicationError(
          type: NetworkError(-1),
          errorMsg: 'No internet connection available',
        ));
      }
      final Response<dynamic> response = await _dio.request<dynamic>(
        request.url,
        data: request.data,
        queryParameters: request.queryParams,
        options: _getOptions(request),
      );
      return ApiResponse.success(response);
    } catch (e, s) {
      debugPrint('$e\n $s');
      return ApiResponse.failed(
          getApplicationErrorFromDioError(e as DioException));
    }
  }

  Options _getOptions(NetworkRequest request) => Options(
        headers: request.headers,
        method: request.method.name,
        extra: <String, dynamic>{
          'isAuthorized': request.isAuthorized,
        }, // read this later in interceptor to send token if needed
      );

  ApplicationError getApplicationErrorFromDioError(DioException dioError) {
    ErrorType errorType;
    String errorMsg = 'Network error';
    dynamic extra;
    if (dioError.response?.data != null && dioError.response?.data is Map) {
      errorMsg = dioError.response?.data['message'] ?? 'Network error';
      extra = dioError.response?.data['errors'];
    }
    if (dioError.response?.statusCode == 401) {
      errorType = Unauthorized();
    } else if (dioError.response?.statusCode == 404) {
      errorType = ResourceNotFound();
    } else {
      errorType = UnExpected();
    }
    return ApplicationError(type: errorType, errorMsg: errorMsg, extra: extra);
  }
}
