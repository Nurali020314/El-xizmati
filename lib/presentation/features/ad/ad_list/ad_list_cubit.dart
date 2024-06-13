import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/repositories/ad_repository.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_list_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'ad_list_cubit.freezed.dart';
part 'ad_list_state.dart';

@injectable
class AdListCubit extends BaseCubit<AdListState, AdListEvent> {
  AdListCubit(
    this._adRepository,
    this._cartRepository,
    this._favoriteRepository,
  ) : super(AdListState());

  static const _pageSize = 20;
  final AdRepository _adRepository;
  final CartRepository _cartRepository;
  final FavoriteRepository _favoriteRepository;

  void setInitialParams(
    AdListType adListType,
    String? keyWord,
    int? sellerTin,
    int? adId,
    AdType? collectiveType,
  ) {
    updateState(
      (state) => state.copyWith(
        adListType: adListType,
        keyWord: keyWord ?? "",
        sellerTin: sellerTin,
        adId: adId,
        collectiveType: collectiveType,
        controller: null,
      ),
    );

    getController();
  }

  Future<void> getController() async {
    final controller = states.controller ?? getAdsController(status: 1);
    updateState((state) => state.copyWith(controller: controller));
  }

  PagingController<int, Ad> getAdsController({required int status}) {
    final controller = PagingController<int, Ad>(firstPageKey: 1);
    logger.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        try {
          List<Ad> adsList;
          switch (states.adListType) {
            case AdListType.homeList:
              adsList = await _adRepository.getHomeAds(
                pageKey,
                _pageSize,
                states.keyWord,
              );
            case AdListType.homePopularAds:
              adsList = await _adRepository.getPopularAdsByType(
                adType: AdType.product,
                page: pageKey,
                limit: _pageSize,
              );
            case AdListType.adsByUser:
              adsList = await _adRepository.getAdsByUser(
                sellerTin: states.sellerTin ?? -1,
                page: pageKey,
                limit: _pageSize,
              );
            case AdListType.similarAds:
              adsList = await _adRepository.getSimilarAds(
                adId: states.adId ?? 0,
                page: pageKey,
                limit: _pageSize,
              );
            case AdListType.popularCategoryAds:
              adsList = await _adRepository.getHomeAds(
                pageKey,
                _pageSize,
                states.keyWord,
              );
            case AdListType.cheaperAdsByAdType:
              adsList = await _adRepository.getCheapAdsByType(
                adType: states.collectiveType ?? AdType.product,
                page: pageKey,
                limit: _pageSize,
              );
            case AdListType.popularAdsByAdType:
              adsList = await _adRepository.getPopularAdsByType(
                adType: states.collectiveType ?? AdType.product,
                page: pageKey,
                limit: _pageSize,
              );
            case AdListType.recentlyViewedAds:
              adsList = await _adRepository.getRecentlyViewedAds(
                page: pageKey,
                limit: _pageSize,
              );
          }

          if (adsList.length <= 19) {
            controller.appendLastPage(adsList);
            logger.i(states.controller);
            return;
          }
          controller.appendPage(adsList, pageKey + 1);
          logger.i(states.controller);
        } catch (e) {
          controller.error = e;
        }
      },
    );
    return controller;
  }

  Future<void> updateCartInfo(Ad ad) async {
    try {
      if (ad.isInCart) {
        await _cartRepository.removeFromCart(ad.id);
        final index = states.controller?.itemList?.indexOf(ad) ?? 0;
        final item = states.controller?.itemList?.elementAt(index);
        if (item != null) {
          states.controller?.itemList?.insert(index, item..isInCart = false);
          states.controller?.itemList?.removeAt(index);
          states.controller?.notifyListeners();
        }
      } else {
        final backendId = await _cartRepository.addToCart(ad);
        final index = states.controller?.itemList?.indexOf(ad) ?? 0;
        final item = states.controller?.itemList?.elementAt(index);
        if (item != null) {
          states.controller?.itemList?.insert(
              index,
              item
                ..isInCart = true
                ..backendId = backendId);
          states.controller?.itemList?.removeAt(index);
          states.controller?.notifyListeners();
        }
      }
    } catch (error) {
      logger.w(error.toString());
    }
  }

  Future<void> updateFavoriteInfo(Ad ad) async {
    try {
      if (ad.isFavorite == true) {
        await _favoriteRepository.removeFromFavorite(ad.id);
        final index = states.controller?.itemList?.indexOf(ad) ?? 0;
        final item = states.controller?.itemList?.elementAt(index);
        if (item != null) {
          states.controller?.itemList?.insert(index, item..isFavorite = false);
          states.controller?.itemList?.removeAt(index);
          states.controller?.notifyListeners();
        }
      } else {
        final backendId = await _favoriteRepository.addToFavorite(ad);
        final index = states.controller?.itemList?.indexOf(ad) ?? 0;
        final item = states.controller?.itemList?.elementAt(index);
        if (item != null) {
          states.controller?.itemList?.insert(
              index,
              item
                ..isFavorite = true
                ..backendId = backendId);
          states.controller?.itemList?.removeAt(index);
          states.controller?.notifyListeners();
        }
      }
    } catch (error) {
      logger.w(error.toString());
    }
  }
}
