import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/data/responses/transaction/payment_transaction_response.dart';

import '../../constants.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.transaction,
  });

  final PaymentTransactionResponse transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                width: 1,
                color: Color(0xFFDFE2E9),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: Constants.baseUrlForImage,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) => Center(),
              errorWidget: (context, url, error) =>
                  Center(child: Assets.images.icPaymentTransactionWallet.svg()),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              transaction.type.w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 13),
              transaction.pay_date.w(500).s(12).c(Color(0xFF9EABBE))
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              transaction.amount.toString().w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 9),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: transaction.pay_status.w(500).s(10).c(Color(0xFF32B88B)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
