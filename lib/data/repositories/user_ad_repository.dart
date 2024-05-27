import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad_detail/user_ad_detail_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/data/datasource/network/services/user_ad_service.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';

import '../../domain/models/ad/user_ad_status.dart';

@LazySingleton()
class UserAdRepository {
  UserAdRepository(
    this._userAdService,
    this._stateRepository,
    this._userRepository,
  );

  final StateRepository _stateRepository;
  final UserAdService _userAdService;
  final UserRepository _userRepository;

  Future<List<UserAdResponse>> getUserAds({
    required int page,
    required int limit,
    required UserAdStatus userAdStatus,
  }) async {
    if (_stateRepository.isNotAuthorized()) throw NotAuthorizedException();
    if (_userRepository.isNotIdentified()) throw NotIdentifiedException();

    final root = await _userAdService.getUserAds(
      page: page,
      limit: limit,
      userAdType: userAdStatus,
    );
    final response = UserAdRootResponse.fromJson(root.data).data.results;
    return response;
  }


  Future<UserAdDetail> getUserAdDetail({required int adId}) async {
    final response = await _userAdService.getUserAdDetail(adId: adId);
    final adsResponse = UserAdDetailRootResponse.fromJson(response.data).data;
    return adsResponse.userAdDetail;
  }

  Future<void> deactivateAd(int adId) async {
    final response = await _userAdService.deactivateAd(adId);
    return;
  }

  Future<void> activateAd(int adId) async {
    final response = await _userAdService.activateAd(adId);
    return;
  }

  Future<void> deleteAd(int adId) async {
    final response = await _userAdService.deleteAd(adId);
    return;
  }
}
