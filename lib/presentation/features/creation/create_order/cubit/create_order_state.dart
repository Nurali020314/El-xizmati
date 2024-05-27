part of 'create_order_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    int? adId,
    AdDetail? adDetail,
    @Default(false) bool favorite,
//
    @Default(1) int paymentId,
    @Default(<int>[]) List<int> paymentType,
    @Default(1) int count,
    @Default(false) bool hasRangePrice,
    int? price,
//
    @Default(false) bool isRequestSending,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type, {String? message}) = _PageEvent;
}

enum PageEventType {
  onBackAfterRemove,
  onOpenAfterCreation,
  onOpenAuthStart,
  onFailedOrderCreation,
  // onFailedIdentityNotVerified,
}