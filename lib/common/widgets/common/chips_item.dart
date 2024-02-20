import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';

import '../../gen/assets/assets.gen.dart';

class ChipsItem extends StatelessWidget {
  const ChipsItem({
    super.key,
    required this.item,
    required this.title,
    required this.onClicked,
  });

  final dynamic item;
  final String title;
  final Function(dynamic item) onClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onClicked(item);
          vibrateByTactile();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
            color: Color(0xFF7C2DFB),
            borderRadius: BorderRadius.all(Radius.circular(24)),
            shape: BoxShape.rectangle,
          ),
          child: Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                title
                    .w(500)
                    .s(16)
                    .c(Colors.white)
                    .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(width: 12),
                Assets.images.icCloseChip.svg(height: 20, width: 20),
              ],
            ),
          ),
        ));
  }
}
