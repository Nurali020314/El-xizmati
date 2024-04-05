import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';

import '../models/ad/ad_author_type.dart';
import '../models/ad/ad_item_condition.dart';
import '../models/ad/ad_priority_level.dart';
import '../models/ad/ad_transaction_type.dart';
import '../models/ad/ad_type.dart';
import '../models/currency/currency.dart';

extension StringAdMapper on String? {
  AdItemCondition toAdPropertyStatus() {
    return this?.contains("USED") == true
        ? AdItemCondition.used
        : AdItemCondition.fresh;
  }

  AdAuthorType toAdAuthorType() {
    return this?.contains("BUSINESS") == true
        ? AdAuthorType.business
        : AdAuthorType.private;
  }

  AdPriorityLevel toAdPriorityLevel() {
    return this?.contains("TOP") == true
        ? AdPriorityLevel.top
        : AdPriorityLevel.standard;
  }

  AdTransactionType toAdTypeStatus() {
    return AdTransactionType.values.firstWhere(
        (e) => e.name.toUpperCase() == this?.toUpperCase(),
        orElse: () => AdTransactionType.SELL);
  }

  UserAdStatus toUserAdStatus() {
    return UserAdStatus.values.firstWhere(
        (e) => e.name.toUpperCase() == this?.toUpperCase(),
        orElse: () => UserAdStatus.WAIT);
  }

  Currency toCurrency() {
    switch (this) {
      case "860":
        return Currency.uzb;
      case "643":
        return Currency.rub;
      case "840":
        return Currency.usd;
      case "978":
        return Currency.eur;
      default:
        return Currency.uzb;
    }
  }
}

extension AdPropertStatusToStringExtension on AdItemCondition {
  String adPropertyStatusToString() {
    switch (this) {
      case AdItemCondition.fresh:
        return "NEW";
      case AdItemCondition.used:
        return "USED";
    }
  }
}

extension AdRouteTypeToStringExtension on AdAuthorType {
  String adRouteTypeToString() {
    switch (this) {
      case AdAuthorType.business:
        return "PRIVATE";
      case AdAuthorType.private:
        return "BUSINESS";
    }
  }
}

extension AdStatusTypeToStringExtension on AdPriorityLevel {
  String adStatusToString() {
    switch (this) {
      case AdPriorityLevel.top:
        return "TOP";
      case AdPriorityLevel.standard:
        return "STANDARD";
    }
  }
}

extension AdTypeStatusToStringExtension on AdTransactionType {
  String adTypeStatusToString() {
    switch (this) {
      case AdTransactionType.SELL:
        return "SELL";
      case AdTransactionType.FREE:
        return "FREE";
      case AdTransactionType.EXCHANGE:
        return "EXCHANGE";
      case AdTransactionType.SERVICE:
        return "SERVICE";
      case AdTransactionType.BUY:
        return "BUY";
      case AdTransactionType.BUY_SERVICE:
        return "BUY_SERVICE";
    }
  }

  AdType adType() {
    switch (this) {
      case AdTransactionType.SELL:
        return AdType.product;
      case AdTransactionType.FREE:
        return AdType.product;
      case AdTransactionType.EXCHANGE:
        return AdType.product;
      case AdTransactionType.SERVICE:
        return AdType.service;
      case AdTransactionType.BUY:
        return AdType.product;
      case AdTransactionType.BUY_SERVICE:
        return AdType.service;
    }
  }
}

extension CurrencyToStringExtension on Currency {
  String currencyToString() {
    switch (this) {
      case Currency.eur:
        return "978";
      case Currency.usd:
        return "840";
      case Currency.rub:
        return "643";
      case Currency.uzb:
        return "860";
    }
  }
}

extension AdTypeExtension on AdType {
  String name() {
    switch (this) {
      case AdType.product:
        return "ADS";
      case AdType.service:
        return "SERVICE";
    }
  }
}
