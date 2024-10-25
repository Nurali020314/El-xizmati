import 'package:flutter/material.dart';

import '../../../../domain/models/ad/ad.dart';
import 'horizontal_ad_widget.dart';

class HorizontalAdListWidget extends StatelessWidget {
  const HorizontalAdListWidget({
    super.key,
    required this.ads,
    required this.onItemClicked,
    required this.onFavoriteClicked,
    required this.onCartClicked,
    required this.onBuyClicked,
  });

  final List<Ad> ads;
  final Function(Ad ad) onItemClicked;
  final Function(Ad ad) onFavoriteClicked;
  final Function(Ad ad) onCartClicked;
  final Function(Ad ad) onBuyClicked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: ads.length,
          padding: EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (context, index) {
            return HorizontalAdWidget(
              ad: ads[index],
              onItemClicked: onItemClicked,
              onFavoriteClicked: onFavoriteClicked,
              onCartClicked: onCartClicked,
              onBuyClicked: onBuyClicked,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 8);
          },
        ),
      ),
    );
  }
}
