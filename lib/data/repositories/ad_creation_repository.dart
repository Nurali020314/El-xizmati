import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/responses/category/category_selection/category_selection_response.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/services/ad_creation_service.dart';

import '../responses/address/user_address_response.dart';
import '../responses/payment_type/payment_type_response.dart';
import '../responses/unit/unit_response.dart';
import '../storages/user_storage.dart';

@LazySingleton()
class AdCreationRepository {
  final AdCreationService _adCreationService;
  final UserInfoStorage _userInfoStorage;

  AdCreationRepository(this._adCreationService, this._userInfoStorage);

  Future<List<CategorySelectionResponse>> getCategoriesForCreationAd() async {
    final response = await _adCreationService.getCategoriesForCreationAd();
    final categories =
        CategorySelectionRootResponse.fromJson(response.data).data;
    return categories;
  }

  Future<List<CurrencyResponse>> getCurrenciesForCreationAd() async {
    final response = await _adCreationService.getCurrenciesForCreationAd();
    final currencies = CurrencyRootResponse.fromJson(response.data).data;
    return currencies;
  }

  Future<List<PaymentTypeResponse>> getPaymentTypesForCreationAd() async {
    final response = await _adCreationService.getPaymentTypesForCreationAd();
    final paymentTypes = PaymentTypeRootResponse.fromJson(response.data).data;
    return paymentTypes;
  }

  Future<List<UserAddressResponse>> getWarehousesForCreationAd() async {
    var tin = _userInfoStorage.userInformation.call()?.tin;
    var pinfl = _userInfoStorage.userInformation.call()?.pinfl;
    final response = await _adCreationService.getWarehousesForCreationAd(
      tinOrPinfl: tin ?? pinfl ?? 0,
    );
    final warehouses = UserAddressRootResponse.fromJson(response.data).data;
    return warehouses;
  }

  Future<List<UnitResponse>> getUnitsForCreationAd() async {
    final response = await _adCreationService.getUnitsForCreationAd();
    final units = UnitRootResponse.fromJson(response.data).data;
    return units;
  }

  Future<String> createProductAd({
    required String title,
    required CategoryResponse category,
    required pickedImageIds,
    required String desc,
    required int? warehouseCount,
    required UnitResponse? unit,
    required int? price,
    required CurrencyResponse? currency,
    required List<PaymentTypeResponse> paymentTypes,
    required bool isAgreedPrice,
    required bool isNew,
    required bool isBusiness,
    required UserAddressResponse? address,
    required String contactPerson,
    required String phone,
    required String email,
    required List<UserAddressResponse> pickupAddresses,
    required bool isAutoRenewal,
    required bool isShowMySocialAccount,
  }) async {
    final response = await _adCreationService.createProductAd(
      title: title,
      categoryId: category.id,
      pickedImageIds: [],
      desc: desc,
      warehouseCount: warehouseCount,
      unitId: unit?.id,
      price: price,
      currency: currency?.id,
      paymentTypeIds: paymentTypes.map((e) => "${e.id}").toList(),
      isAgreedPrice: isAgreedPrice,
      isNew: isNew,
      isBusiness: isBusiness,
      addressId: address?.id,
      contactPerson: contactPerson,
      phone: phone,
      email: email,
      isAutoRenewal: isAutoRenewal,
      isShowMySocialAccount: isShowMySocialAccount,
    );

    return "";
  }
}