import 'package:flutter/cupertino.dart';
import '../../../domain/model/ads/ad/ad_response.dart';
import 'ad_horizontal_widget.dart';

class AdGroupWidget extends StatelessWidget {
  const AdGroupWidget(
      {super.key,
      required this.ads,
      required this.onClick,
      required this.onClickFavorite});

  final List<AdResponse> ads;
  final Function(AdResponse result) onClick;
  final Function(AdResponse result) onClickFavorite;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 347,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: ads.length,
        padding: EdgeInsets.only(left: 16, bottom: 24, right: 16),
        itemBuilder: (context, index) {
          return AppAdHorizontalWidget(
            onClickFavorite: onClickFavorite,
            onClick: onClick,
            result: ads[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 16);
        },
      ),
    );
  }
}