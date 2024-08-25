import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/extensions/list_extensions.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/core/handler/future_handler_exts.dart';
import 'package:El_xizmati/data/repositories/region_repository.dart';
import 'package:El_xizmati/data/repositories/user_repository.dart';
import 'package:El_xizmati/domain/models/district/district.dart';
import 'package:El_xizmati/domain/models/region/region.dart';
import 'package:El_xizmati/domain/models/street/street.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'profile_edit_cubit.freezed.dart';
part 'profile_edit_state.dart';

@injectable
class ProfileEditCubit extends BaseCubit<ProfileEditState, ProfileEditEvent> {
  final RegionRepository _regionRepository;
  final UserRepository _userRepository;

  ProfileEditCubit(
    this._regionRepository,
    this._userRepository,
  ) : super(ProfileEditState()) {
    getUserProfile();
  }

  Future<void> getUser() async {
    await Future.wait([
      getRegions(),
      getDistrict(),
      getStreets(),
    ]);
  }

  Future<void> getUserProfile() async {
    try {
      final response = await _userRepository.getUser();
      updateState((state) => states.copyWith(
            userName: response.username ?? "",
            fullName: response.full_name?.capitalizePersonName() ?? "",
            phoneNumber: response.mobile_phone?.clearPhoneWithoutCode() ?? "",
            email: response.email ?? "",
            birthDate: response.birth_date ?? "",
            docNumber: response.passport_number ?? "",
            docSeries: response.passport_serial ?? "",
            apartmentNumber: response.home_name ?? "",
            districtId: response.district_id,
            regionId: response.region_id,
            neighborhoodId: response.mahalla_id,
            homeNumber: response.home_name.toString(),
            pinfl: response.pinfl,
            tin: response.tin,
            gender: response.gender,
            postName: response.post_name,
          ));
      await getUser();
    } catch (e) {
      logger.w("getUserProfile error = ${e.toString()}");
    }
  }

  Future<void> updateUserProfile() async {
    _userRepository
        .updateUserProfile(
          email: states.email,
          gender: states.gender ?? "",
          homeName: states.neighborhoodName,
          neighborhoodId: states.neighborhoodId ?? -1,
          mobilePhone: states.mobileNumber?.clearPhoneWithCode() ?? "",
          phoneNumber: states.phoneNumber.clearPhoneWithCode(),
          photo: states.photo ?? "",
          pinfl: states.pinfl ?? -1,
          docSeries: states.docSeries.toUpperCase(),
          docNumber: states.docNumber,
          birthDate: states.birthDate,
          postName: states.postName ?? "",
        )
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          stateMessageManager
              .showSuccessSnackBar(Strings.messageChangesSavingSuccess);
        })
        .onError((error) {
          stateMessageManager
              .showErrorSnackBar(Strings.messageChangesSavingFailed);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getRegions() async {
    final response = await _regionRepository.getRegions();
    final regionList = response.where((e) => e.id == states.regionId);
    if (regionList.isNotEmpty) {
      updateState((state) => states.copyWith(
          regions: response,
          regionName: regionList.first.name,
          isLoading: false));
    } else {
      updateState((state) => states.copyWith(regionName: "", isLoading: false));
    }
  }

  Future<void> getDistrict() async {
    final regionId = states.regionId;
    if (regionId == null) return;

    final districts = await _regionRepository.getDistricts(regionId);
    if (states.districtId != null) {
      updateState((state) => states.copyWith(
            districts: districts,
            districtName:
                districts.firstIf((e) => e.id == states.districtId)?.name ?? "",
          ));
    } else {
      updateState((state) => states.copyWith(districts: districts));
    }
  }

  Future<void> getStreets() async {
    try {
      final districtId = states.districtId!;
      final neighborhoods = await _regionRepository.getNeighborhoods(districtId);
      if (states.neighborhoodId != null) {
        updateState((state) => states.copyWith(
              neighborhoods: neighborhoods,
              neighborhoodName: neighborhoods
                      .firstIf((e) => e.id == states.neighborhoodId)
                      ?.name ??
                  "",
              isLoading: false,
            ));
      } else {
        updateState((state) => states.copyWith(
              neighborhoods: neighborhoods,
              isLoading: false,
            ));
      }
    } catch (e) {
      stateMessageManager.showErrorSnackBar("neighborhood error $e");
      updateState((state) => states.copyWith(isLoading: false));
    }
  }

  void setDocSeries(String docSeries) {
    updateState((state) => states.copyWith(docSeries: docSeries));
  }

  void setDocNumber(String docNumber) {
    updateState((state) => states.copyWith(
          docNumber: docNumber.replaceAll(" ", ""),
        ));
  }

  void setBrithDate(String brithDate) {
    updateState((state) => states.copyWith(birthDate: brithDate));
  }

  void setEmail(String email) {
    updateState((state) => states.copyWith(email: email));
  }

  void setPhoneNumber(String phone) {
    updateState((state) => states.copyWith(
        phoneNumber: phone.replaceAll(" ", "").replaceAll("+", "")));
  }

  Future<void> setRegion(Region region) async {
    await updateState((state) => states.copyWith(
          regionId: region.id,
          regionName: region.name,
          districtId: null,
          districtName: "",
          neighborhoodId: null,
          neighborhoodName: "",
        ));

    getDistrict();
  }

  void setDistrict(District district) {
    updateState((state) => states.copyWith(
          districtId: district.id,
          districtName: district.name,
          neighborhoodId: null,
          neighborhoodName: "",
        ));
    getStreets();
  }

  void setNeighborhood(Neighborhood neighborhood) {
    updateState((state) => states.copyWith(
          neighborhoodId: neighborhood.id,
          neighborhoodName: neighborhood.name,
        ));
  }
}
