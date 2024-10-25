import 'package:flutter/material.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';

import 'package:flutter/services.dart';

class AdDetailFavoriteWidget extends StatefulWidget {
  const AdDetailFavoriteWidget({
    super.key,
    required this.isFavorite,
    required this.onClicked,
  });

  final bool isFavorite;
  final VoidCallback onClicked;

  @override
  State<StatefulWidget> createState() => _AdFavoriteWidget();
}

class _AdFavoriteWidget extends State<AdDetailFavoriteWidget> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onClicked();
        setState(() {
          _isFavorite = !_isFavorite;
        });
        HapticFeedback.lightImpact();
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 48,
        width: 48,
        child: _isFavorite
            ? Assets.images.icFavoriteRemoveDetail.svg()
            : Assets.images.icFavoriteAddDetail.svg(),
      ),
    );
  }
}
