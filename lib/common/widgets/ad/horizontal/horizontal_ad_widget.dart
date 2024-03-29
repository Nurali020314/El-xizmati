import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/ad/ad_status_widget.dart';
import 'package:onlinebozor/common/widgets/ad/ad_type_widget.dart';
import 'package:onlinebozor/common/widgets/ad/list_ad_author_type_widget.dart';
import 'package:onlinebozor/common/widgets/ad/list_ad_property_widget.dart';
import 'package:onlinebozor/common/widgets/ad/list_price_text_widget.dart';
import 'package:onlinebozor/common/widgets/ad/view_count_widget.dart';
import 'package:onlinebozor/common/widgets/favorite/ad_favorite_widget.dart';
import 'package:onlinebozor/domain/mappers/ad_enum_mapper.dart';

import '../../../../domain/models/ad/ad.dart';
import '../../../../domain/models/ad/ad_priority_level.dart';
import '../../../constants.dart';
import '../../../gen/assets/assets.gen.dart';

class HorizontalAdWidget extends StatelessWidget {
  const HorizontalAdWidget({
    super.key,
    required this.onFavoriteClicked,
    required this.onItemClicked,
    required this.ad,
  });

  final Ad ad;
  final Function(Ad ad) onItemClicked;
  final Function(Ad ad) onFavoriteClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClicked(ad);
      },
      child: SizedBox(
        height: 342,
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(color: Color(0xFFF6F7FC)),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: "${Constants.baseUrlForImage}${ad.photo}",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.colorBurn,
                          ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Center(),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                  AppAdStatusWidget(adStatus: AdPriorityLevel.standard),
                  Align(
                    alignment: Alignment.topRight,
                    child: AdFavoriteWidget(
                      isSelected: ad.favorite,
                      invoke: () => onFavoriteClicked(ad),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: AdTypeWidget(
                      adType: ad.adTypeStatus.adType(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ViewCountWidget(viewCount: ad.view),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 32,
              child: (ad.name)
                  .w(400)
                  .s(13)
                  .c(context.colors.textPrimary)
                  .copyWith(maxLines: 2)
                  .copyWith(maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            SizedBox(height: 6),
            ListPriceTextWidget(
              price: ad.price,
              toPrice: ad.toPrice,
              fromPrice: ad.fromPrice,
              currency: ad.currency,
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Assets.images.icLocation.svg(width: 12, height: 12),
                SizedBox(width: 4),
                Expanded(
                  child: "${ad.region} ${ad.district}"
                      .w(400)
                      .s(12)
                      .c(context.colors.textSecondary)
                      .copyWith(
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListAdAuthorTypeChipWidget(
                  isHorizontal: true,
                  adAuthorType: ad.adRouteType,
                ),
                SizedBox(width: 2),
                ListAdPropertyWidget(
                  isHorizontal: true,
                  adPropertyType: ad.adPropertyStatus,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}