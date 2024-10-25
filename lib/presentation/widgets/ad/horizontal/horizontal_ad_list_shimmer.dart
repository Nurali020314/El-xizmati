import 'package:flutter/material.dart';
import 'package:El_xizmati/presentation/widgets/ad/horizontal/horizontal_ad_shimmer.dart';

class HorizontalAdListShimmer extends StatelessWidget {
  const HorizontalAdListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 285,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 5,
          padding: EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (context, index) {
            return HorizontalAdShimmer();
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 8);
          },
        ),
      ),
    );
  }
}
