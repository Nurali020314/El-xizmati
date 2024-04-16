import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/street/street.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/repositories/user_address_repository.dart';
import '../../../../../../../../../data/repositories/user_repository.dart';
import '../../../../../../../../../data/responses/address/user_address_response.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class AddAddressCubit extends BaseCubit<PageState, PageEvent> {
  AddAddressCubit(
    this._userRepository,
    this._userAddressRepository,
  ) : super(PageState()) {
    getRegions();
  }

  final UserAddressRepository _userAddressRepository;
  final UserRepository _userRepository;

  void setInitialParams(UserAddressResponse? address) {
    if (address != null) {
      updateState(
        (state) => state.copyWith(
          isEditing: true,
          address: address,
          addressId: address.id,
          isMain: address.is_main,
          geo: address.geo,
          regionId: address.region?.id,
          regionName: address.region?.name,
          districtId: address.district?.id,
          districtName: address.district?.name,
          neighborhoodId: address.mahalla?.id,
          neighborhoodName: address.mahalla?.name,
          addressName: address.name,
          streetName: address.street_num,
          homeNumber: address.home_num,
          apartmentNum: address.apartment_num,
        ),
      );
    } else {
      updateState((state) => state.copyWith(addressId: null));
    }
  }

  void setEnteredAddressName(String addressName) {
    updateState((state) => state.copyWith(addressName: addressName));
  }

  void setSelectedRegion(Region region) {
    updateState((state) => state.copyWith(
          regionId: region.id,
          regionName: region.name,
          districtId: null,
          districtName: null,
          neighborhoodId: null,
          neighborhoodName: null,
        ));
    getDistrict();
  }

  void setSelectedDistrict(District district) {
    updateState((state) => state.copyWith(
          districtId: district.id,
          districtName: district.name,
          neighborhoodId: null,
          neighborhoodName: null,
        ));
    getNeighborhoods();
  }

  void setSelectedNeighborhood(Neighborhood neighborhood) {
    updateState((state) => state.copyWith(
          neighborhoodId: neighborhood.id,
          neighborhoodName: neighborhood.name,
        ));
  }

  void setStreetName(String value) {
    updateState((state) => state.copyWith(streetName: value));
  }

  void setHomeNumber(String value) {
    updateState((state) => state.copyWith(homeNumber: value));
  }

  void setApartmentNumber(String value) {
    updateState((state) => state.copyWith(apartmentNum: value));
  }

  void setMainCard(bool? isMain) {
    updateState((state) => state.copyWith(isMain: isMain));
  }

  Future<void> addOrUpdateAddress() async {
    if (states.isEditing) {
      await updateAddress();
    } else {
      await addAddress();
    }
  }

  Future<void> addAddress() async {
    updateState((state) => state.copyWith(isLoading: true));
    try {
      await _userAddressRepository.addUserAddress(
        name: states.addressName!,
        regionId: states.regionId!,
        districtId: states.districtId!,
        neighborhoodId: states.neighborhoodId!,
        homeNum: states.homeNumber?.trim() ?? "",
        apartmentNum: states.apartmentNum?.trim() ?? "",
        streetName: states.streetName?.trim() ?? "",
        isMain: states.isMain ?? false,
        geo: "${states.latitude},${states.longitude}",
      );

      updateState((state) => state.copyWith(isLoading: false));
      emitEvent(PageEvent(PageEventType.backOnSuccess));
    } catch (e) {
      updateState((state) => state.copyWith(isLoading: false));
      display.error(Strings.commonEmptyMessage);
    }
  }

  Future<void> updateAddress() async {
    updateState((state) => state.copyWith(isLoading: true));
    try {
      await _userAddressRepository.updateUserAddress(
        id: states.addressId!,
        name: states.addressName!,
        regionId: states.regionId!,
        districtId: states.districtId!,
        neighborhoodId: states.neighborhoodId!,
        homeNum: states.homeNumber?.trim() ?? "",
        apartmentNum: states.apartmentNum?.trim() ?? "",
        streetName: states.streetName?.trim() ?? "",
        isMain: states.isMain ?? false,
        geo: "${states.latitude},${states.longitude}",
        state: '',
      );

      updateState((state) => state.copyWith(isLoading: false));
      emitEvent(PageEvent(PageEventType.backOnSuccess));
    } catch (e) {
      updateState((state) => state.copyWith(isLoading: false));
      display.error(Strings.commonEmptyMessage);
    }
  }

  Future<void> getRegions() async {
    try {
      final regions = await _userRepository.getRegions();
      updateState((state) => state.copyWith(regions: regions));
    } catch (e) {
      display.error("street error $e");
      updateState((state) => state.copyWith());
    }
  }

  Future<void> getDistrict() async {
    final regionId = states.regionId;
    final districts = await _userRepository.getDistricts(regionId!);
    String? name;
    if (states.districtId != null) {
      name = districts.where((e) => e.id == states.districtId).first.name;
    }
    updateState((state) => state.copyWith(
          districts: districts,
          districtName: name,
        ));
  }

  Future<void> getNeighborhoods() async {
    try {
      final districtId = states.districtId;
      final neighborhoods = await _userRepository.getNeighborhoods(districtId!);
      String? name;
      if (states.neighborhoodId != null) {
        name = neighborhoods
            .where((e) => e.id == states.neighborhoodId)
            .first
            .name;
      }
      updateState((state) => state.copyWith(
            neighborhoods: neighborhoods,
            neighborhoodName: name,
          ));
    } catch (e) {
      display.error("street error $e");
      updateState((state) => state.copyWith());
    }
  }

  String getFormattedLocation() {
    return states.latitude == null || states.longitude == null
        ? ""
        : "${states.latitude}, ${states.longitude}";
  }

  Future<void> getCurrentLocation() async {
    updateState((state) => state.copyWith(isLocationLoading: true));
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case where the user has denied the permission
        updateState((state) => state.copyWith(isLocationLoading: false));
        return;
      } else {
        try {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          double lat = position.latitude;
          double long = position.longitude;

          updateState(
            (state) => state.copyWith(
              latitude: lat,
              longitude: long,
              isLocationLoading: false,
            ),
          );
          print("Latitude: $lat and Longitude: $long");
        } catch (e) {
          log.e(e.toString());
          updateState((state) => state.copyWith(isLocationLoading: false));
        }
      }
    } else {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        double lat = position.latitude;
        double long = position.longitude;
        updateState((state) => state.copyWith(
              latitude: lat,
              longitude: long,
              isLocationLoading: false,
            ));
        print("Latitude: $lat and Longitude: $long");
      } catch (e) {
        log.e(e.toString());
        updateState((state) => state.copyWith(isLocationLoading: false));
      }
    }
  }
}
