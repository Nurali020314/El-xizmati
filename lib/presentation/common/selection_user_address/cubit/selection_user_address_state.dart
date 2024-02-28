part of 'selection_user_address_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(<UserAddressResponse>[]) List<UserAddressResponse> items,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
