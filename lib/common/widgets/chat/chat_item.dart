import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 42,
                height: 42,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFFDFE2E9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: "https://api.online-bozor.uz/uploads/images/}",
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
                  placeholder: (context, url) =>
                      Center(),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
                ),
              ),
              SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Техно-ID".w(600).s(14).c(Color(0xFF41455E)),
                      "11:23".w(500).s(10).c(Color(0xFF9EABBE))
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  "Планшет Samsung Galaxy Tab A 8.0 SM-T2 S..."
                      .w(400)
                      .s(10)
                      .c(Color(0xFF9EABBE))
                      .copyWith(overflow: TextOverflow.ellipsis, maxLines: 1),
                ],
              )
            ]),
      ),
    );
  }
}