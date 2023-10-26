import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/mapper/ad_mapper.dart';

import '../../domain/model/ad_model.dart';
import '../../domain/repository/ad_repository.dart';
import '../api/ads_api.dart';
import '../model/ads/ad/ad_response.dart';
import '../model/ads/ad_detail/ad_detail_response.dart';
import '../storage/storage.dart';

@LazySingleton(as: AdRepository)
class AdRepositoryImpl extends AdRepository {
  final AdsApi _api;
  final Storage _storage;

  AdRepositoryImpl(this._api, this._storage);

  @override
  Future<List<AdModel>> getAds(
      int pageIndex, int pageSize, String keyWord) async {
    final response = await _api.getAdsList(pageIndex, pageSize, keyWord);
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse.map((e) => e.toMap()).toList(growable: true);
    return result;
  }

  @override
  Future<List<AdModel>> getRecentlyViewAds() async {
    final response = await _api.getPopularAds();
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse.map((e) => e.toMap()).toList(growable: true);
    return result;
  }

  @override
  Future<AdDetailResponse?> getAdDetail(int adId) async {
    final response = await _api.getAdDetail(adId);
    final adDetail = AdDetailRootResponse.fromJson(response.data).data.results;
    return adDetail;
  }

  @override
  Future<List<AdModel>> getAdModels(
      int pageIndex, int pageSize, String keyWord) async {
    final response = await _api.getAdsList(pageIndex, pageSize, keyWord);
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse.map((e) => e.toMap()).toList(growable: true);
    return result;
  }
}