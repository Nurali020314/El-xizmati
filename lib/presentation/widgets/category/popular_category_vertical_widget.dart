import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/widgets/image/circle_cached_network_image_widget.dart';

import '../../../data/datasource/network/responses/category/popular_category/popular_category_response.dart';

class PopularCategoryVerticalWidget extends StatelessWidget {
  const PopularCategoryVerticalWidget({
    super.key,
    required this.category,
    required this.onClicked,
  });

  final PopularCategory category;
  final Function(PopularCategory category) onClicked;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onClicked(category);
        },
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 16, 16, 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleCachedNetworkImage(
                imageId: category.icon ?? "",
                width: 64,
                height: 64,
              ),
              SizedBox(width: 10),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _getCategoryNameAsString(category),
                    SizedBox(height: 4),
                    _getAdsCountAsString(category)
                  ],
                ),
              ),
              SizedBox(width: 8),
              Container(
                width: 28,
                height: 28,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0x7EDFE2E9),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                ),
                child: Assets.images.icArrowRight.svg(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Decoration _getImageDecoration(ImageProvider<Object> imageProvider) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Color(0xFFF6F7FC),
          BlendMode.colorBurn,
        ),
      ),
    );
  }

  Widget _getCategoryNameAsString(PopularCategory category) {
    return (category.name ?? "*").w(600).s(14).copyWith(
          textAlign: TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );
  }

  Widget _getAdsCountAsString(PopularCategory category) {
    String adsCount = "";
    if (category.total != null) {
      adsCount = "${category.total?.toString()} ${Strings.categoryAdsCount}";
    }

    return adsCount.w(400).s(14).copyWith(
          textAlign: TextAlign.start,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
  }
}
