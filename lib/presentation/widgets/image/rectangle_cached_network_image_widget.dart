import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/core/cache/CustomCacheManager.dart';
import 'package:El_xizmati/data/datasource/network/constants/constants.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';

class RectangleCachedNetworkImage extends StatelessWidget {
  final String imageId;
  final double? height;
  final double? width;
  final Widget? placeHolderIcon;
  final Widget? errorIcon;

  const RectangleCachedNetworkImage({
    super.key,
    required this.imageId,
    this.width,
    this.height,
    this.placeHolderIcon,
    this.errorIcon,
  });

  @override
  Widget build(BuildContext context) {
    var actualUrl = imageId.contains("https://") || imageId.contains("http://")
        ? imageId
        : "${Constants.baseUrlForImage}$imageId";

    return CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: actualUrl,
        cacheManager: CustomCacheManager.imageCacheManager,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                // colorFilter: ColorFilter.mode(
                //   Colors.white,
                //   BlendMode.colorBurn,
                // ),
              ),
            ),
          );
        },
        placeholder: (context, url) {
          // Logger().w("RectangleCachedNetworkImage url = $actualUrl");
          return Container(
            decoration: BoxDecoration(color: context.cardColor),
            child: placeHolderIcon != null
                ? Center(child: placeHolderIcon)
                : Center(),
          );
        },
        errorWidget: (context, url, error) {
          // Logger().w("RectangleCachedNetworkImage error = $error");
          return Container(
            decoration: BoxDecoration(color: context.cardColor),
            child: errorIcon != null ? Center(child: errorIcon) : Center(),
          );
        });
  }
}
