part of 'selection_currency_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(<CurrencyResponse>[]) List<CurrencyResponse> items,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}
