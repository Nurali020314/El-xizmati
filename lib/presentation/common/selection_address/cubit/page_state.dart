part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(LoadingState.loading) LoadingState loadState,
    @Default([]) List<RegionItem> initialSelectedItems,
    @Default([]) List<Region> allRegions,
    @Default([]) List<District> allDistricts,
    @Default([]) List<RegionItem> allItems,
    @Default([]) List<RegionItem> visibleItems,
    int? regionId,
    int? districtId,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
