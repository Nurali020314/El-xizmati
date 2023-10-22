import 'package:injectable/injectable.dart';

import '../../domain/model/ads/ad/ad_response.dart';
import '../../domain/repo/ad_repository.dart';
import '../api/ads_api.dart';
import '../storage/storage.dart';

@LazySingleton(as: AdRepository)
class AdRepositoryImpl extends AdRepository {
  final AdsApi _api;
  final Storage _storage;

  AdRepositoryImpl(this._api, this._storage);

  @override
  Future<List<AdResponse>> getAds(
      int pageIndex, int pageSize, String keyWord) async {
    final response = await _api.getAdsList(pageIndex, pageSize, keyWord);
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    return adsResponse;
  }

  @override
  Future<List<AdResponse>> getRecentlyViewAds() async {
    final response = await _api.getPopularAds();
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    return adsResponse;
  }
}