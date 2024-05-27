import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';

import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';

class SearchAppBar extends AppBar implements PreferredSizeWidget {
  final VoidCallback onSearchClicked;
  final VoidCallback onMicrophoneClicked;
  final VoidCallback onFavoriteClicked;
  final VoidCallback onNotificationClicked;

  @override
  final Color backgroundColor;

  SearchAppBar({
    super.key,
    required this.onSearchClicked,
    required this.onMicrophoneClicked,
    required this.onFavoriteClicked,
    required this.onNotificationClicked,
    required this.backgroundColor,
  }) : super(
          backgroundColor: backgroundColor,
          elevation: 0.5,
          toolbarHeight: 72,
          actions: [
            _getSearchBar(onSearchClicked),
            _getFavoriteAction(onFavoriteClicked),
            _getNotificationAction(onNotificationClicked),
          ],
        );

  static Expanded _getSearchBar(VoidCallback? onSearchClicked) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
        child: InkWell(
          onTap: onSearchClicked,
          child: Container(
            width: double.maxFinite,
            height: 42,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: onSearchClicked,
                  child: Assets.images.iconSearch.svg(),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: onSearchClicked,
                    child: Strings.adSearchHint
                        .w(400)
                        .s(14)
                        .c(Color(0xFFA8A8A8))
                        .copyWith(overflow: TextOverflow.ellipsis),
                  ),
                ),
                // InkWell(
                //   onTap: onMicrophoneClicked,
                //   child: Assets.images.icMic.svg(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static IconButton _getFavoriteAction(VoidCallback onFavoriteClicked) {
    return IconButton(
      onPressed: () {
        onFavoriteClicked();
        vibrateAsHapticFeedback();
      },
      icon: Assets.images.bottomBar.favorite.svg(),
    );
  }

  static IconButton _getNotificationAction(VoidCallback onNotificationClicked) {
    return IconButton(
      onPressed: () {
        onNotificationClicked();
        vibrateAsHapticFeedback();
      },
      icon: Assets.images.icNotification.svg(color: Color(0xFF5C6AC4)),
    );
  }
}