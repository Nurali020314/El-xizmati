import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/enum/enums.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/models/ad.dart';
import '../../../../domain/repositories/ad_repository.dart';
import '../../../../domain/repositories/common_repository.dart';
import '../../../../domain/repositories/favorite_repository.dart';

part 'ad_collection_cubit.freezed.dart';
part 'ad_collection_state.dart';

@injectable
class AdCollectionCubit extends BaseCubit<AdCollectionBuildable, AdCollectionListenable> {
  AdCollectionCubit(
      this.adRepository, this.commonRepository, this.favoriteRepository)
      : super(AdCollectionBuildable());

  Future<void> setCollectionType(CollectiveType collectiveType) async {
    build((buildable) => buildable.copyWith(collectiveType: collectiveType));
    getHome();
  }

  Future<void> getHome() async {
    await Future.wait([
      getCollectiveCheapAds(),
      getCollectivePopularAds(),
      getController(),
    ]);
  }

  static const _pageSize = 20;

  final AdRepository adRepository;
  final CommonRepository commonRepository;
  final FavoriteRepository favoriteRepository;

  Future<void> getCollectiveCheapAds() async {
    try {
      final cheapAds = await adRepository.getCollectiveCheapAds(
          collectiveType: buildable.collectiveType,
          pageIndex: 1,
          pageSize: 10);
      build((buildable) => buildable.copyWith(
          cheapAds: cheapAds, cheapAdsState: AppLoadingState.success));
    } on DioException catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(cheapAdsState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getCollectivePopularAds() async {
    try {
      final popularAds = await adRepository.getCollectivePopularAds(
          collectiveType: buildable.collectiveType, pageIndex: 1, pageSize: 10);
      build((buildable) => buildable.copyWith(
          popularAds: popularAds, popularAdsState: AppLoadingState.success));
    } on DioException catch (e, stackTrace) {
      build((buildable) =>
          buildable.copyWith(popularAdsState: AppLoadingState.error));
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    }
  }

  Future<void> getController() async {
    try {
      final controller =
          buildable.adsPagingController ?? getAdsController(status: 1);
      build((buildable) => buildable.copyWith(adsPagingController: controller));
    }on DioException  catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.adsPagingController);
    }
  }

  PagingController<int, Ad> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, Ad>(
      firstPageKey: 1,
    );
    log.i(buildable.adsPagingController);

    adController.addPageRequestListener(
          (pageKey) async {
        final adsList = await adRepository.getCollectiveAds(
            collectiveType: buildable.collectiveType,
            pageIndex: pageKey,
            pageSize: _pageSize);
        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          log.i(buildable.adsPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(buildable.adsPagingController);
      },
    );
    return adController;
  }

  Future<void> popularAdsAddFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
      final backendId = await favoriteRepository.addFavorite(ad);
        final index = buildable.popularAds.indexOf(ad);
        final item = buildable.popularAds.elementAt(index);
        buildable.popularAds.insert(
          index,
          item
            ..favorite = true
            ..backendId = backendId,
        );
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = buildable.popularAds.indexOf(ad);
        final item = buildable.popularAds.elementAt(index);
        buildable.popularAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> cheapAdsAddFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index = buildable.cheapAds.indexOf(ad);
        final item = buildable.cheapAds.elementAt(index);
        buildable.cheapAds.insert(
            index,
            item
              ..favorite = true
              ..backendId = backendId);
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index = buildable.cheapAds.indexOf(ad);
        final item = buildable.cheapAds.elementAt(index);
        buildable.cheapAds.insert(index, item..favorite = false);
      }
    } on DioException catch (error) {
      display.error("xatolik yuz  berdi");
      log.e(error.toString());
    }
  }

  Future<void> addFavorite(Ad ad) async {
    try {
      if (!ad.favorite) {
        final backendId = await favoriteRepository.addFavorite(ad);
        final index =
            buildable.adsPagingController?.itemList?.indexOf(ad) ?? 0;
        final item = buildable.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          buildable.adsPagingController?.itemList?.insert(
              index,
              item
                ..favorite = true
                ..backendId = backendId);
          buildable.adsPagingController?.itemList?.removeAt(index);
          buildable.adsPagingController?.notifyListeners();
        }
      } else {
        await favoriteRepository.removeFavorite(ad);
        final index =
            buildable.adsPagingController?.itemList?.indexOf(ad) ?? 0;
        final item = buildable.adsPagingController?.itemList?.elementAt(index);
        if (item != null) {
          buildable.adsPagingController?.itemList
              ?.insert(index, item..favorite = false);
          buildable.adsPagingController?.itemList?.removeAt(index);
          buildable.adsPagingController?.notifyListeners();
        }
      }
    } on DioException catch (error) {
      display.error("xatolik yuz  berdi");
      log.e(error.toString());
    }
  }
}
