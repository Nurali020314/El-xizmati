import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/error/app_exception.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/error/app_network_exception.dart';
import 'package:onlinebozor/data/mappers/exception_exts.dart';

extension ExceptionMessageExts on Exception {
  String get localizedMessage {
    Logger().w("localizedMessage => Exception $this");
    if (this is AppNetworkException) {
      Logger().w("localizedMessage => AppNetworkException $this");
      return (this as AppNetworkException).localizedMessage;
    } else if (this is AppLocalException) {
      Logger().w("localizedMessage => AppLocalException $this");
      return (this as AppLocalException).localizedMessage;
    } else {
      Logger().w("localizedMessage => e = $toString()");
      return Strings.messageResponseError;
    }
  }
}

extension ObjectExceptionExts on Object {
  String get localizedMessage {
    if (this is Exception) {
      return (this as Exception).localizedMessage;
    } else {
      return toString();
    }
  }

  AppException toAppException(StackTrace? stackTrace) {
    if(this is AppException) {
      return this as AppException;
    } else if (this is DioError) {
      return (this as DioError).errorToAppNetworkException();
    } else if (this is DioException) {
      return (this as DioException).toAppNetworkException();
    } else {
      return AppNetworkDioException(message: "Unknown error", statusCode: 1);
    }
  }
}

extension AppLocalxceptionMessageExts on AppLocalException {
  String get localizedMessage {
    if (this is NotAuthorizedException) {
      Logger().w("localizedMessage => NotAuthorizedException");
      return Strings.messageUserNotAuthorized;
    }
    if (this is NotIdentifiedException) {
      Logger().w("localizedMessage => NotIdentifiedException");
      return Strings.messageUserIdentityNotVerified;
    }
    return Strings.messageUnknownError;
  }
}

extension AppNetworkExceptionMessageExts on AppNetworkException {
  String get localizedMessage {
    if (this is AppNetworkConnectionException) {
      Logger().w("localizedMessage => AppNetworkConnectionException");
      return Strings.messageConnectionError;
    } else if (this is AppNetworkDioException) {
      Logger().w("localizedMessage => AppNetworkDioException");
      return Strings.messageResponseError;
    } else if (this is AppNetworkHttpException) {
      Logger().w("localizedMessage => AppNetworkHttpException");
      switch ((this as AppNetworkHttpException).statusCode) {
        case 400:
          return Strings.messageBadRequestError;
        case 401:
          return Strings.messageBadRequestError;
        case 403:
          return Strings.messageForbiddenError;
        case 404:
          return Strings.messageNotFoundError;
        case 500:
          return Strings.messageInternalServerError;
      }
    }
    Logger().w("localizedMessage => Default Exception");
    return Strings.messageUnknownError;
  }
}