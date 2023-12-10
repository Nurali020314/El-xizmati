import '../../data/responses/address/user_address_response.dart';

abstract class UserAddressRepository {
  Future<List<UserAddressResponse>> getUserAddresses();

  Future<void> addUserAddress(
      {required String name,
      required int regionId,
      required int districtId,
      required int mahallaId,
      required String homeNum,
      required String apartmentNum,
      required String streetNum,
      required bool isMain,
      required String? geo});

  Future<void> updateUserAddress(
      {required String name,
      required int regionId,
      required int districtId,
      required int mahallaId,
      required String homeNum,
      required String apartmentNum,
      required String streetNum,
      required bool isMain,
      required String? geo,
      required int id,
      required String state});

  Future<void> updateMainAddress({required int id, required bool isMain});

  Future<void> deleteAddress({required int id});
}