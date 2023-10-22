import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';

class CommonAppBar extends AppBar implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final String titleText;

  CommonAppBar(this.onBack, this.titleText, {super.key})
      : super(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          toolbarHeight: 64,
          title: titleText.w(400).c(Color(0xFF41455E)),
          leading: IconButton(
            onPressed: onBack,
            icon: Assets.images.icArrowLeft.svg(),
          ),
        );
}