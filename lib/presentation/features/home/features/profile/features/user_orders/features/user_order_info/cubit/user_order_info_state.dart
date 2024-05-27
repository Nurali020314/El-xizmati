part of 'user_order_info_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    UserOrder? userOrder,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}