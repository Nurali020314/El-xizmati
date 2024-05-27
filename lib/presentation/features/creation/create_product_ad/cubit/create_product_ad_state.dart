part of 'create_product_ad_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(true) bool isFirstTime,
//
    int? adId,
    @Default(false) bool isEditing,
    @Default(true) bool isNotPrepared,
    @Default(false) bool isPreparingInProcess,
//
    @Default("") String title,
    CategoryResponse? category,
    @Default(AdTransactionType.SELL) AdTransactionType adTransactionType,
//
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
    List<UploadableFile>? pickedImages,
//
    @Default("") String desc,
    int? warehouseCount,
    UnitResponse? unit,
    @Default(1) int minAmount,
    int? price,
    Currency? currency,
    @Default([]) List<PaymentTypeResponse> paymentTypes,
    @Default(false) bool isAgreedPrice,
//
    @Default(true) bool isNew,
    @Default(false) bool isBusiness,
//
    @Default("") String exchangeTitle,
    @Default("") String exchangeDesc,
    CategoryResponse? exchangeCategory,
    @Default(true) bool isExchangeNew,
    @Default(false) bool isExchangeBusiness,
//
    UserAddress? address,
    @Default("") String contactPerson,
    @Default("") String phone,
    @Default("") String email,
//
    @Default(false) bool isPickupEnabled,
    @Default(false) bool isShowAllPickupAddresses,
    @Default([]) List<UserAddress> pickupWarehouses,
//
    @Default(false) bool isFreeDeliveryEnabled,
    @Default(false) bool isShowAllFreeDeliveryDistricts,
    @Default(5) int freeDeliveryMaxDay,
    @Default([]) List<District> freeDeliveryDistricts,
//
    @Default(false) bool isPaidDeliveryEnabled,
    @Default(false) bool isShowAllPaidDeliveryDistricts,
    @Default(5) int paidDeliveryMaxDay,
    int? paidDeliveryPrice,
    @Default([]) List<District> paidDeliveryDistricts,
//
    @Default(false) bool isAutoRenewal,
    @Default(false) bool isShowMySocialAccount,
    @Default("") String videoUrl,
//
    @Default(false) bool isRequestSending,
//
    @Default(LoadingState.loading) LoadingState itemsLoadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(
    PageEventType type, {
    @Default(MAX_IMAGE_COUNT) int maxImageCount,
  }) = _PageEvent;
}

enum PageEventType { onOverMaxCount, onAdCreated }

const int MAX_IMAGE_COUNT = 5;