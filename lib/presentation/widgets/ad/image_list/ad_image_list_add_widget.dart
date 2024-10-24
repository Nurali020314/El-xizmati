import 'package:flutter/material.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:flutter/services.dart';

class AdImageListAddWidget extends StatelessWidget {
  const AdImageListAddWidget({
    super.key,
    required this.index,
    required this.onAddClicked,
  });

  final int index;
  final Function() onAddClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: ValueKey(index),
      onTap: () {
        onAddClicked();
        HapticFeedback.lightImpact();
      },
      child: Container(
        height: 82,
        width: 96,
        decoration: BoxDecoration(
          color: Color(0XFFFBFAFF),
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Color(0xFFDFE2E9),
            width: 1,
          ),
        ),
        child: Center(
          child: Assets.images.icAddImage.svg(height: 36, width: 36),
        ),
      ),
    );
  }
}
