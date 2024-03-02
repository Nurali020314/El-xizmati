import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/ad/list_price_text_widget.dart';
import 'package:onlinebozor/common/widgets/favorite/ad_favorite_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/models/ad/ad.dart';
import '../../constants.dart';

class TopRatedAdWidgetShimmer extends StatelessWidget {
  const TopRatedAdWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      padding: EdgeInsets.only(left: 12, top: 12, right: 0),
      decoration: _getBackgroundGradient(),
      child: InkWell(
          onTap: () {
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _getAdImageWidget(),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: 8),
                         Shimmer.fromColors(
                           baseColor: Color(0xFFE8E6E8),
                           highlightColor: Colors.grey[50]!,
                           child: Container(height: 15,width: 120,
                             decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.circular(7)
                             ),),
                         ),
                        SizedBox(height: 8),
                        Shimmer.fromColors(
                          baseColor: Color(0xFFE8E6E8),
                          highlightColor: Colors.grey[50]!,
                          child: Container(height: 15,width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7)
                            ),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                ],
              ),
              Shimmer.fromColors(
                baseColor: Color(0xFFE8E6E8),
                highlightColor: Colors.grey[50]!,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 26,width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget _getAdImageWidget() {
    return SizedBox(
      width: 72,
      height: 72,
      child: Shimmer.fromColors(
        baseColor: Color(0xFFE8E6E8),
        highlightColor: Colors.grey[50]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );
  }
  Decoration _getBackgroundGradient() {
    return ShapeDecoration(
      gradient: LinearGradient(
        begin: Alignment(0, -1),
        end: Alignment(1, 1),
        colors: const [Color(0xFF9570FF), Color(0xFFF0C49A)],
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.50, color: Color(0xFFB9A0FF)),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

}
