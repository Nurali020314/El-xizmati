import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';
import 'package:onlinebozor/presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';

@lazySingleton
class AdsApi {
  final Dio _dio;

  AdsApi(this._dio);

  Future<Response> getHomeAds(int pageIndex, int pageSize, String keyWord) {
    final queryParameters = {
      RestQueryKeys.queryPageIndex: pageIndex,
      RestQueryKeys.queryPageSize: pageSize,
      RestQueryKeys.queryKeyWord: keyWord
    };
    return _dio.get('v1/home/ads?', queryParameters: queryParameters);
  }

  Future<Response> getHomePopularAds() {
    return _dio.get('v1/popular/ads');
  }

  Future<Response> getAdDetail(int adId) {
    final queryParameters = {RestQueryKeys.queryId: adId};
    return _dio.get('v1/ads/detail/', queryParameters: queryParameters);
  }

  Future<Response> getCollectiveAds(CollectiveType collectiveType,
      int pageIndex, int pageSize, String keyWord) {
    String param =
        CollectiveType.commodity == collectiveType ? "ADS" : "SERVICE";
    final queryParameters = {
      RestQueryKeys.queryPageIndex: pageIndex,
      RestQueryKeys.queryPageSize: pageSize,
      RestQueryKeys.queryKeyWord: keyWord,
      RestQueryKeys.queryCollectiveTypeAds: param
    };
    return _dio.get("v1/home/ads?", queryParameters: queryParameters);
  }

  Future<Response> getCollectivePopularAds(CollectiveType collectiveType) {
    String param;
    param = CollectiveType.commodity == collectiveType ? "ADA" : "SERVICE";
    final queryParameters = {RestQueryKeys.queryCollectiveTypeAds: param};
    return _dio.get("v1/home/ads?", queryParameters: queryParameters);
  }

  Future<Response> getCollectiveHotDiscountAds(CollectiveType collectiveType) {
    String param;
    param = CollectiveType.commodity == collectiveType ? "ADA" : "SERVICE";
    final queryParameters = {RestQueryKeys.queryCollectiveTypeAds: param};
    return _dio.get("v1/home/ads?", queryParameters: queryParameters);
  }

  Future<Response> getSearchAd(String query) {
    final queryParameters = {RestQueryKeys.querySearchQuery: query};
    return _dio.get('v1/search', queryParameters: queryParameters);
  }

  Future<Response> getAds(
    CollectiveType collectiveType,
    int pageIndex,
    int pageSize,
    String keyWord,
  ) {
    return _dio.get("");
  }
}
