import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../../../common/constants.dart';
import '../../../../common/core/base_cubit.dart';
import '../../../../data/repositories/ad_repository.dart';
import '../../../../data/repositories/cart_repository.dart';
import '../../../../data/repositories/favorite_repository.dart';
import '../../../../data/storages/token_storage.dart';
import '../../../../domain/models/ad/ad.dart';
import '../../../../domain/models/ad/ad_detail.dart';
import '../../../../domain/models/stats/stats_type.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this.adRepository,
    this.cartRepository,
    this.favoriteRepository,
    this.tokenStorage,
  ) : super(PageState()) {
    // getInitialData();
  }

  // Future<void> getInitialData() async {
  //   await Future.wait([getRecentlyViewedAds()]);
  // }

  final AdRepository adRepository;
  final CartRepository cartRepository;
  final FavoriteRepository favoriteRepository;
  final TokenStorage tokenStorage;

  List<String> getImages() {
    return (states.adDetail?.photos ?? List.empty(growable: true))
        .map((e) => "${Constants.baseUrlForImage}${e.image}")
        .toList();
  }

  void setAdId(int adId) {
    updateState((state) => state.copyWith(adId: adId));
    getDetailResponse();
  }

  bool hasAdDetailDescription() {
    return states.adDetail?.hasDescription() ?? false;
  }

  Future<void> getDetailResponse() async {
    try {
      var response = await adRepository.getAdDetail(states.adId!);
      updateState(
        (state) => state.copyWith(
          adDetail: response,
          isPhoneVisible: false,
          isAddCart: response?.isAddCart ?? false,
        ),
      );
      await increaseAdStats(StatsType.view);
      await addAdToRecentlyViewed();
    } on DioException catch (e) {
      log.e(e.toString());
      display.error(e.toString());
    }
    getSimilarAds();
    getOwnerOtherAds();
  }

  Future<void> setPhotoView() async {
    await increaseAdStats(StatsType.phone);
    updateState((state) => state.copyWith(isPhoneVisible: true));
  }

  Future<void> addFavorite() async {
    try {
      final ad = states.adDetail;
      if (!(ad?.favorite ?? false)) {
        final backendId =
            await favoriteRepository.addFavorite(states.adDetail!.toMap());

        updateState(
          (state) => state.copyWith(
            adDetail: state.adDetail
              ?..favorite = true
              ..backendId = backendId,
            isAddCart: false,
          ),
        );
      } else {
        await favoriteRepository.removeFavorite(states.adDetail!.toMap());
        updateState(
          (state) => state.copyWith(
            adDetail: state.adDetail?..favorite = false,
          ),
        );
      }
    } on DioException catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> similarAdsAddFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = states.similarAds.indexOf(ad);
        final item = states.similarAds.elementAt(index);
        states.similarAds.insert(
            index,
            item
              ..favorite = true
              ..backendId = backendId);
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = states.similarAds.indexOf(ad);
        final item = states.similarAds.elementAt(index);
        states.similarAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> addCart() async {
    try {
      await cartRepository.addCart(states.adDetail!.toMap());
      updateState((state) => state.copyWith(isAddCart: true));
      // display.success("mahsulot savatchaga qo'shildi");
    } on DioException catch (e) {
      // display.error("xatlik yuz berdi");
      log.e(e.toString());
    }
  }

  Future<void> getSimilarAds() async {
    try {
      final ads = await adRepository.getSimilarAds(
        adId: states.adId ?? 0,
        page: 1,
        limit: 10,
      );
      updateState(
        (state) => state.copyWith(
          similarAds: ads,
          similarAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(similarAdsState: LoadingState.error),
      );
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      // display.error(e.toString());
    }
  }

  Future<void> increaseAdStats(StatsType type) async {
    try {
      int? adId = states.adId;
      if (adId != null) {
        await adRepository.increaseAdStats(type: type, adId: adId);
      }
    } catch (error) {
      log.e(error.toString());
    }
  }

  Future<void> addAdToRecentlyViewed() async {
    try {
      int? adId = states.adId;
      if (adId != null && tokenStorage.isLogin.call() == true) {
        await adRepository.addAdToRecentlyViewed(adId: adId);
      }
    } catch (error) {
      log.e(error.toString());
    }
  }

  Future<void> getOwnerOtherAds() async {
    if (state.state?.adDetail?.sellerTin == null) {
      updateState((state) => state.copyWith(ownerAdsState: LoadingState.error));
      return;
    }

    try {
      final ads = await adRepository.getAdsByUser(
        sellerTin: state.state!.adDetail!.sellerTin!,
        page: 1,
        limit: 20,
      );

      display.success("Muallifning boshqa e'lonlari muaffaqiyatli yuklandi");

      ads.removeWhere((element) => element.id == state.state?.adId);
      updateState(
        (state) => state.copyWith(
          ownerAds: ads,
          ownerAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      updateState((state) => state.copyWith(ownerAdsState: LoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> ownerAdAddToFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = states.ownerAds.indexOf(ad);
        final item = states.ownerAds.elementAt(index);
        states.ownerAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = states.ownerAds.indexOf(ad);
        final item = states.ownerAds.elementAt(index);
        states.ownerAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> getRecentlyViewedAds() async {
    try {
      final ads = await adRepository.getRecentlyViewedAds(page: 1, limit: 20);

      updateState(
        (state) => state.copyWith(
          recentlyViewedAds: ads,
          recentlyViewedAdsState: LoadingState.success,
        ),
      );
    } on DioException catch (e, stackTrace) {
      updateState(
        (state) => state.copyWith(recentlyViewedAdsState: LoadingState.error),
      );
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> recentlyViewAdAddToFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = states.recentlyViewedAds.indexOf(ad);
        final item = states.recentlyViewedAds.elementAt(index);
        states.recentlyViewedAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = states.recentlyViewedAds.indexOf(ad);
        final item = states.recentlyViewedAds.elementAt(index);
        states.recentlyViewedAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("serverda xatolik yuz  berdi");
      log.e(error.toString());
    }
  }
}