import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';

import '../../gen/assets/assets.gen.dart';

class CardEmptyWidget extends StatelessWidget {
  const CardEmptyWidget({super.key, required this.onActionClicked});

  final VoidCallback onActionClicked;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 120),
            Assets.images.pngImages.cardEmpty.image(),
            SizedBox(height: 48),
            Strings.cardEmptyTitle.w(500).s(16).c(Color(0xFF41455E)).copyWith(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start),
            SizedBox(height: 12),
            Strings.cardEmptyDescripton
                .w(400)
                .s(12)
                .c(Color(0xFF41455E))
                .copyWith(
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
            SizedBox(height: 42),
            CustomElevatedButton(
              buttonWidth: double.infinity,
              text: Strings.cardAddCardTitle,
              onPressed: () => onActionClicked,
            )
          ],
        ),
      ),
    );
  }
}
