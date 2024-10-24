import 'dart:ui';

import 'package:El_xizmati/core/enum/social_enum.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/ad/ad_action.dart';
import 'package:El_xizmati/domain/models/ad/ad_author_type.dart';
import 'package:El_xizmati/domain/models/ad/ad_transaction_type.dart';
import 'package:El_xizmati/domain/models/ad/ad_type.dart';
import 'package:El_xizmati/domain/models/ad/user_ad_status.dart';
import 'package:El_xizmati/domain/models/billing/billing_transaction_type.dart';
import 'package:El_xizmati/domain/models/currency/currency_code.dart';
import 'package:El_xizmati/domain/models/order/order_cancel_reason.dart';
import 'package:El_xizmati/domain/models/order/user_order.dart';
import 'package:El_xizmati/domain/models/order/user_order_status.dart';
import 'package:El_xizmati/domain/models/report/report_reason.dart';
import 'package:El_xizmati/domain/models/report/report_type.dart';

extension AdTransactionTypeResExts on AdTransactionType {
  String getLocalizedName() {
    switch (this) {
      case AdTransactionType.sell:
        return Strings.adTransactionTypeSell;
      case AdTransactionType.free:
        return Strings.adTransactionTypeFree;
      case AdTransactionType.exchange:
        return Strings.adTransactionTypeExchange;
      case AdTransactionType.service:
        return Strings.adTransactionTypeService;
      case AdTransactionType.buy:
        return Strings.adTransactionTypeBuy;
      case AdTransactionType.buy_service:
        return Strings.adTransactionTypeBuyService;
    }
  }

  String getTransactionTypeLocalizedName() {
    switch (this) {
      case AdTransactionType.sell:
        return Strings.orderListTypeSell;
      case AdTransactionType.free:
        return Strings.orderListTypeSell;
      case AdTransactionType.exchange:
        return Strings.orderListTypeSell;
      case AdTransactionType.service:
        return Strings.orderListTypeSell;
      case AdTransactionType.buy:
        return Strings.orderListTypeBuy;
      case AdTransactionType.buy_service:
        return Strings.orderListTypeBuy;
    }
  }

  Color getTransactionTypeColor() {
    switch (this) {
      case AdTransactionType.sell:
        return Color(0xFF0096B2);
      case AdTransactionType.free:
        return Color(0xFF0096B2);
      case AdTransactionType.exchange:
        return Color(0xFF0096B2);
      case AdTransactionType.service:
        return Color(0xFF0096B2);
      case AdTransactionType.buy:
        return Color(0xFFBEA039);
      case AdTransactionType.buy_service:
        return Color(0xFFBEA039);
    }
  }
}

extension AdTypeResExts on AdType {
  String getLocalizedName() {
    switch (this) {
      case AdType.product:
        return Strings.adTypeProductTitle;
      case AdType.service:
        return Strings.adTypeServiceTitle;
    }
  }
}

extension AdAuthorTypeResExts on AdAuthorType {
  String getLocalizedName() {
    switch (this) {
      case AdAuthorType.private:
        return Strings.adPropertyPersonal;
      case AdAuthorType.business:
        return Strings.adPropertyBiznes;
    }
  }
}

extension AdActionResExts on AdAction {
  SvgGenImage getActionIcon() {
    switch (this) {
      case AdAction.actionView:
        return Assets.images.icActionView;
      case AdAction.actionEdit:
        return Assets.images.icActionEdit;
      case AdAction.actionAdvertise:
        return Assets.images.icActionEdit;
      case AdAction.actionDeactivate:
        return Assets.images.icActionDeactivate;
      case AdAction.actionActivate:
        return Assets.images.icActionActivate;
      case AdAction.actionDelete:
        return Assets.images.icActionDelete;
    }
  }

  String getLocalizedName() {
    switch (this) {
      case AdAction.actionView:
        return Strings.userAdActionView;
      case AdAction.actionEdit:
        return Strings.actionEdit;
      case AdAction.actionAdvertise:
        return Strings.actionAdvertise;
      case AdAction.actionDeactivate:
        return Strings.actionDeactivate;
      case AdAction.actionActivate:
        return Strings.actionActivate;
      case AdAction.actionDelete:
        return Strings.actionDelete;
    }
  }
}

extension BillingTransactionTypeExtension on BillingTransactionType {
  String getTransactionTypeLocalizedName() {
    switch (this) {
      case BillingTransactionType.credit:
        return "Kredit";
      case BillingTransactionType.debit:
        return "Kirim";
      case BillingTransactionType.hold:
        return "Blockdagi mablag'";
      case BillingTransactionType.holdCard:
        return "Kartadagi blocklangan mablag'";
      case BillingTransactionType.holdCardCanceled:
        return "Kartadagi blocklangan mablag' yechildi";
      case BillingTransactionType.creditCard:
        return "Kredit karta";
      case BillingTransactionType.holdCanceled:
        return "Blocklangan mablag' yechildi";
    }
  }

  String getPaymentTypeLocalizedName() {
    switch (this) {
      case BillingTransactionType.credit:
        return "Kredit";
      case BillingTransactionType.debit:
        return "Debit karta";
      case BillingTransactionType.hold:
        return "Komissiya";
      case BillingTransactionType.holdCard:
        return "Kartadagi blocklangan mablag'";
      case BillingTransactionType.holdCardCanceled:
        return "Kartadagi blocklangan mablag' yechildi";
      case BillingTransactionType.creditCard:
        return "Kredit karta";
      case BillingTransactionType.holdCanceled:
        return "Blocklangan mablag' yechildi";
    }
  }

  Color getTypeColor() {
    switch (this) {
      case BillingTransactionType.credit:
        return Color(0xFF0060FE);
      case BillingTransactionType.debit:
        return Color(0xFF4BB16F);
      case BillingTransactionType.hold:
        return Color(0xFFF79500);
      case BillingTransactionType.holdCard:
        return Color(0xFFF79500);
      case BillingTransactionType.holdCardCanceled:
        return Color(0xFFFB577C);
      case BillingTransactionType.creditCard:
        return Color(0xFF4BB16F);
      case BillingTransactionType.holdCanceled:
        return Color(0xFFFB577C);
    }
  }

  Color getPriceColor() {
    switch (this) {
      case BillingTransactionType.debit:
        return Color(0xFF4BB16F);
      case BillingTransactionType.credit:
        return Color(0xFF0060FE);
      case BillingTransactionType.hold:
        return Color(0xFFF79500);
      case BillingTransactionType.holdCard:
        return Color(0xFFF79500);
      case BillingTransactionType.holdCardCanceled:
        return Color(0xFFFB577C);
      case BillingTransactionType.creditCard:
        return Color(0xFF4BB16F);
      case BillingTransactionType.holdCanceled:
        return Color(0xFFFB577C);
    }
  }
}

extension CurrencyExtension on CurrencyCode {
  String getLocalizedName() {
    switch (this) {
      case CurrencyCode.uzs:
        return Strings.currencyUzs;
      case CurrencyCode.usd:
        return Strings.currencyUsd;
      case CurrencyCode.eur:
        return Strings.currencyEuro;
      case CurrencyCode.rub:
        return Strings.currencyRuble;
    }
  }
}

extension UserAdStatusResExts on UserAdStatus {
  String getLocalizedName() {
    switch (this) {
      case UserAdStatus.ALL:
        return Strings.userAdsAll;
      case UserAdStatus.ACTIVE:
        return Strings.userAdsActive;
      case UserAdStatus.WAIT:
        return Strings.userAdsWait;
      case UserAdStatus.UNPAID:
        return Strings.userAdsWait;
      case UserAdStatus.INACTIVE:
        return Strings.userAdsInactive;
      case UserAdStatus.REJECTED:
        return Strings.userAdsRejected;
      case UserAdStatus.CANCELED:
        return Strings.userAdsCancelled;
      case UserAdStatus.SYS_CANCELED:
        return Strings.userAdsCancelled;
      case UserAdStatus.ARCHIVED:
        return Strings.userAdsInactive;
    }
  }

  String getLocalizedEmptyMessage() {
    switch (this) {
      case UserAdStatus.ALL:
        return Strings.adEmptyMessageAll;
      case UserAdStatus.ACTIVE:
        return Strings.adEmptyMessageActive;
      case UserAdStatus.WAIT:
        return Strings.adEmptyMessageWait;
      case UserAdStatus.UNPAID:
        return Strings.adEmptyMessageWait;
      case UserAdStatus.INACTIVE:
        return Strings.adEmptyMessageInactive;
      case UserAdStatus.REJECTED:
        return Strings.adEmptyMessageCancelled;
      case UserAdStatus.CANCELED:
        return Strings.adEmptyMessageCancelled;
      case UserAdStatus.SYS_CANCELED:
        return Strings.adEmptyMessageCancelled;
      case UserAdStatus.ARCHIVED:
        return Strings.adEmptyMessageInactive;
    }
  }

  Color getColor() {
    switch (this) {
      case UserAdStatus.ALL:
        return Color(0xFF010101);
      case UserAdStatus.ACTIVE:
        return Color(0xFF4BB16F);
      case UserAdStatus.WAIT:
        return Color(0xFF0060FE);
      case UserAdStatus.UNPAID:
        return Color(0xFF0060FE);
      case UserAdStatus.INACTIVE:
        return Color(0xFFF79500);
      case UserAdStatus.REJECTED:
        return Color(0xFFFB577C);
      case UserAdStatus.CANCELED:
        return Color(0xFFFB577C);
      case UserAdStatus.SYS_CANCELED:
        return Color(0xFFFB577C);
      case UserAdStatus.ARCHIVED:
        return Color(0xFFF79500);
    }
  }
}

extension UserOrderResExts on UserOrder {
  String getLocalizedCancelComment() {
    return OrderCancelReason.valurOrNull(cancelNote)?.getLocalizedName() ??
        cancelNote ??
        "";
  }
}

extension UserOrderStatusResExts on UserOrderStatus {
  String getLocalizedName() {
    switch (this) {
      case UserOrderStatus.ACCEPTED:
        return Strings.userOrderAccepted;
      case UserOrderStatus.ALL:
        return Strings.userOrderAll;
      case UserOrderStatus.ACTIVE:
        return Strings.userOrderActive;
      case UserOrderStatus.WAIT:
        return Strings.userOrderWait;
      case UserOrderStatus.INACTIVE:
        return Strings.userOrderInactive;
      case UserOrderStatus.REJECTED:
        return Strings.userOrderRejected;
      case UserOrderStatus.CANCELED:
        return Strings.userOrderCancelled;
      case UserOrderStatus.SYS_CANCELED:
        return Strings.userOrderCancelled;
      case UserOrderStatus.IN_PROGRESS:
        return Strings.userOrderInProgress;
    }
  }

  String getLocalizedEmptyMessage() {
    switch (this) {
      case UserOrderStatus.ACCEPTED:
        return Strings.orderEmptyMessageAccepted;
      case UserOrderStatus.ALL:
        return Strings.orderEmptyMessageAll;
      case UserOrderStatus.ACTIVE:
        return Strings.orderEmptyMessageAll;
      case UserOrderStatus.WAIT:
        return Strings.orderEmptyMessageWait;
      case UserOrderStatus.INACTIVE:
        return Strings.orderEmptyMessageAll;
      case UserOrderStatus.REJECTED:
        return Strings.orderEmptyMessageRejected;
      case UserOrderStatus.CANCELED:
        return Strings.orderEmptyMessageCancelled;
      case UserOrderStatus.SYS_CANCELED:
        return Strings.orderEmptyMessageCancelled;
      case UserOrderStatus.IN_PROGRESS:
        return Strings.orderEmptyMessageWait;
    }
  }

  Color color() {
    switch (this) {
      case UserOrderStatus.ACCEPTED:
        return Color(0xFF4BB16F);
      case UserOrderStatus.ALL:
        return Color(0xFF010101);
      case UserOrderStatus.ACTIVE:
        return Color(0xFF0060FE);
      case UserOrderStatus.WAIT:
        return Color(0xFFF79500);
      case UserOrderStatus.INACTIVE:
        return Color(0xFF010101);
      case UserOrderStatus.REJECTED:
        return Color(0xFFFB577C);
      case UserOrderStatus.CANCELED:
        return Color(0xFFFB577C);
      case UserOrderStatus.SYS_CANCELED:
        return Color(0xFFFB577C);
      case UserOrderStatus.IN_PROGRESS:
        return Color(0xFFF79500);
    }
  }
}

extension OrderCancelReasonExts on OrderCancelReason {
  String getLocalizedName() {
    return switch (this) {
      OrderCancelReason.SELLER_NOT_ANSWERED =>
        Strings.orderCancellationSellerNotAnswered,
      OrderCancelReason.CHANGED_IDEA => Strings.orderCancellationChangedIdea,
      OrderCancelReason.SELECTED_INCORRECTED_AD =>
        Strings.orderCancellationSelectedInfcorrectedAd,
      OrderCancelReason.OTHER_REASON => Strings.orderCancellationOtherReason,
    };
  }
}

extension ReportReasonExts on ReportReason {
  String getLocalizedName() {
    return switch (this) {
      ReportReason.SPAM => Strings.reportReasonSpam,
      ReportReason.FRAUD => Strings.reportReasonFraud,
      ReportReason.INSULT_OR_THREATS => Strings.reportReasonInsultOrThreats,
      ReportReason.PROHIBITED_GOODS_SERVICES =>
        Strings.reportReasonProhibitedGoodsServices,
      ReportReason.IRRELEVANT_ADS => Strings.reportReasonIrrelevantAds,
      ReportReason.PROHIBITED_SERVICE => Strings.reportReasonProhibitedService,
      ReportReason.INAPPROPRIATE_CONTENT =>
        Strings.reportReasonInappropriateContent,
      ReportReason.OTHER => Strings.reportReasonOther,
    };
  }
}

extension ReportTypeExts on ReportType {
  String getLocalizedPageTitle() {
    return switch (this) {
      ReportType.AD_BLOCK => Strings.reportAdsBlockTitle,
      ReportType.AD_REPORT => Strings.reportAdsReportTitle,
      ReportType.AUTHOR_BLOCK => Strings.reportUserBlockTitle,
      ReportType.AUTHOR_REPORT => Strings.reportUserReportTitle,
    };
  }

  String getLocalizedPageDesc() {
    return switch (this) {
      ReportType.AD_BLOCK => Strings.reportAdsBlockDesc,
      ReportType.AD_REPORT => Strings.reportAdsReportDesc,
      ReportType.AUTHOR_BLOCK => Strings.reportUserBlockDesc,
      ReportType.AUTHOR_REPORT => Strings.reportUserReportDesc,
    };
  }

  String getLocalizedAction() {
    return switch (this) {
      ReportType.AD_BLOCK => Strings.reportActionBlockAd,
      ReportType.AD_REPORT => Strings.reportActionSendReport,
      ReportType.AUTHOR_BLOCK => Strings.reportActionBlockUser,
      ReportType.AUTHOR_REPORT => Strings.reportActionSendReport,
    };
  }
}

extension SocialTypeExts on SocialType {
  String get linkTitle {
    return switch (this) {
      SocialType.instagram => Strings.profileSocialInstagramLinkTitle,
      SocialType.telegram => Strings.profileSocialTelegramLinkTitle,
      SocialType.facebook => Strings.profileSocialFacebookLinkTitle,
      SocialType.youtube => Strings.profileSocialYoutubeLinkTitle,
    };
  }

  String get openApp {
    return switch (this) {
      SocialType.instagram => Strings.profileSocialInstagramOpenApp,
      SocialType.telegram => Strings.profileSocialTelegramOpenApp,
      SocialType.facebook => Strings.profileSocialFacebookOpenApp,
      SocialType.youtube => Strings.profileSocialYoutubeOpenApp,
    };
  }

  String get firstStep {
    return switch (this) {
      SocialType.instagram => Strings.profileSocialInstagramStepFirst,
      SocialType.telegram => Strings.profileSocialTelegramStepFirst,
      SocialType.facebook => Strings.profileSocialFacebookStepFirst,
      SocialType.youtube => Strings.profileSocialYoutubeStepFirst,
    };
  }

  String get secondStep {
    return switch (this) {
      SocialType.instagram => Strings.profileSocialInstagramStepSecoond,
      SocialType.telegram => Strings.profileSocialTelegramStepSecond,
      SocialType.facebook => Strings.profileSocialFacebookStepSecond,
      SocialType.youtube => Strings.profileSocialYoutubeStepSecond,
    };
  }

  String get thirdStep {
    return switch (this) {
      SocialType.instagram => Strings.profileSocialInstagramStepThird,
      SocialType.telegram => Strings.profileSocialTelegramStepThird,
      SocialType.facebook => Strings.profileSocialFacebookStepThird,
      SocialType.youtube => Strings.profileSocialYoutubeStepThird,
    };
  }
}
