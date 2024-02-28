part of 'category_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(<CategoryResponse>[]) List<CategoryResponse> items,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
