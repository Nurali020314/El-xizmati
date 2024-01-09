import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../domain/util.dart';
import '../../gen/localization/strings.dart';

class ListAdPropertyWidget extends StatelessWidget {
  const ListAdPropertyWidget(
      {super.key, required this.adPropertyType, required this.isHorizontal});

  final AdPropertyStatus adPropertyType;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Color(0x28AEB2CD)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Strings.adStatusTitle
                .w(400)
                .s(isHorizontal ? 10 : 12)
                .c(Color(0xFF999CB2)),
            SizedBox(width: 2),
            switch (adPropertyType) {
              AdPropertyStatus.fresh => Strings.adStatusNew
                  .w(400)
                  .s(isHorizontal ? 10 : 12)
                  .c(Color(0xFF41455E)),
              AdPropertyStatus.used => Strings.adStatusOld
                  .w(400)
                  .s(isHorizontal ? 10 : 12)
                  .c(Color(0xFF41455E)),
            },
          ],
        ));
  }
}