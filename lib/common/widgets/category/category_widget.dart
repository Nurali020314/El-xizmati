import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../data/responses/category/category/category_response.dart';
import '../../enum/enums.dart';
import '../../gen/assets/assets.gen.dart';

class AppCategoryWidget extends StatelessWidget {
  const AppCategoryWidget({
    super.key,
    required this.onClicked,
    required this.category,
    this.isDisableAmount = false,
    this.loadingState,
  });

  final Function(CategoryResponse category) onClicked;
  final CategoryResponse category;
  final bool isDisableAmount;
  final LoadingState? loadingState;

  @override
  Widget build(BuildContext context) {
    if (loadingState==LoadingState.loading) {
      return aaa();
    } else {
      return appCategoty(context);
    }
  }

  Widget appCategoty(BuildContext context) {
    return InkWell(
        onTap: () {
          onClicked(category);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                width: 20,
                height: 20,
                imageUrl:
                    "https://api.online-bozor.uz/uploads/images/${category.icon}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        colorFilter: ColorFilter.mode(
                            Color(0xFFF6F7FC), BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) => Center(),
                errorWidget: (context, url, error) => Center(),
              ),
              // Assets.images.icArrowRight.svg(height: 16, width: 16),
              SizedBox(width: 16),
              Expanded(
                  child: Row(
                children: [
                  (category.name ?? "*")
                      .toString()
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimary)
                      .copyWith(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  Expanded(
                      child: category.amount != null && category.amount != 0
                          ? '(${category.amount})'
                              .w(600)
                              .s(14)
                              .c(Colors.black)
                              .copyWith(
                                  overflow: TextOverflow.ellipsis, maxLines: 1)
                          : SizedBox())
                ],
              )),
              Assets.images.icArrowRight.svg(height: 16, width: 16)
            ],
          ),
        ));
  }

  Widget aaa() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 20,
            width: 20,
            color: Colors.amber,
          ),
          // Assets.images.icArrowRight.svg(height: 16, width: 16),
          SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 10,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
