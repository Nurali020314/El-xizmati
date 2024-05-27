part of 'payment_transaction_filter_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default("") String fromDate,
    @Default("") String toDate,
    @Default("") String paymentType,
    @Default("") String paymentMethod,
    @Default("") String transactionState,
    //
    @Default(<PaymentFilter>[]) List<PaymentFilter> paymentTypes,
    @Default(<PaymentFilter>[]) List<PaymentFilter> paymentMethods,
    @Default(<PaymentFilter>[]) List<PaymentFilter> transactionStates,
    //
    @Default(<PaymentTransaction>[]) List<PaymentTransaction> transactions,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}