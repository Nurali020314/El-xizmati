part of 'ad_list_cubit.dart';

@freezed
class AdListBuildable with _$AdListBuildable {
  const factory AdListBuildable({
    @Default("") String keyWord,
    @Default(AdListType.homePopularAds) AdListType adListType,
    @Default(AppLoadingState.loading) AppLoadingState adsState,
    PagingController<int, Ad>? adsPagingController,
    int? sellerTin,
    int? adId,
    CollectiveType? collectiveType,
  }) = _AdListBuildable;
}

@freezed
class AdListListenable with _$AdListListenable {
  const factory AdListListenable(AdListEffect effect, {String? message}) =
      _AdListListenable;
}

enum AdListEffect { success, navigationToAuthStart }
