import 'package:El_xizmati/data/datasource/floor/entities/user_entity.dart';
import 'package:El_xizmati/data/datasource/network/responses/auth/eds/eds_sign_in_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/auth/login/login_response.dart';

extension LoginUserResponseMapper on LoginUser {
  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      fullName: fullName ?? "",
      pinfl: pinfl,
      tin: tin,
      gender: gender,
      docSeries: docSeries,
      docNumber: docNumber,
      regionId: regionId,
      regionName: "",
      districtId: districtId,
      districtName: "",
      neighborhoodId: neighborhoodId,
      neighborhoodName: "",
      houseNumber: homeName,
      apartmentName: apartmentName,
      birthDate: birthDate ?? "",
      photo: photo ?? "",
      email: email ?? "",
      phone: mobilePhone ?? "",
      notificationSource: "",
      isIdentified: isRegistered ?? false,
      state: state,
    );
  }
}

extension EdsUserResponseMapper on EdsUserResponse {
  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      fullName: fullName ?? "",
      pinfl: pinfl,
      tin: tin,
      gender: gender,
      docSeries: passportSerial,
      docNumber: passportNumber,
      regionId: oblId,
      regionName: "",
      districtId: areaId,
      districtName: "",
      neighborhoodId: districtId,
      neighborhoodName: "",
      houseNumber: homeName,
      apartmentName: apartmentName,
      birthDate: birthDate ?? "",
      photo: photo ?? "",
      email: email ?? "",
      phone: mobilePhone ?? "",
      notificationSource: "",
      isIdentified: isRegistered ?? false,
      state: state,
    );
  }
}
