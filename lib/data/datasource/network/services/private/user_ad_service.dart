import 'package:dio/dio.dart';
import 'package:El_xizmati/data/datasource/network/constants/rest_query_keys.dart';
import 'package:El_xizmati/domain/models/ad/user_ad_status.dart';

class UserAdService {
  final Dio _dio;

  UserAdService(this._dio);

  Future<Response> getUserAds({
    required int limit,
    required int page,
    required UserAdStatus userAdType,
  }) async {
    final params = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.page: page,
      RestQueryKeys.status: userAdType.name.toUpperCase()
    };

    return _dio.get("api/mobile/v1/user/adsList", queryParameters: params);
  }

  Future<Response> getUserAdDetail({required int adId}) {
    final params = {RestQueryKeys.id: adId};

    return _dio.get(
      "api/mobile/v1/ads/get-user-ad-detail",
      queryParameters: params,
    );
  }

  Future<Response> deactivateAd(int adId) async {
    final params = {RestQueryKeys.adId: adId};

    return _dio.put("api/mobile/v1/deactivate-ad", queryParameters: params);
  }

  Future<Response> activateAd(int adId) async {
    final params = {RestQueryKeys.adId: adId};

    return _dio.put("api/mobile/v1/activate-ad", queryParameters: params);
  }

  Future<Response> deleteAd(int adId) async {
    final params = {RestQueryKeys.adId: adId};
    return _dio.put("api/mobile/v1/delete-ad", queryParameters: params);
  }
}
