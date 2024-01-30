import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../domain/models/currency/currency.dart';
import '../../gen/localization/strings.dart';

class ListPriceTextWidget extends StatelessWidget {
  ListPriceTextWidget({
    super.key,
    required this.price,
    required this.toPrice,
    required this.fromPrice,
    required this.currency,
    this.color,
  });

  final int price;
  final int toPrice;
  final int fromPrice;
  final Currency currency;
  Color? color;

  // var customSymbols = NumberSymbols(
  //     NAME: 'custom',
  //     DECIMAL_SEP: ',', // Custom decimal separator
  //     GROUP_SEP: '.',   // Custom grouping separator
  //     // PERCENT: '%',
  //     // ZERO_DIGIT: '0',
  //     // PLUS_SIGN: '+',
  //     // MINUS_SIGN: '-',
  //     // EXP_SYMBOL: 'e',
  //     // PERMILL: '\u2030',
  //     // INFINITY: '\u221e',
  //     // NAN: 'NaN',
  //     // DECIMAL_PATTERN: '#,##0.###',
  //     // SCIENTIFIC_PATTERN: '#E0',
  //     // PERCENT_PATTERN: '#,##0%',
  //     // CURRENCY_PATTERN: '¤#,##0.00',
  //     // DEF_CURRENCY_CODE: 'USD'
  // );

  var f = NumberFormat('###,000');

  @override
  Widget build(BuildContext context) {
    String priceStr = (price == 0)
        ? Strings.priceFrom(price: "${f.format(fromPrice)} ${currency.getName}")
        : "${f.format(price)} ${currency.getName}";

    return priceStr
        .replaceAll(',', ' ')
        .w(800)
        .s(13)
        .c(color != null ? color! : Color(0xFF5C6AC3))
        .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis);
  }
}