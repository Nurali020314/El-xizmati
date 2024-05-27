import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';

class UserAddressSelection extends StatelessWidget {
  const UserAddressSelection({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onClicked,
  });

  final UserAddress address;
  final bool isSelected;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.only(left: 12, top: 12, right: 12),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(width: 1, color: context.cardStrokeColor),
      ),
      child: InkWell(
        onTap: () {
          onClicked();
        },
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: (address.name ?? "")
                            .w(600)
                            .s(16)
                            .c(Color(0xFF41455E))
                            .copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      Row(
                        children: [
                          Visibility(
                            visible: address.isMain,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Color(0xFFF6B712),
                              ),
                              child: Strings.commonMain
                                  .w(600)
                                  .s(12)
                                  .c(Colors.white),
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 13),
                  Strings.userAddressAddress
                      .s(14)
                      .w(400)
                      .c(context.textSecondary),
                  SizedBox(height: 5),
                  address.fullAddress.w(500).s(12).c(Color(0xFF41455E)),
                  SizedBox(height: 12),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: (isSelected
                        ? Assets.images.icRadioButtonSelected
                        : Assets.images.icRadioButtonUnSelected)
                    .svg(height: 20, width: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}