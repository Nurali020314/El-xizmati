import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/storages/token_storage.dart';

import '../../../data/constants/rest_header_keys.dart';
import '../../constants.dart';

@lazySingleton
class AppInterceptor extends QueuedInterceptor {
  AppInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final headers = {'AppVersionCode': DeviceInfo.appVersionCode};
    headers['AppVersionName'] = DeviceInfo.appVersionName;
    headers['DeviceId'] = DeviceInfo.deviceId;
    headers['DeviceName'] = DeviceInfo.deviceName;
    headers['DeviceManufacturer'] = DeviceInfo.deviceManufacture;
    headers['DeviceModel'] = DeviceInfo.deviceModel;
    headers['User-Agent'] =
        "${DeviceInfo.deviceId}&&${DeviceInfo.deviceModel}&&${DeviceInfo.deviceName}&&APPLICATION";
    headers['MobileOs'] = DeviceInfo.mobileOs;
    headers['NightMode'] = DeviceInfo.nightMode;
    headers['MobileOsType'] = DeviceInfo.mobileOsType;
    headers['MobileOsVersion'] = "33";

    var token = _tokenStorage.token.call() ?? "";
    if (token.isNotEmpty) {
      headers[RestHeaderKeys.authorization] = "Bearer $token";
    }

    options.headers.addAll(headers);
    handler.next(options);
  }
}
