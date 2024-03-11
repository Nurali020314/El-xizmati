import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/profile/user_full/user_full_info_response.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/domain/models/social/social_network.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../data/repositories/auth_repository.dart';
import '../../../../../../../data/repositories/user_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._authRepository, this._userRepository) : super(PageState()) {
    getActiveDeviceController();
    getSocial();
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> getUser() async {
    try {
      updateState((state) => state.copyWith(isLoading: true));

      await Future.wait([
        getRegions(),
        getDistrict(),
        getStreets(),
      ]);

      updateState((state) => state.copyWith(isLoading: false));
    } catch (e) {
      log.e(e.toString());

      updateState((state) => state.copyWith(isLoading: false));
    }
  }

  Future<void> getUserInformation() async {
    try {
      updateState((state) => state.copyWith(isLoading: true));
      log.e("getUserInformation onLoading");
      final response = await _userRepository.getFullUserInfo();
      var instagram=response.socials?.where((element) => element.type=="INSTAGRAM").toList();
      var telegram=response.socials?.where((element) => element.type=="TELEGRAM").toList();
      var facebook=response.socials?.where((element) => element.type=="FACEBOOK").toList();
      var youtube=response.socials?.where((element) => element.type=="YOUTUBE").toList();
      updateState(
        (state) => state.copyWith(
          isLoading: false,
          userName: (response.full_name ?? "*"),
          fullName: response.full_name ?? "*",
          phoneNumber: response.mobile_phone ?? "*",
          email: response.email ?? "*",
          photo: response.photo ?? "",
          biometricInformation:
              "${response.passport_serial ?? ""} ${response.passport_number ?? ""}",
          brithDate: response.birth_date ?? "*",
          districtName: (response.district_id ?? "*").toString(),
          isRegistered: response.is_registered ?? false,
          regionId: response.region_id,
          districtId: response.district_id,
          gender: response.gender ?? "*",
          streetId: response.mahalla_id,
          smsNotification: response.message_type.toString().contains("SMS"),
          telegramNotification: response.message_type.toString().contains("TELEGRAM"),
          emailNotification: response.message_type.toString().contains("EMAIL"),
        //  instagramSocial: SocialElement(
        //    type: instagram?[0].type ?? "",
        //    link: instagram?[0].link ?? "",
        //    status: instagram?[0].status ?? "",
        //    isLink: true,
        //    id: instagram?[0].id ?? 0,
        //    tin: instagram?[0].tin ?? 0,
        //    viewNote: instagram?[0].viewNote,
        //  ),
      ///  telegramSocial: SocialElement(
      ///    type: telegram?[0].type ?? "",
      ///    link: telegram?[0].link ?? "",
      ///    status: telegram?[0].status ?? "",
      ///    isLink: true,
      ///    id: telegram?[0].id ?? 0,
      ///    tin: telegram?[0].tin ?? 0,
      ///    viewNote: telegram?[0].viewNote,
      ///  ),
      ///  facebookSocial: SocialElement(
      ///    type: facebook?[0].type ?? "",
      ///    link: facebook?[0].link ?? "",
      ///    status: facebook?[0].status ?? "",
      ///    isLink: true,
      ///    id: facebook?[0].id ?? 0,
      ///    tin: facebook?[0].tin ?? 0,
      ///    viewNote: facebook?[0].viewNote,
      ///  ),
      ///  youtubeSocial: SocialElement(
      ///    type: youtube?[0].type ?? "",
      ///    link: youtube?[0].link ?? "",
      ///    status: youtube?[0].status ?? "",
      ///    isLink: true,
      ///    id: youtube?[0].id ?? 0,
      ///    tin: youtube?[0].tin ?? 0,
      ///    viewNote: youtube?[0].viewNote,
      ///  ),
        ),
      );
      log.e("getUserInformation onSuccess");
      await getUser();
    } on DioException catch (e) {
      log.e("getUserInformation onFailure error = ${e.toString()}");

      updateState((state) => state.copyWith(isLoading: false));

      if (e.response?.statusCode == 401) {
        logOut();
      }
      // display.error(e.toString());
    }
  }


  Future<void> getRegions() async {
    final response = await _userRepository.getRegions();
    final regionList = response.where((e) => e.id == states.regionId);
    if (regionList.isNotEmpty) {
      updateState((state) =>
          state.copyWith(regionName: regionList.first.name, isLoading: false));
    } else {
      updateState(
        (state) => state.copyWith(regionName: "topilmadi", isLoading: false),
      );
    }
  }

  Future<void> getDistrict() async {
    final regionId = states.regionId;
    final response = await _userRepository.getDistricts(regionId ?? 14);
    updateState((state) => state.copyWith(
        districtName: response
            .where((element) => element.id == states.districtId)
            .first
            .name));
  }

  Future<void> getStreets() async {
    try {
      final districtId = states.districtId;
      final response = await _userRepository.getNeighborhoods(districtId ?? 1419);
      updateState((state) => state.copyWith(
          streetName: response
              .where((element) => element.id == states.streetId)
              .first
              .name,
          isLoading: false));
    } catch (e) {
      updateState((state) => state.copyWith(isLoading: false));
    }
  }

  Future<void> getSocial() async{
    try {
      updateState((state) => state.copyWith(isLoading: true));
      log.e("getUserInformation onLoading");
      final response = await _userRepository.getFullUserInfo();
      var instagram=response.socials?.where((element) => element.type=="INSTAGRAM").toList();
      var telegram=response.socials?.where((element) => element.type=="TELEGRAM").toList();
      var facebook=response.socials?.where((element) => element.type=="FACEBOOK").toList();
      var youtube=response.socials?.where((element) => element.type=="YOUTUBE").toList();
       if(instagram!=null && telegram!=null && facebook!=null){
         updateState(
               (state) => state.copyWith(
             instagramSocial: SocialElement(
               type: instagram?[0].type ?? "",
               link: instagram?[0].link ?? "",
               status: instagram?[0].status ?? "",
               isLink: true,
               id: instagram?[0].id ?? 0,
               tin: instagram?[0].tin ?? 0,
               viewNote: instagram?[0].viewNote,
             ),
             telegramSocial: SocialElement(
               type: telegram?[0].type ?? "",
               link: telegram?[0].link ?? "",
               status: telegram?[0].status ?? "",
               isLink: true,
               id: telegram?[0].id ?? 0,
               tin: telegram?[0].tin ?? 0,
               viewNote: telegram?[0].viewNote,
             ),
             facebookSocial: SocialElement(
               type: facebook?[0].type ?? "",
               link: facebook?[0].link ?? "",
               status: facebook?[0].status ?? "",
               isLink: true,
               id: facebook?[0].id ?? 0,
               tin: facebook?[0].tin ?? 0,
               viewNote: facebook?[0].viewNote,
             ),
             youtubeSocial: SocialElement(
               type: youtube?[0].type ?? "",
               link: youtube?[0].link ?? "",
               status: youtube?[0].status ?? "",
               isLink: true,
               id: youtube?[0].id ?? 0,
               tin: youtube?[0].tin ?? 0,
               viewNote: youtube?[0].viewNote,
             ),
           ),
         );
       }

      log.e("getUserInformation onSuccess");
      await getUser();
    } on DioException catch (e) {
      log.e("getUserInformation onFailure error = ${e.toString()}");
      updateState((state) => state.copyWith(isLoading: false));
      if (e.response?.statusCode == 401) {
        logOut();
      }
      // display.error(e.toString());
    }
  }


  Future<void> logOut() async {
    await _authRepository.logOut();
    emitEvent(PageEvent(PageEventType.onLogout));
  }

  setSmsNotification() {
    updateState(
      (state) => state.copyWith(
          smsNotification: !state.smsNotification,
          enableButton: [
            !states.enableButton[0],
            states.enableButton[1],
            states.enableButton[2]
          ]),
    );
  }

  setEmailNotification() {
    updateState(
      (state) => state.copyWith(
          emailNotification: !state.emailNotification,
          enableButton: [
            states.enableButton[0],
            !states.enableButton[1],
            states.enableButton[2]
          ]),
    );
  }

  setTelegramNotification() {
    updateState(
      (state) => state.copyWith(
          telegramNotification: !state.telegramNotification,
          enableButton: [
            states.enableButton[0],
            states.enableButton[1],
            !states.enableButton[2]
          ]),
    );
  }

  bool getEnableButton() {
    return states.enableButton.every((element) => element == false);
  }

  setInstagramSocial(String status) {
    if (states.instagramSocial?.status == "REJECTED") {
      status = "WAIT";
    } else {
      status = "REJECTED";
    }
    updateState((state) => state.copyWith(
          instagramSocial: SocialElement(
            type: states.instagramSocial?.type ?? "",
            link: states.instagramSocial?.link ?? "",
            status: status,
            isLink: false,
            id: states.instagramSocial?.id ?? 0,
            tin: states.instagramSocial?.tin ?? 0,
            viewNote: states.instagramSocial?.viewNote,
          ),
        ));
  }

  setTelegramSocial(String status) {
    if (states.telegramSocial?.status == "REJECTED") {
      status = "WAIT";
    } else {
      status = "REJECTED";
    }
    updateState((state) => state.copyWith(
          telegramSocial: SocialElement(
            type: states.telegramSocial?.type ?? "",
            link: states.telegramSocial?.link ?? "",
            status: status,
            isLink: false,
            id: states.telegramSocial?.id ?? 0,
            tin: states.telegramSocial?.tin ?? 0,
            viewNote: states.telegramSocial?.viewNote,
          ),
        ));
  }

  setFacebookSocial(String status) {
    if (states.facebookSocial?.status == "REJECTED") {
      status = "WAIT";
    } else {
      status = "REJECTED";
    }
    updateState((state) => state.copyWith(
          facebookSocial: SocialElement(
            type: states.facebookSocial?.type ?? "",
            link: states.facebookSocial?.link ?? "",
            status: status,
            isLink: false,
            id: states.facebookSocial?.id ?? 0,
            tin: states.facebookSocial?.tin ?? 0,
            viewNote: states.facebookSocial?.viewNote,
          ),
        ));
  }

  setYoutubeSocial(String status) {
    if (states.youtubeSocial?.status == "REJECTED") {
      status = "WAIT";
    } else {
      status = "REJECTED";
    }
    updateState((state) => state.copyWith(
          youtubeSocial: SocialElement(
            type: states.youtubeSocial?.type ?? "",
            link: states.youtubeSocial?.link ?? "",
            status: status,
            isLink: false,
            id: states.youtubeSocial?.id ?? 0,
            tin: states.youtubeSocial?.tin ?? 0,
            viewNote: states.youtubeSocial?.viewNote,
          ),
        ));
  }

  void clearList() {
    updateState(
      (state) => state.copyWith(enableButton: [false, false, false]),
    );
  }

  Future<bool> setMessageType(String messageType) async {
    if (states.smsNotification) {
      messageType = "SMS";
    }
    if (states.emailNotification) {
      messageType = "$messageType,EMAIL";
    }
    if (states.telegramNotification) {
      messageType = "$messageType,TELEGRAM";
    }
    updateState((state) => state.copyWith(isLoadingNotification: true));
    try {
      log.w(messageType);
      final response =
          await _userRepository.sendMessageType(messageType: messageType);
    } on DioException catch (error) {
      return false;
    } finally {
      updateState((state) => state.copyWith(isLoadingNotification: false));
    }
    return true;
  }

  Future<bool> sendSocials() async {
    Social socials = Social(socials: [
      states.instagramSocial!,
      states.telegramSocial!,
      states.facebookSocial!,
      states.youtubeSocial!,
    ]);
    updateState((state) => state.copyWith(isLoadingSocial: true));
    try {
      final response = await _userRepository.sendSocials(social: socials);
    } on DioException catch (error) {
      return false;
    } finally {
      updateState((state) => state.copyWith(isLoadingSocial: false));
    }
    return true;
  }

  Future<void> openTelegram() async {
    try {
      var url = Uri.parse("https://t.me/online_bozor_rs_bot");
      await launchUrl(url);
    } catch (error) {
      log.e(error.toString());
    }
  }

  Future<void> getActiveDeviceController() async {
    try {
      final controller = states.controller ?? getActiveDevices(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(states.controller);
    }
  }

  PagingController<int, ActiveSession> getActiveDevices({
    required int status,
  }) {
    final controller = PagingController<int, ActiveSession>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    log.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        final items = await _userRepository.getActiveDevice();
        if (items.length <= 1000) {
          if (items.length > 2) {
            controller.appendLastPage(items.sublist(0, 2));
          } else {
            controller.appendLastPage(items);
          }
          log.i(states.controller);
          return;
        }
        controller.appendPage(items, pageKey + 1);
        log.i(states.controller);
      },
    );
    return controller;
  }

  Future<void> removeActiveDevice(ActiveSession session) async {
    try {
      await _userRepository.removeActiveResponse(session);
    } catch (error) {
      log.e(error.toString());
    }
  }
}
