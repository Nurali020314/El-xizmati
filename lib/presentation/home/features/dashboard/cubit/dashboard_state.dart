part of 'dashboard_cubit.dart';

@freezed
class DashboardBuildable with _$DashboardBuildable {
  const DashboardBuildable._();

  @freezed
  const factory DashboardBuildable({
    @Default(AppLoadingState.loading) AppLoadingState popularCategoriesState,
    @Default(AppLoadingState.loading) AppLoadingState recentlyAdsState,
    @Default(AppLoadingState.loading) AppLoadingState bannersState,
    @Default(<PopularCategoryResponse>[]) List<PopularCategoryResponse> popularCategories,
    @Default(<Ad>[]) List<Ad> recentlyViewerAds,
    @Default(<BannerResponse>[]) List<BannerResponse> banners,
    @Default(<Ad>[]) List<Ad> adsList,
    PagingController<int, Ad>? adsPagingController,
  }) = _DashboardBuildable;
}

@freezed
class DashboardListenable with _$DashboardListenable {
  const factory DashboardListenable(DashboardEffect effect, {String? message}) =
      _DashboardListenable;
}

enum DashboardEffect { success, navigationToAuthStart }