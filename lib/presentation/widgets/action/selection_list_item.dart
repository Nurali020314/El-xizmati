import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';

import 'package:onlinebozor/core/gen/assets/assets.gen.dart';

class SelectionListItem extends StatelessWidget {
  const SelectionListItem({
    super.key,
    required this.item,
    required this.title,
    required this.isSelected,
    required this.onClicked,
  });

  final dynamic item;
  final String title;
  final bool isSelected;
  final Function(dynamic item) onClicked;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onClicked(item);
          vibrateAsHapticFeedback();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: (title)
                    .toString()
                    .w(500)
                    .s(16)
                    .c(context.textPrimary)
                    .copyWith(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              SizedBox(width: 12),
              (isSelected
                      ? Assets.images.icRadioButtonSelected
                      : Assets.images.icRadioButtonUnSelected)
                  .svg(height: 20, width: 20),
            ],
          ),
        ),
      ),
    );
  }
}