import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/storages/token_storage.dart';

import '../constants/rest_header_keys.dart';
import '../constants/rest_query_keys.dart';

@lazySingleton
class UserAdService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserAdService(this._dio, this.tokenStorage);

  Future<Response> getUserAds(int pageSiz, int page) async {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {
      RestQueryKeys.queryPageSize: pageSiz,
      RestQueryKeys.queryPageIndex: page
    };
    return _dio.get("v1/user/adsList",
        queryParameters: queryParameters, options: Options(headers: headers));
  }
}
