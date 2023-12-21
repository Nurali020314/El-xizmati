import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/constants/rest_header_keys.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';

import '../../domain/models/ad.dart';
import '../storages/token_storage.dart';

@lazySingleton
class FavoriteService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  FavoriteService(this._dio, this.tokenStorage);

  Future<Response> addFavorite({required String adType, required int id}) {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {
      RestQueryKeys.queryProductType: "ADS",
      RestQueryKeys.queryProductId: id,
      RestQueryKeys.queryNum: 1,
      RestQueryKeys.queryType: "SELECTED"
    };
    return _dio.post("v1/buyer/product",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> deleteFavorite(int backedId) {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {
      RestQueryKeys.queryProductId: backedId,
      RestQueryKeys.queryType: "SELECTED"
    };
    return _dio.delete("v1/buyer/product",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> getFavoriteAds() {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {RestQueryKeys.queryType: "SELECTED"};
    return _dio.get("v1/buyer/products",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> sendAllFavoriteAds(List<Ad> ads) {
    final log = Logger();
    log.w(ads.toString());

   final adsRequest= ads.map((element) {
      return {
        RestQueryKeys.queryProductType: "ADS",
        RestQueryKeys.queryProductId: element.id,
        RestQueryKeys.queryNum: 1,
        RestQueryKeys.queryType: "SELECTED"
      };
    });

    final data = {
      RestQueryKeys.queryProducts: jsonEncode(adsRequest)
    };
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    return _dio.post("v1/buyer/products",
        data: data,
        options: Options(
          headers: headers,
        ));
  }
}
