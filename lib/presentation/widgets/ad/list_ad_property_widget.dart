import 'package:flutter/cupertino.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/ad/ad_item_condition.dart';

class ListAdPropertyWidget extends StatelessWidget {
  const ListAdPropertyWidget(
      {super.key, required this.adPropertyType, required this.isHorizontal});

  final AdItemCondition adPropertyType;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0x28AEB2CD),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          switch (adPropertyType) {
            AdItemCondition.fresh => Strings.adStatusNew,
            AdItemCondition.used => Strings.adStatusOld
          }
              .w(400)
              .s(isHorizontal ? 12 : 12)
              .c(context.textTertiary),
        ],
      ),
    );
  }
}
