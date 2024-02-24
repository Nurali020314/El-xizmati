import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/assets/assets.gen.dart';
import '../../vibrator/vibrator_extension.dart';

class BottomSheetTitle extends StatelessWidget {
  const BottomSheetTitle({
    super.key,
    required this.title,
    required this.onCloseClicked,
  });

  final String title;
  final VoidCallback onCloseClicked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 16),
        Expanded(child: title.s(18).w(600)),
        IconButton(
          onPressed: () {
            onCloseClicked();
            vibrateAsHapticFeedback();
          },
          icon: Assets.images.icClose.svg(width: 24, height: 24),
        ),
        SizedBox(width: 6),
      ],
    );
  }
}