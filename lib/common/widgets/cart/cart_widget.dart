import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';

import '../../../domain/models/ad.dart';
import '../../../domain/util.dart';
import '../../constants.dart';
import '../../gen/assets/assets.gen.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.invokeAdd,
    required this.invokeMinus,
    required this.invokeDelete,
    required this.invokeFavoriteDelete,
    required this.ad,
    required this.invoke,
  });

  //
  final Ad ad;
  final Function(Ad ad) invokeAdd;
  final Function(Ad ad) invoke;

  final Function(Ad ad) invokeMinus;
  final Function(Ad ad) invokeDelete;
  final Function(Ad ad) invokeFavoriteDelete;

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,000');
    Widget liked(bool isLiked) {
      if (isLiked) {
        return Assets.images.icLike.svg(color: Colors.red);
      } else {
        return Assets.images.icLike.svg();
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // SizedBox(
          //   width: 24,
          //   height: 24,
          //   child: Theme(
          //     data: ThemeData(
          //       checkboxTheme: CheckboxThemeData(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(
          //               6), // Set the desired border radius
          //         ),
          //       ),
          //     ),
          //     child: Checkbox(
          //       value: false,
          //       onChanged: (bool? value) {
          //         // context.read<CartCubit>().checkBoxClick();
          //       },
          //     ),
          //   ),
          // ),
          Container(
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                color: Color(0xFFF6F7FC),
              ),
              child: CachedNetworkImage(
                imageUrl: "${Constants.baseUrlForImage}${ad.photo}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white, BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) => Center(),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              )),
          SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                ad.name
                    .w(500)
                    .s(14)
                    .c(Color(0xFF41455E))
                    .copyWith(overflow: TextOverflow.ellipsis, maxLines: 2),
                SizedBox(height: 15),
                if (ad.price == 0)
                  "${formatter.format(ad.fromPrice).replaceAll(',', ' ')}-${formatter.format(ad.toPrice).replaceAll(',', ' ')} ${Currency.uzb.getName}"
                      .w(700)
                      .s(15)
                      .c(Color(0xFF5C6AC3))
                      .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis)
                else
                  "${formatter.format(ad.price).replaceAll(',', ' ')} ${Currency.uzb.getName}"
                      .w(700)
                      .s(15)
                      .c(Color(0xFF5C6AC3))
                      .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 12),
                Spacer(),
                Row(
                  children: [
                    InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: () {
                          invokeFavoriteDelete(ad);
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    width: 1, color: Color(0xFFDFE2E9))),
                            height: 28,
                            width: 28,
                            child: liked(ad.favorite))),
                    SizedBox(width: 8),
                    InkWell(
                        onTap: () {
                          invokeDelete(ad);
                        },
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    width: 1, color: Color(0xFFDFE2E9))),
                            height: 28,
                            width: 28,
                            child: Assets.images.icDelete.svg())),
                    Spacer(),
                    CommonButton(
                        onPressed: () {
                          invoke(ad);
                        },
                        child: "Оформить".w(500).s(13).c(Color(0xFFDFE2E9))),
                    // Spacer(),
                    // Container(
                    //     padding: EdgeInsets.all(6),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(6),
                    //         border:
                    //             Border.all(width: 1, color: Color(0xFFDFE2E9))),
                    //     child: Row(
                    //       children: [
                    //         InkWell(
                    //             borderRadius: BorderRadius.circular(6),
                    //             onTap: () {},
                    //             child: Icon(Icons.remove, size: 16)),
                    //         SizedBox(width: 15),
                    //         "10".w(600),
                    //         SizedBox(width: 15),
                    //         InkWell(
                    //             borderRadius: BorderRadius.circular(6),
                    //             onTap: () {},
                    //             child: Icon(Icons.add, size: 16)),
                    //       ],
                    //     )),
                  ],
                )
              ])),
        ],
      ),
    );
  }
}
