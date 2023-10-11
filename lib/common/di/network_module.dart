import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/domain/model/auth_interceptor/auth_interceptor.dart';
import 'package:onlinebozor/domain/model/intercepter/language_intercepter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor,
      LanguageInterceptor languageInterceptor) {
    final options = BaseOptions(baseUrl: Constants.baseUrl, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final dio = Dio(options);
    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(languageInterceptor);
    dio.interceptors.add(_loggerInterceptor);
    dio.interceptors.add(_headerInterceptor);
    return dio;
  }

  PrettyDioLogger get _loggerInterceptor => PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      );

  Interceptor get _headerInterceptor => InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) {
          options.headers.addAll(_basicAuthHeaders);
          handler.next(options);
        },
      );

  Map<String, String> get _basicAuthHeaders {
    String username = ',DLT)7\'q]Zb|Mx0+';
    String password = '!T4P3a9}Rx\'eXo^[~2bhLkIB"Mo\$=(LG';
    final encoded = base64.encode(utf8.encode('$username:$password'));
    String basicAuth = 'Basic $encoded';

    final headers = <String, String>{
    };

    return headers;
  }
}
//
// 'Content-Type': 'application/json; charset=UTF-8',
// "Accept-Language": "uz",
// "App-Version-Code": "122",
// "App-Version-Name": "1232",
// "Device-Id": "00000000-0000-0028-ffff-ffff95b0417a",
// "Device-Name": "Google Pixel 6 Pro",
// "Device-Manufacturer": "Google",
// "Device-Model": "Pixel 6 Pro",
// "Mobile-Os-Version": "33",
// "Mobile-Os-Type": "android",
// "User-Agent":
// "00000000-0000-0028-ffff-ffff95b0417a&&Google Pixel 6 Pro&&Google&&Pixel 6 Pro&&",
// "Night-Mode": "disabled",
// "Mobile-Os": "33"


// "App-Version-Code": "122",
// "App-Version-Name": "1232",
// "Device-Id": "00000000-0000-0028-ffff-ffff95b0417a",
// "Device-Name": "Google Pixel 6 Pro",
// "Device-Manufacturer": "Google",
// "Device-Model": "Pixel 6 Pro",
// "Mobile-Os-Version": "33",
// "Mobile-Os-Type": "android",
// "User-Agent":
// "00000000-0000-0028-ffff-ffff95b0417a&&Google Pixel 6 Pro&&Google&&Pixel 6 Pro&&",
// "Night-Mode": "disabled",
// "Mobile-Os": "33"
