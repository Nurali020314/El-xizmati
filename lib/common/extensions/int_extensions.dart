import 'package:onlinebozor/common/constants.dart';

import '../../domain/model/ad_enum.dart';

extension IntExtensions on int {
  String priceToFormatWithCurrency(Currency currency) {
    return "${Constants.formatter.format(this).replaceAll(',', ' ')} ${currency.name}";
  }

  String priceFromToFormatWithCurrency(Currency currency, int toPrice) {
    return "${Constants.formatter.format(this).replaceAll(',', ' ')}-${{
      Constants.formatter.format(this).replaceAll(',', ' ')
    }} ${currency.name}";
  }
}
