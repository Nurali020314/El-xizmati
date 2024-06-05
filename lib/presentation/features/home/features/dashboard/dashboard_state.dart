part of 'dashboard_cubit.dart';

@freezed
class DashboardState with _$DashboardState {
  const DashboardState._();

  @freezed
  const factory DashboardState({
    @Default([]) List<PopularCategory> popularCategories,
    @Default(LoadingState.loading) LoadingState popularCategoriesState,
//
    @Default(<Ad>[]) List<Ad> popularProductAds,
    @Default(LoadingState.loading) LoadingState popularProductAdsState,
//
    @Default(<Ad>[]) List<Ad> popularServiceAds,
    @Default(LoadingState.loading) LoadingState popularServiceAdsState,
//
    @Default(<Ad>[]) List<Ad> topRatedAds,
    @Default(LoadingState.loading) LoadingState topRatedAdsState,
//
    @Default(<Ad>[]) List<Ad> recentlyViewedAds,
    @Default(LoadingState.loading) LoadingState recentlyViewedAdsState,
//
    @Default(<BannerResponse>[]) List<BannerResponse> banners,
    @Default(LoadingState.loading) LoadingState bannersState,
  }) = _DashboardState;
}

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent() = _DashboardEvent;
}