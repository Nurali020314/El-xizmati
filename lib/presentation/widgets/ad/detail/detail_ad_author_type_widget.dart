import 'package:flutter/cupertino.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/ad/ad_author_type.dart';

class DetailAdAuthorTypeWidget extends StatelessWidget {
  const DetailAdAuthorTypeWidget({super.key, required this.adAuthorType});

  final AdAuthorType adAuthorType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: switch (adAuthorType) {
          AdAuthorType.private => Color(0x28AEB2CD),
          AdAuthorType.business => Color(0x1E6546E7),
        },
      ),
      child: switch (adAuthorType) {
        AdAuthorType.private =>
          Strings.adPropertyPersonal.w(400).s(14).c(Color(0xFF999CB2)),
        AdAuthorType.business =>
          Strings.adPropertyBiznes.w(400).s(14).c(Color(0xFF6546E7)),
      },
    );
  }
}
