import 'package:flutter/material.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';

class AdEmptyWidget extends StatelessWidget {
  const AdEmptyWidget({super.key, required this.onClicked});

  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Assets.images.pngImages.adEmpty.image(),
            SizedBox(height: 48),
            Strings.adEmptyMessageAll
                .w(500)
                .s(16)
                .c(context.textPrimary)
                .copyWith(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start),
            SizedBox(height: 12),
            SizedBox(height: 42),
            SizedBox(
              width: double.maxFinite,
              child: CustomElevatedButton(
                backgroundColor: context.colors.buttonPrimary,
                onPressed: onClicked,
                rightIcon: Icon(Icons.add),
                text: Strings.adCreationTitle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
